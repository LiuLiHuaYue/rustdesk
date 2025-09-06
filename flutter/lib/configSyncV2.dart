import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart' as pc;
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'package:crypto/crypto.dart';
import 'package:bot_toast/bot_toast.dart';

const String serverAddress = "http://192.168.0.105:20205";
const String serverPublicKeyPem = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjZWplOJAIpmQh6v6/I6w
G6Oe6VrFIDB3fuOlU6zxZSQ7MVHInENKhWMiEJg7UYRIAuHtKxZ/YkMUkwYkUO5T
2TA7QgIoW4YNly7qthqkB9IiUV7D12tTV6eaMwIrPfwokXUsDRimm0WtimGOEjlE
nWO4C8F8f/tkyRs7yK8s84Qdg7sd5+EuFsff0Eypfxe39rjpl6P5pFfhnejp7aUl
E075YcMZQuVKinrlgswkgd2ZvnbZ8cY8vmyQpZbPdrJyWSj+KieC+bPO3PShf/Fs
qHP3vURbCVL9lCTAoSKmqyWKcid5uNLlUnjtZw3u/MbVY/IE1O5jS6zUa5hAVDsS
3QIDAQAB
-----END PUBLIC KEY-----
''';

typedef GetOptionCallback = Future<String> Function(String key);
typedef SetOptionCallback = Future<void> Function(String key, String value);

typedef SetOptionsCallback = Future<void> Function(String json);

typedef SetSocksCallback =
Future<void> Function(String proxy, String username, String password);

typedef SetEnvCallback = Future<void> Function(String key, String? value);

typedef SetLocalOptionCallback = Future<void> Function(String key, String value);

typedef SetInputSourceCallback = Future<void> Function(String sessionId, String value);

typedef SetPeerFlutterOptionSyncCallback = Future<void> Function(String id, String k, String v);

typedef SetPeerOptionCallback = Future<void> Function(String id, String key, String value);

typedef SetPeerAliasCallback = Future<void> Function(String id, String alias);

typedef SetUserDefaultOptionCallback = Future<void> Function(String key, String value);

typedef SetHomeDirCallback = Future<void> Function(String home);

typedef SetPermanentPasswordCallback = Future<void> Function(String password);

typedef SetShareRdpCallback = Future<void> Function(bool enable);

typedef SetUnlockPinCallback = Future<void> Function(String pin);

typedef SetCommonCallback = Future<void> Function(String key, String value);

class SyncServiceV2 {
  static GetOptionCallback getOptionCallback = (key) async => "";
  static SetOptionCallback setOptionCallback = (key, value) async {};

  static SetOptionsCallback setOptionsCallback = (json) async {};

  static SetSocksCallback setSocksCallback = (proxy, username, password) async {};

  static SetEnvCallback setEnvCallback = (key, value) async {};

  static SetLocalOptionCallback setLocalOptionCallback = (key, value) async {};

  static SetInputSourceCallback setInputSourceCallback = (sessionId, value) async {};

  static SetPeerFlutterOptionSyncCallback setPeerFlutterOptionSyncCallback = (id, k, v) async {};

  static SetPeerOptionCallback setPeerOptionCallback = (id, key, value) async {};

  static SetPeerAliasCallback setPeerAliasCallback = (id, alias) async {};

  static SetUserDefaultOptionCallback setUserDefaultOptionCallback = (key, value) async {};

  static SetHomeDirCallback setHomeDirCallback = (home) async {};

  static SetPermanentPasswordCallback setPermanentPasswordCallback = (password) async {};

  static SetShareRdpCallback setShareRdpCallback = (enable) async {};

  static SetUnlockPinCallback setUnlockPinCallback = (pin) async {};

  static SetCommonCallback setCommonCallback = (key, value) async {};

  static void setCallbacks({
    GetOptionCallback? getOption,
    SetOptionCallback? setOption,

    SetOptionsCallback? setOptions,

    SetSocksCallback? setSocks,

    SetEnvCallback? setEnv,

    SetLocalOptionCallback? setLocalOption,

    SetInputSourceCallback? setInputSource,

    SetPeerFlutterOptionSyncCallback? setPeerFlutterOptionSync,

    SetPeerOptionCallback? setPeerOption,

    SetPeerAliasCallback? setPeerAlias,

    SetUserDefaultOptionCallback? setUserDefaultOption,

    SetHomeDirCallback? setHomeDir,

    SetPermanentPasswordCallback? setPermanentPassword,

    SetShareRdpCallback?setShareRdp,

    SetUnlockPinCallback?setUnlockPin,

    SetCommonCallback?setCommon,
  }) {
    if (getOption != null) getOptionCallback = getOption;
    if (setOption != null) setOptionCallback = setOption;

    if (setOptions != null) setOptionsCallback = setOptions;

    if (setSocks != null) setSocksCallback = setSocks;

    if (setEnv != null) setEnvCallback = setEnv;

    if (setLocalOption != null) setLocalOptionCallback = setLocalOption;

    if (setInputSource != null) setInputSourceCallback = setInputSource;

    if (setPeerFlutterOptionSync != null)
      setPeerFlutterOptionSyncCallback = setPeerFlutterOptionSync;

    if (setPeerOption != null) setPeerOptionCallback = setPeerOption;

    if (setPeerAlias != null) setPeerAliasCallback = setPeerAlias;

    if (setUserDefaultOption != null)
      setUserDefaultOptionCallback = setUserDefaultOption;

    if (setHomeDir != null) setHomeDirCallback = setHomeDir;

    if (setPermanentPassword != null)
      setPermanentPasswordCallback = setPermanentPassword;

    if (setShareRdp != null)
      setShareRdpCallback = setShareRdp;

    if (setUnlockPin != null)
      setUnlockPinCallback = setUnlockPin;

    if (setCommon != null)
      setCommonCallback = setCommon;
  }

  static Future<void> _applyConfig(Map<String, dynamic> config) async {
    for (var type in config.keys) {
      final items = config[type] as List<dynamic>;

      switch (type) {
        case 'Option':
          for (var item in items) {
            await setOptionCallback(item['key'], item['value']);
          }
          break;

        case 'Options':
          if (items.isNotEmpty) {
            await setOptionsCallback(json.encode(items.first));
          }
          break;

        case 'Socks':
          for (var item in items) {
            await setSocksCallback(
              item['proxy'],
              item['username'],
              item['password'],
            );
          }
          break;

        case 'Env':
          for (var item in items) {
            await setEnvCallback(item['key'], item['value']);
          }
          break;

        case 'LocalOption':
          for (var item in items) {
            await setLocalOptionCallback(item['key'], item['value']);
          }
          break;

        case 'InputSource':
          for (var item in items) {
            await setInputSourceCallback(item['sessionId'], item['value']);
          }
          break;

        case 'PeerFlutterOptionSync':
          for (var item in items) {
            await setPeerFlutterOptionSyncCallback(
              item['id'],
              item['k'],
              item['v'],
            );
          }
          break;

        case 'PeerOption':
          for (var item in items) {
            await setPeerOptionCallback(item['id'], item['key'], item['value']);
          }
          break;

        case 'PeerAlias':
          for (var item in items) {
            await setPeerAliasCallback(item['id'], item['alias']);
          }
          break;

        case 'UserDefaultOption':
          for (var item in items) {
            await setUserDefaultOptionCallback(item['key'], item['value']);
          }
          break;

        case 'HomeDir':
          if (items.isNotEmpty) {
            await setHomeDirCallback(items.first['home']);
          }
          break;

        case 'PermanentPassword':
          if (items.isNotEmpty) {
            await setPermanentPasswordCallback(items.first['password']);
          }
          break;

        case 'ShareRdp':
          if (items.isNotEmpty) {
            await setShareRdpCallback(items.first['enable']);
          }
          break;

        case 'UnlockPin':
          if (items.isNotEmpty) {
            await setUnlockPinCallback(items.first['pin']);
          }
          break;

        case 'Common':
          for (var item in items) {
            await setCommonCallback(item['key'], item['value']);
          }
          break;

        default:
          print('Unknown config type: $type');
      }
    }
  }

  static Future<String> sync() async {
    try {
      final serverPublicKey = _loadServerPublicKeyFromPemString(serverPublicKeyPem);

      final versionAesKey = _generateClientAesKey();
      final encryptedVersionAesKey = _encryptClientAesKeyWithRsa(versionAesKey, serverPublicKey);
      final versionTokenB64 = base64Url.encode(encryptedVersionAesKey).replaceAll('=', '');

      final versionTimestamp = DateTime.now().millisecondsSinceEpoch;
      final versionTimestampBytes = Uint8List.fromList(utf8.encode(versionTimestamp.toString()));
      final versionEncryptedTimestamp = _encryptWithAes(versionTimestampBytes, versionAesKey);
      final versionTspB64 = base64Url.encode(versionEncryptedTimestamp).replaceAll('=', '');

      final versionSignData = utf8.encode(versionTimestamp.toString());
      final versionHmac = Hmac(sha256, versionAesKey);
      final versionSignature = versionHmac.convert(versionSignData);
      final versionSignB64 = base64Url
          .encode(versionSignature.bytes)
          .replaceAll('=', '');

      final versionUri = Uri.parse(
        "$serverAddress/getConfigVerV2?token=$versionTokenB64&tsp=$versionTspB64&sign=$versionSignB64",
      );
      final versionResponse = await http.get(versionUri);

      if (versionResponse.statusCode != 200) {
        return "error";
      }

      final decryptedVersionBytes = _decryptWithAes(versionResponse.bodyBytes, versionAesKey);
      final serverConfigVer = base64.encode(decryptedVersionBytes);

      final localConfigVer = await getOptionCallback('configVer');
      if (localConfigVer != null && localConfigVer == serverConfigVer) {
        return "latest";
      }

      final configAesKey = _generateClientAesKey();
      final encryptedConfigAesKey = _encryptClientAesKeyWithRsa(configAesKey, serverPublicKey);
      final configTokenB64 = base64Url.encode(encryptedConfigAesKey).replaceAll('=', '');

      final configTimestamp = DateTime.now().millisecondsSinceEpoch;
      final configTimestampBytes = Uint8List.fromList(utf8.encode(configTimestamp.toString()));
      final configEncryptedTimestamp = _encryptWithAes(configTimestampBytes, configAesKey);
      final configTspB64 = base64Url.encode(configEncryptedTimestamp).replaceAll('=', '');

      final configSignData = utf8.encode(configTimestamp.toString());
      final configHmac = Hmac(sha256, configAesKey);
      final configSignature = configHmac.convert(configSignData);
      final configSignB64 = base64Url
          .encode(configSignature.bytes)
          .replaceAll('=', '');

      final configUri = Uri.parse(
        "$serverAddress/fetchServerConfigV2?token=$configTokenB64&tsp=$configTspB64&sign=$configSignB64",
      );
      final configResponse = await http.get(configUri);

      if (configResponse.statusCode != 200) {
        return "error";
      }

      final decryptedConfigBytes = _decryptWithAes(configResponse.bodyBytes, configAesKey);
      final decryptedConfigString = utf8.decode(decryptedConfigBytes);
      final configJson = json.decode(decryptedConfigString) as Map<String, dynamic>;
      await _applyConfig(configJson);

      await setOptionCallback('configVer', serverConfigVer);
      return "success";
    } catch (e) {
      return "error";
    }
  }
}


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
  return oaepEncoding.process(clientAesKey);
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