// activation_service.dart
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


const String serverAddress = "http://124.222.93.30:20205";
const String serverPublicKeyPem = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiJVJhchPAmXMcgSqmdZy
51V9ducZDd8AA1oa6NiBgcaW5kgpEiZNr8bkArBMjDOaCDOp/NYDt3Xu9zNSPTvn
S+NEXYX6Wz9l/lZRRnnyekiyzi/ZhGiSP1hjIsJB8nP7WZccxYBVZF5qqX14u4ne
WCyro6KTq14pTv1IhyL4sOjVV6AI23+Zl9zzUEmE+szyLLHA/Q7jLVyPORYIxOO/
mp+uDlfUr2nljTMpbjMFlkRM5Q33eTQS9ZdV6C6ensKm87JIRxwCtFj6EOUcV+Jh
VnG8e6kZgSKcvYZKDabDWtUVSM8nsS3PzpSI51Mf5DlgUAWogg6mSUohiDBhRlNw
FQIDAQAB
-----END PUBLIC KEY-----
''';

pc.RSAPublicKey _loadServerPublicKeyFromPemString(String pemString) {
  final parser = encrypt_lib.RSAKeyParser();
  return parser.parse(pemString) as pc.RSAPublicKey;
}

Uint8List _generateClientAesKey() {
  return encrypt_lib.Key.fromSecureRandom(32).bytes;
}

Uint8List _encryptClientAesKeyWithRsa(
    Uint8List clientAesKey,
    pc.RSAPublicKey serverPublicKey,
    ) {
  final rsaEngine = pc.RSAEngine();
  final oaepEncoding = pc.OAEPEncoding(rsaEngine);

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


class AuthService {
  static Future<String> Function(String key) getOptionCallback = (key) async =>
  "";
  static Future<void> Function(String key, String value) setOptionCallback =
      (key, value) async {};

  static void setCallbacks({
    required Future<String> Function(String key) getOption,
    required Future<void> Function(String key, String value) setOption,
  }) {
    getOptionCallback = getOption;
    setOptionCallback = setOption;
  }

  static Future<bool> showGlobalActivationDialog() async {
    final uid = (await generateUniqueFeatureCode()).trim();
    final authKey = (await getOptionCallback('auth_key')).trim();
    final completer = Completer<bool>();

    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      MaterialApp(
        builder: BotToastInit(),
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
      exit(0);
    }
    return success;
  }

  static Future<bool> verify() async {
    String uid = '';
    String authKey = '';

    try {
      uid = (await generateUniqueFeatureCode()).trim();
      authKey = (await getOptionCallback('auth_key')).trim();
      if (authKey.isEmpty) {
        return false;
      } else {
        final activated = await _checkActivation(uid, authKey);
        return activated;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> _checkActivation(String uid, String key) async {
    try {
      final result = await _sendAuthRequest('checkAuth', uid, key);
      return result;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _sendAuthRequest(
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
        return await _validateResponse(response.bodyBytes, params['aesKey']);
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> _prepareEncryptedParams(
      String uid,
      String key,
      ) async {
	uid = uid.trim();
	key = key.trim();
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
        .encode(
      _encryptWithAes(
        utf8.encode(DateTime.now().millisecondsSinceEpoch.toString()),
        clientAesKey,
      ),
    )
        .replaceAll('=', '');

    return {
      'token': token,
      'uid': uidEncrypted,
      'key': keyEncrypted,
      'tsp': tspEncrypted,
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

      final expireTime = int.tryParse(response[0]) ?? 0;
      final serverTimestamp = int.tryParse(response[1]) ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      return (currentTime - serverTimestamp).abs() <= expireTime * 1000;
    } catch (e) {
      return false;
    }
  }

  static String _toQueryString(Map<String, dynamic> params) {
    return params.entries
        .where((e) => e.key != 'aesKey')
        .map((e) => '${e.key}=${e.value}')
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
      final success = await AuthService._sendAuthRequest(
        'registerAuth',
        widget.uid,
        activationKey,
      );

      if (success) {
        await AuthService.setOptionCallback('auth_key', _controller.text);

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
                      await gFFI.abModel.saveCache();
                      await gFFI.groupModel.saveCache();
                      await gFFI.serverModel.loadRecentConnections();
                      await draggablePositions.load();
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
      BotToast.showText(text: '激活异常: ${e.toString()}');
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
			  const SizedBox(height: 8),  //这部分
			  const Text(
                '杜小白',
                style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                ),
              ),  //这部分
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
