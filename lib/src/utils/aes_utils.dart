//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class AESUtils {
  // 与Java AES加密解密兼容的实现
  // Java代码使用：AES/CBC/PKCS5Padding，随机IV，Base64(IV + 密文)

  // 解密Java加密的数据
  static String decryptJavaCompatible({
    required String encryptedText, // Base64(IV + 密文)
    required String key, // 32字节密钥
  }) {
    try {
      // 1. Base64解码
      final combinedBytes = base64Decode(encryptedText);

      // 2. 分离IV和密文（IV在前16字节）
      final ivBytes = combinedBytes.sublist(0, 16);
      final encryptedBytes = combinedBytes.sublist(16);

      // 3. 将密钥转换为字节数组
      final keyBytes = utf8.encode(key);

      // 4. 创建解密器
      final cipher = PaddedBlockCipherImpl(
        PKCS7Padding(), // PKCS5Padding与PKCS7Padding兼容
        CBCBlockCipher(AESEngine()),
      );

      // 5. 初始化解密器
      cipher.init(
        false, // false表示解密
        PaddedBlockCipherParameters(
          ParametersWithIV(KeyParameter(keyBytes), ivBytes),
          null, // 不需要额外参数
        ),
      );

      // 6. 解密数据
      final decryptedBytes = cipher.process(encryptedBytes);

      // 7. 将解密后的字节数组转换为字符串
      return utf8.decode(decryptedBytes);
    } catch (e) {
      print('AES解密失败: $e');
      return '';
    }
  }

  // 与Java AES加密解密兼容的实现
  // Java代码使用：AES/CBC/PKCS5Padding，随机IV，Base64(IV + 密文)
  // 加密数据为Java兼容格式
  static String encryptJavaCompatible({
    required String plainText,
    required String key,
  }) {
    try {
      // 1. 将密钥转换为字节数组
      final keyBytes = utf8.encode(key);

      // 2. 将明文转换为字节数组
      final plainBytes = utf8.encode(plainText);

      // 3. 生成16字节的随机IV，与Java的行为一致
      //使用AES算法、工作在CTR模式下，并且集成了能自动获取安全种子、管理随机数的伪随机数生成器的加密方案。
      //CTR模式 计数器模式。它不是直接加密数据本身，而是加密一个不断递增的计数器，然后用加密后的结果（密钥流）与原始数据进行简单的异或操作来产生密文。
      final secureRandom = SecureRandom('AES/CTR/AUTO-SEED-PRNG');
      final seedSource = Random.secure();
      final seed = List<int>.generate(32, (_) => seedSource.nextInt(256));
      secureRandom.seed(KeyParameter(Uint8List.fromList(seed)));
      final iv = secureRandom.nextBytes(16);

      // 4. 创建加密器
      final cipher = PaddedBlockCipherImpl(
        PKCS7Padding(), // PKCS5Padding与PKCS7Padding兼容
        CBCBlockCipher(AESEngine()),
      );

      // 5. 初始化解密器
      cipher.init(
        true, // true表示加密
        PaddedBlockCipherParameters(
          ParametersWithIV(KeyParameter(keyBytes), iv),
          null, // 不需要额外参数
        ),
      );

      // 6. 加密数据
      final encryptedBytes = cipher.process(plainBytes);

      // 7. 将IV和密文合并（IV在前16字节）
      final combinedBytes = Uint8List(iv.length + encryptedBytes.length);
      combinedBytes.setAll(0, iv);
      combinedBytes.setAll(iv.length, encryptedBytes);

      // 8. Base64编码
      return base64Encode(combinedBytes);
    } catch (e) {
      print('AES加密失败: $e');
      return '';
    }
  }
}
