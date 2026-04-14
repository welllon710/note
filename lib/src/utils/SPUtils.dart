//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  SPUtils._();

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    return;
  }

  //检查是否已初始化
  static bool get isInitialized => _preferences != null;

  static void _checkInitialized() {
    if (!isInitialized) {
      throw Exception('SPUtils is not initialized');
    }
  }

  //保存字符串
  static Future<bool> setString(String key, String value) async {
    _checkInitialized();
    await _preferences!.setString(key, value);
    return true;
  }

  //获取字符串
  static String? getString(String key) {
    _checkInitialized();
    return _preferences!.getString(key);
  }

  //保存整数
  static Future<bool> setInt(String key, int value) async {
    _checkInitialized();
    await _preferences!.setInt(key, value);
    return true;
  }

  //获取整数
  static int? getInt(String key) {
    _checkInitialized();
    return _preferences!.getInt(key);
  }

  //保存布尔值
  static Future<bool> setBool(String key, bool value) async {
    _checkInitialized();
    await _preferences!.setBool(key, value);
    return true;
  }

  //获取布尔值
  static bool? getBool(String key) {
    _checkInitialized();
    return _preferences!.getBool(key);
  }

  //保存double
  static Future<bool> setDouble(String key, double value) async {
    _checkInitialized();
    await _preferences!.setDouble(key, value);
    return true;
  }

  //获取 double
  static double? getDouble(String key) {
    _checkInitialized();
    return _preferences!.getDouble(key);
  }

  //List
  static Future<bool> setList(String key, List<String> value) async {
    _checkInitialized();
    await _preferences!.setStringList(key, value);
    return true;
  }

  //获取List
  static List<String>? getList(String key) {
    _checkInitialized();
    return _preferences!.getStringList(key);
  }

  //删除 值
  static Future<bool> remove(String key) async {
    _checkInitialized();
    await _preferences!.remove(key);
    return true;
  }

  //清空所有
  static Future<bool> clear() async {
    _checkInitialized();
    await _preferences!.clear();
    return true;
  }
}
