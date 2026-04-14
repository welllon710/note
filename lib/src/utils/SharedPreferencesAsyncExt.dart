//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

import 'dart:convert';

import 'SharedPreferencesAsyncUtil.dart';

/// SharedPreferencesAsync 扩展工具类
class SharedPreferencesAsyncExt {
  /// 保存对象（JSON 序列化）
  static Future<void> setObject(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = json.encode(value);
      return await SharedPreferencesAsyncUtil.setString(key, jsonString);
    } catch (e) {
      print('保存对象失败: $e');
      return;
    }
  }

  /// 读取对象（JSON 反序列化）
  static Future<Map<String, dynamic>?> getObject(String key) async {
    try {
      final jsonString = await SharedPreferencesAsyncUtil.getString(key);
      if (jsonString != null) {
        return json.decode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('读取对象失败: $e');
      return null;
    }
  }

  /// 保存日期时间
  static Future<void> setDateTime(String key, DateTime value) async {
    return await SharedPreferencesAsyncUtil.setString(
      key,
      value.toIso8601String(),
    );
  }

  /// 读取日期时间
  static Future<DateTime?> getDateTime(String key) async {
    final dateString = await SharedPreferencesAsyncUtil.getString(key);
    if (dateString != null) {
      return DateTime.tryParse(dateString);
    }
    return null;
  }

  /// 批量保存数据
  static Future<void> batchSet(Map<String, dynamic> data) async {
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String) {
        await SharedPreferencesAsyncUtil.setString(key, value);
      } else if (value is int) {
        await SharedPreferencesAsyncUtil.setInt(key, value);
      } else if (value is double) {
        await SharedPreferencesAsyncUtil.setDouble(key, value);
      } else if (value is bool) {
        await SharedPreferencesAsyncUtil.setBool(key, value);
      } else if (value is List<String>) {
        await SharedPreferencesAsyncUtil.setStringList(key, value);
      } else if (value is DateTime) {
        await setDateTime(key, value);
      } else if (value is Map<String, dynamic>) {
        await setObject(key, value);
      }
    }
  }

  /// 批量读取数据
  static Future<Map<String, dynamic>> batchGet(Set<String> keys) async {
    final result = <String, dynamic>{};
    for (final key in keys) {
      // 尝试按顺序读取不同类型
      final stringValue = await SharedPreferencesAsyncUtil.getString(key);
      if (stringValue != null) {
        result[key] = stringValue;
        continue;
      }

      final intValue = await SharedPreferencesAsyncUtil.getInt(key);
      if (intValue != null) {
        result[key] = intValue;
        continue;
      }

      final doubleValue = await SharedPreferencesAsyncUtil.getDouble(key);
      if (doubleValue != null) {
        result[key] = doubleValue;
        continue;
      }

      final boolValue = await SharedPreferencesAsyncUtil.getBool(key);
      if (boolValue != null) {
        result[key] = boolValue;
        continue;
      }

      final listValue = await SharedPreferencesAsyncUtil.getStringList(key);
      if (listValue != null) {
        result[key] = listValue;
      }
    }
    return result;
  }

  /// 安全删除多个键
  static Future<void> batchRemove(Set<String> keys) async {
    for (final key in keys) {
      await SharedPreferencesAsyncUtil.remove(key);
    }
  }
}
