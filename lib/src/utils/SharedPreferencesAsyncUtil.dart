//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesAsync 工具类
/// 基于新版 SharedPreferencesAsync 的封装，推荐用于新项目
class SharedPreferencesAsyncUtil {
  static SharedPreferencesAsync? _instance;

  // 私有构造函数
  SharedPreferencesAsyncUtil._();

  /// 获取 SharedPreferencesAsync 实例
  static SharedPreferencesAsync get _prefs {
    if (_instance == null) {
      throw Exception('SharedPreferencesAsync 未初始化，请先调用 init() 方法');
    }
    return _instance!;
  }

  /// 初始化 SharedPreferencesAsync
  /// [options] 可选的平台特定配置
  static Future<void> init({
    SharedPreferencesOptions options = const SharedPreferencesOptions(),
  }) async {
    _instance = SharedPreferencesAsync(options: options);
  }

  /// 检查是否已初始化
  static bool get isInitialized => _instance != null;

  /// 保存字符串
  static Future<void> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// 读取字符串
  static Future<String?> getString(String key, {String? defaultValue}) async {
    final value = await _prefs.getString(key);
    return value ?? defaultValue;
  }

  /// 保存整数
  static Future<void> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// 读取整数
  static Future<int?> getInt(String key, {int? defaultValue}) async {
    final value = await _prefs.getInt(key);
    return value ?? defaultValue;
  }

  /// 保存双精度浮点数
  static Future<void> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// 读取双精度浮点数
  static Future<double?> getDouble(String key, {double? defaultValue}) async {
    final value = await _prefs.getDouble(key);
    return value ?? defaultValue;
  }

  /// 保存布尔值
  static Future<void> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// 读取布尔值
  static Future<bool?> getBool(String key, {bool? defaultValue}) async {
    final value = await _prefs.getBool(key);
    return value ?? defaultValue;
  }

  /// 保存字符串列表
  static Future<void> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// 读取字符串列表
  static Future<List<String>?> getStringList(
    String key, {
    List<String>? defaultValue,
  }) async {
    final value = await _prefs.getStringList(key);
    return value ?? defaultValue;
  }

  /// 删除指定键的值
  static Future<void> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// 检查是否包含某个键
  static Future<bool> containsKey(String key) async {
    return await _prefs.containsKey(key);
  }

  /// 获取所有键
  static Future<Set<String>> getKeys() async {
    return await _prefs.getKeys();
  }

  /// 清空所有数据
  /// [allowList] 允许保留的键列表（推荐使用）
  static Future<void> clear({Set<String>? allowList}) async {
    return await _prefs.clear(allowList: allowList);
  }
}
