//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

class Constants {
  //Hive 加密密钥
  static const List<int> hiveEncryptionKye = [
    230,
    57,
    30,
    30,
    214,
    24,
    87,
    116,
    219,
    51,
    197,
    102,
    135,
    228,
    153,
    225,
    205,
    6,
    101,
    55,
    124,
    67,
    151,
    177,
    162,
    211,
    211,
    66,
    160,
    249,
    161,
    96,
  ];

  // 加密算法
  // 使用AES解密数据
  // 注意：实际使用时需要替换为真实的密钥
  // 这里只是示例，需要根据后端实际实现来设置

  static const String aesKey = ''; // 必须是32字节的密钥

  // 用户协议和隐私协议URL
  static const String userAgreementUrl =
      'https://www.zqycscc.cn/note/note_user_agreement.html';
  static const String privacyPolicyUrl =
      'https://www.zqycscc.cn/note/note_privacy_agreement.html';
}
