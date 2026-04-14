import 'package:hive_flutter/adapters.dart';

import '../Constants.dart';

class SecureHiveUtil {
  static late Box _box;
  static Future<void> init() async {
    await Hive.initFlutter();
    //打开盒子 使用密钥
    _box = await Hive.openBox(
      "note_box",
      encryptionCipher: HiveAesCipher(Constants.hiveEncryptionKye),
    );
    print('打开 加密 box 成功');
  }

  static Future<void> saveToke(String token) async {
    await _box.put("token", token);
  }

  //获取token
  static String getToken() {
    return _box.get("token") ?? "";
  }
}
