import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AESUtil {
  // 加密
  static String encrypt(String plainText, String keyString) {
    try {
      final key = _generateKey(keyString);
      final iv = IV.fromSecureRandom(16);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return '${iv.base64}:${encrypted.base64}';
    } catch (e) {
      throw Exception('加密失败: $e');
    }
  }

  // 解密
  static String decrypt(String cipherText, String keyString) {
    try {
      final parts = cipherText.split(':');
      final iv = IV.fromBase64(parts[0]);
      final encrypted = Encrypted.fromBase64(parts[1]);

      final key = _generateKey(keyString);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw Exception('解密失败: $e');
    }
  }

  static Key _generateKey(String keyString) {
    if (keyString.isEmpty) throw Exception('秘钥不能为空');
    final hash = sha256.convert(utf8.encode(keyString)).toString();
    return Key.fromUtf8(hash.substring(0, 32));
  }
}
