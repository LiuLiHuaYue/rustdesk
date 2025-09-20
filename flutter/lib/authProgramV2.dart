import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart' as pc;
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:window_manager/window_manager.dart';

const String serverAddress = "http://124.222.93.30:20205";
const String serverPublicKeyPem = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtuPtnoXpblTtyeDHLW3N
jttscN9Kq4mYFq8V1Kish664iskDlVZMHJEj4DxcrNU0o2Ggx0Vdl7/2uCl5n3sa
85P7NxxR8P7sZWr/ZqsKI7ZQKUwp6oSTrdZ2l7QQ64Gh6m1f51slTTdN6BZs3dws
hCKwnNC8ejdtIvyOe02zFVOa8+HYTzkOhm5j4KgRp1lrmfYAQ00kzv6HcMuoArs+
Bbf+Sv2tEnRvDXk/VowF/Pq/Uyf8Sv56BgrNkrfUYbjaZF9HTkacutiWG6FjSRwt
WSZ0Dw8rA+0UyD13AFdA6xB4/3Ge5iJjdE9ptv5s4bMmUJfuibKpxqg93pux//MC
pQIDAQAB
-----END PUBLIC KEY-----
''';
const String sellerInfo = '杜小白';

pc.RSAPublicKey _loadServerPublicKeyFromPemString(String pemString) {
  final parser = encrypt_lib.RSAKeyParser();
  return parser.parse(pemString) as pc.RSAPublicKey;
}

Uint8List _generateClientAesKey() {
  return encrypt_lib.Key.fromSecureRandom(16).bytes;
}

Uint8List _encryptClientAesKeyWithRsa(
    Uint8List clientAesKey,
    pc.RSAPublicKey serverPublicKey,
    ) {
  final rsaEngine = pc.RSAEngine();
  final oaepEncoding = pc.OAEPEncoding.withSHA256(rsaEngine);

  final keyParams = pc.PublicKeyParameter<pc.RSAPublicKey>(serverPublicKey);
  oaepEncoding.init(true, keyParams);

  final encryptedBytes = oaepEncoding.process(clientAesKey);
  return Uint8List.fromList(encryptedBytes);
}

Uint8List _encryptWithAes(Uint8List plainDataBytes, Uint8List aesKey) {
  final encrypterKey = encrypt_lib.Key(aesKey);
  final iv = encrypt_lib.IV.fromSecureRandom(16);
  final encrypter = encrypt_lib.Encrypter(
    encrypt_lib.AES(
      encrypterKey,
      mode: encrypt_lib.AESMode.cbc,
      padding: 'PKCS7',
    ),
  );
  final encrypted = encrypter.encryptBytes(plainDataBytes, iv: iv);
  return Uint8List.fromList(iv.bytes + encrypted.bytes);
}

Uint8List _decryptWithAes(Uint8List encryptedDataBytes, Uint8List aesKey) {
  final encrypterKey = encrypt_lib.Key(aesKey);
  final iv = encrypt_lib.IV(encryptedDataBytes.sublist(0, 16));
  final ciphertext = encryptedDataBytes.sublist(16);

  final encrypter = encrypt_lib.Encrypter(
    encrypt_lib.AES(
      encrypterKey,
      mode: encrypt_lib.AESMode.cbc,
      padding: 'PKCS7',
    ),
  );

  final decrypted = encrypter.decryptBytes(
    encrypt_lib.Encrypted(ciphertext),
    iv: iv,
  );
  return Uint8List.fromList(decrypted);
}

Future<String> generateUniqueFeatureCode() async {
  final deviceInfo = DeviceInfoPlugin();
  String rawId = '';

  try {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      rawId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      rawId = iosInfo.identifierForVendor ?? '';
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      rawId = windowsInfo.deviceId;
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      rawId = '${linuxInfo.machineId}-${linuxInfo.prettyName}';
    } else if (Platform.isMacOS) {
      final macInfo = await deviceInfo.macOsInfo;
      rawId = macInfo.systemGUID ?? '';
    } else {
      rawId = 'unsupported-platform';
    }
  } catch (e) {
    rawId = 'error-getting-id';
  }

  final bytes = utf8.encode(rawId);
  final digest = sha256.convert(bytes);
  return base64Url.encode(digest.bytes);
}

class AuthServiceV2 {
  static Future<String> Function(String key) getOptionCallback = (key) async =>
      "";
  static Future<void> Function(String key, String value) setOptionCallback =
      (key, value) async {};
  static Timer? _heartbeatTimer;
  static bool _heartbeatStarted = false;
  static int _currentHeartbeatRate = 300;

  static void startHeartbeat(int heartbeatRate) {
    if (_heartbeatStarted && _currentHeartbeatRate == heartbeatRate) {
      return;
    }
    _heartbeatTimer?.cancel();
    _heartbeatStarted = false;
    _currentHeartbeatRate = heartbeatRate;
    if (heartbeatRate == 0) {
      return;
    }
    _heartbeatStarted = true;
    _heartbeatTimer = Timer.periodic(Duration(seconds: heartbeatRate), (
        timer,
        ) async {
      final activated = await verify();
      if (!activated) {
        exit(0);
      }
    });
  }
  
  static void setCallbacks({
    required Future<String> Function(String key) getOption,
    required Future<void> Function(String key, String value) setOption,
  }) {
    getOptionCallback = getOption;
    setOptionCallback = setOption;
  }

  static Future<void> saveAuthKey(String key) async {
    try {
      await setOptionCallback('authKey', key);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> loadAuthKey() async {
    try {
      return await getOptionCallback('authKey') ?? "";
    } catch (e) {
      return "";
    }
  }

  static Future<bool> showGlobalActivationDialog() async {
    final uid = (await generateUniqueFeatureCode()).trim();
    final authKey = (await loadAuthKey()).trim();
    final completer = Completer<bool>();

    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = WindowOptions(
        size: Size(800, 600),
        center: true,
        title: "激活使用",
        titleBarStyle: TitleBarStyle.normal,
      );
      await windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
        windowManager.setOpacity(1);
      });
    }

    runApp(
      MaterialApp(
        builder: (context, child) {
          Widget result = child!;
          if (Platform.isLinux) {
            result = MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: result,
            );
          }
          return BotToastInit()(context, result);
        },
        home: Scaffold(
          body: ActivationDialog(
            uid: uid,
            authKey: authKey,
            completer: completer,
          ),
        ),
      ),
    );

    final success = await completer.future;

    if (!success) {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        await windowManager.close();
      }
      exit(0);
    }
    return success;
  }

  static Future<bool> verify() async {
    String uid = '';
    String authKey = '';

    try {
      uid = (await generateUniqueFeatureCode()).trim();
      authKey = (await loadAuthKey()).trim();
      if (authKey.isEmpty) {
        return false;
      } else {
        final result = await _checkActivation(uid, authKey);
        final activated = result[0];
        final heartbeatRate = result[1];

        if (activated) {
          startHeartbeat(heartbeatRate);
        }
        return activated;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<List<dynamic>> _checkActivation(String uid, String key) async {
    try {
      final result = await _sendAuthRequest('checkAuthV2', uid, key);
      return [result[0], result[1]];
    } catch (e) {
      return [false, 300];
    }
  }

  static Future<List<dynamic>> _sendAuthRequest(
      String endpoint,
      String uid,
      String key,
      ) async {
    try {
      final params = await _prepareEncryptedParams(uid, key);
      final uri = Uri.parse(
        "$serverAddress/$endpoint?${_toQueryString(params)}",
      );
      final response = await http.get(uri, headers: {'Connection': 'close'});

      if (response.statusCode == 200) {
        final isValid = await _validateResponse(
          response.bodyBytes,
          params['aesKey'],
        );
        final decryptedBytes = _decryptWithAes(
          response.bodyBytes,
          params['aesKey'],
        );
        final responseString = utf8.decode(decryptedBytes);
        final responseParts = responseString.split(',');
        if (responseParts.length != 4) {
          return [false, 300];
        }
        final heartbeatRate = int.tryParse(responseParts[2]) ?? 300;

        return [isValid, heartbeatRate];
      }

      return [false, 300];
    } catch (e) {
      return [false, 300];
    }
  }

  static Future<Map<String, dynamic>> _prepareEncryptedParams(
      String uid,
      String key,
      ) async {
    uid = uid.trim();
    key = key.trim();
    final timestampStr = DateTime.now().millisecondsSinceEpoch.toString();
    final serverPublicKey = _loadServerPublicKeyFromPemString(
      serverPublicKeyPem,
    );
    final clientAesKey = _generateClientAesKey();

    final token = base64Url
        .encode(_encryptClientAesKeyWithRsa(clientAesKey, serverPublicKey))
        .replaceAll('=', '');

    final uidEncrypted = base64Url
        .encode(_encryptWithAes(utf8.encode(uid), clientAesKey))
        .replaceAll('=', '');

    final keyEncrypted = base64Url
        .encode(_encryptWithAes(utf8.encode(key), clientAesKey))
        .replaceAll('=', '');

    final tspEncrypted = base64Url
        .encode(_encryptWithAes(utf8.encode(timestampStr), clientAesKey))
        .replaceAll('=', '');

    final signData = utf8.encode("$uid$key$timestampStr");
    final hmac = Hmac(sha256, clientAesKey);
    final signature = hmac.convert(signData);
    final signatureb64 = base64Url.encode(signature.bytes).replaceAll('=', '');

    return {
      'token': token,
      'uid': uidEncrypted,
      'key': keyEncrypted,
      'tsp': tspEncrypted,
      'sign': signatureb64,
      'aesKey': clientAesKey,
    };
  }

  static Future<bool> _validateResponse(
      Uint8List encryptedResponse,
      Uint8List aesKey,
      ) async {
    try {
      final decryptedBytes = _decryptWithAes(encryptedResponse, aesKey);
      final responseString = utf8.decode(decryptedBytes);
      final response = responseString.split(',');

      if (response.length != 4) {
        return false;
      }

      final expireTime = int.tryParse(response[0]) ?? 0;
      final serverTimestamp = int.tryParse(response[1]) ?? 0;
      final heartbeatRate = int.tryParse(response[2]) ?? 300;
      final receivedSignature = response[3];
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      final signData = utf8.encode(
        "${response[0]},${response[1]},${response[2]}",
      );
      final hmac = Hmac(sha256, aesKey);
      final expectedSignature = hmac.convert(signData);
      final expectedSignatureB64 = base64Url
          .encode(expectedSignature.bytes)
          .replaceAll('=', '');

      return (currentTime - serverTimestamp).abs() <= expireTime * 1000 &&
          expectedSignatureB64 == receivedSignature;
    } catch (e) {
      return false;
    }
  }

  static String _toQueryString(Map<String, dynamic> params) {
    return params.entries
        .where((e) => e.key != 'aesKey')
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }
}

class ActivationDialog extends StatefulWidget {
  final String uid;
  final String authKey;
  final Completer<bool> completer;

  const ActivationDialog({
    Key? key,
    required this.uid,
    required this.authKey,
    required this.completer,
  }) : super(key: key);

  @override
  _ActivationDialogState createState() => _ActivationDialogState();
}

class _ActivationDialogState extends State<ActivationDialog> {
  late final TextEditingController _controller;
  bool _isLoading = false;
  bool _cooldownActive = false;
  int _cooldownSeconds = 10;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.authKey);
  }

  @override
  void dispose() {
    _controller.dispose();
    _cooldownTimer?.cancel();
    BotToast.closeAllLoading();
    super.dispose();
  }

  void _startCooldown() {
    setState(() {
      _cooldownActive = true;
      _cooldownSeconds = 10;
    });

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _cooldownSeconds--);
      if (_cooldownSeconds == 0) {
        timer.cancel();
        setState(() => _cooldownActive = false);
      }
    });
  }

  Future<void> _onRegister() async {
    final activationKey = _controller.text.trim();
    if (activationKey.isEmpty) return;

    setState(() => _isLoading = true);
    BotToast.showLoading();

    try {
      final result = await AuthServiceV2._sendAuthRequest(
        'registerAuthV2',
        widget.uid,
        activationKey,
      );

      final success = result[0];

      if (success) {
        await AuthServiceV2.saveAuthKey(activationKey);

        if (mounted) {
          setState(() => _isLoading = false);
        }
        BotToast.closeAllLoading();

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('激活成功'),
              content: const Text('激活成功，请点击确定重启应用后使用'),
              actions: <Widget>[
                TextButton(
                  child: const Text('确定'),
                  onPressed: () {
                    if (!widget.completer.isCompleted) {
                      widget.completer.complete(true);
                    }
                    exit(0);
                  },
                ),
              ],
            );
          },
        );
      } else {
        BotToast.showText(text: '激活失败');
        _startCooldown();
      }
    } catch (e) {
      BotToast.showText(text: '激活异常');
      _startCooldown();
    } finally {
      if (_isLoading && mounted) {
        setState(() => _isLoading = false);
      }
      BotToast.closeAllLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '激活使用',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '请输入激活码',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                sellerInfo,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              if (_cooldownActive)
                Text(
                  '请等待 ${_cooldownSeconds}秒后重试',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => widget.completer.complete(false),
                    child: const Text('退出程序', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _cooldownActive || _isLoading
                        ? null
                        : _onRegister,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 32,
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('激活', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
