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

Map<String, String> _parseGenericConfig(String configString) {
  try {
    Map<String, dynamic> jsonMap = json.decode(configString);
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  } catch (e) {
    return <String, String>{};
  }
}

class SyncService {
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

  static Future<void> _setGenericConfig(Map<String, String> config) async {
    for (final entry in config.entries) {
      await setOptionCallback(entry.key, entry.value);
    }
  }

  static Future<String> sync() async {
    try {
      final serverPublicKey = _loadServerPublicKeyFromPemString(
        serverPublicKeyPem,
      );

      final versionAesKey = _generateClientAesKey();
      final encryptedVersionAesKey = _encryptClientAesKeyWithRsa(
        versionAesKey,
        serverPublicKey,
      );
      final versionTokenB64 = base64Url
          .encode(encryptedVersionAesKey)
          .replaceAll('=', '');

      final versionTimestamp = DateTime.now().millisecondsSinceEpoch;
      final versionTimestampBytes = Uint8List.fromList(
        utf8.encode(versionTimestamp.toString()),
      );
      final versionEncryptedTimestamp = _encryptWithAes(
        versionTimestampBytes,
        versionAesKey,
      );
      final versionTspB64 = base64Url
          .encode(versionEncryptedTimestamp)
          .replaceAll('=', '');

      final versionSignData = utf8.encode(versionTimestamp.toString());
      final versionHmac = Hmac(sha256, versionAesKey);
      final versionSignature = versionHmac.convert(versionSignData);
      final versionSignB64 = base64Url.encode(versionSignature.bytes).replaceAll('=', '');

      final versionUri = Uri.parse("$serverAddress/getConfigVer?token=$versionTokenB64&tsp=$versionTspB64&sign=$versionSignB64");
      final versionResponse = await http.get(versionUri);

      if (versionResponse.statusCode != 200) {
        return "error";
      }

      final decryptedVersionBytes = _decryptWithAes(
        versionResponse.bodyBytes,
        versionAesKey,
      );
      final serverConfigVer = base64.encode(decryptedVersionBytes);

      final localConfigVer = await getOptionCallback('configVer');
      if (localConfigVer != null && localConfigVer == serverConfigVer) {
        return "latest";
      }

      final configAesKey = _generateClientAesKey();
      final encryptedConfigAesKey = _encryptClientAesKeyWithRsa(
        configAesKey,
        serverPublicKey,
      );
      final configTokenB64 = base64Url
          .encode(encryptedConfigAesKey)
          .replaceAll('=', '');

      final configTimestamp = DateTime.now().millisecondsSinceEpoch;
      final configTimestampBytes = Uint8List.fromList(
        utf8.encode(configTimestamp.toString()),
      );
      final configEncryptedTimestamp = _encryptWithAes(
        configTimestampBytes,
        configAesKey,
      );
      final configTspB64 = base64Url
          .encode(configEncryptedTimestamp)
          .replaceAll('=', '');

      final configSignData = utf8.encode(configTimestamp.toString());
      final configHmac = Hmac(sha256, configAesKey);
      final configSignature = configHmac.convert(configSignData);
      final configSignB64 = base64Url.encode(configSignature.bytes).replaceAll('=', '');

      final configUri = Uri.parse("$serverAddress/fetchServerConfig?token=$configTokenB64&tsp=$configTspB64&sign=$configSignB64");
      final configResponse = await http.get(configUri);

      if (configResponse.statusCode != 200) {
        return "error";
      }

      final decryptedConfigBytes = _decryptWithAes(
        configResponse.bodyBytes,
        configAesKey,
      );
      final decryptedConfigString = utf8.decode(decryptedConfigBytes);
      final configMap = _parseGenericConfig(decryptedConfigString);
      await _setGenericConfig(configMap);

      await setOptionCallback('configVer', serverConfigVer);
      return "success";
    } catch (e) {
      return "error";
    }
  }
}
