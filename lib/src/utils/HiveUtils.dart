import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class HiveUtil {
  //定义盒子的名称 为note
  static const String defaultBoxName = "note";

  //单例
  HiveUtil._();
  static final HiveUtil instance = HiveUtil._();
  //工厂类
  factory HiveUtil() => instance;

  //记录初始化状态
  bool _isInit = false;
  //定义方法 判断是否初始化
  void _checkInit() {
    if (!_isInit) {
      throw Exception("Hive 未初始化");
    }
  }

  //定义获取盒子的方法
  Box _getBox(String boxName) {
    _checkInit();
    return Hive.box(boxName);
  }

  //存数据
  Future<void> saveData(
    String key,
    dynamic value, {
    String boxName = defaultBoxName,
  }) async {
    try {
      //获取盒子
      Box box = _getBox(boxName);
      //存数据
      await box.put(key, value);
    } catch (e) {
      debugPrint("存数据失败 $e");
    }
  }

  //取数据
  T? getData<T>(String key, {String boxName = defaultBoxName}) {
    try {
      //获取盒子
      Box box = _getBox(boxName);
      //取数据
      return box.get(key) as T?;
    } catch (e) {
      debugPrint("取数据失败 $e");
    }
    return null;
  }

  //删除数据
  Future<void> deleteData(String key, {String boxName = defaultBoxName}) async {
    try {
      //获取盒子
      Box box = _getBox(boxName);
      //删除数据
      await box.delete(key);
    } catch (e) {
      debugPrint("删除数据失败 $e");
    }
  }

  //初始化
  Future<void> init({
    List<String> boxNameList = const [defaultBoxName],
    List<dynamic> adapterList = const [],
  }) async {
    if (_isInit) return;
    //初始化
    try {
      //初始化hive
      await Hive.initFlutter();
      //注册适配器
      for (var adapter in adapterList) {
        Hive.registerAdapter(adapter);
      }
      //打开盒子
      for (var boxName in boxNameList) {
        await Hive.openBox(boxName);
      }
      _isInit = true;
      debugPrint("Hive 初始化成功");
    } catch (e) {
      print(e);
      _isInit = false;
      debugPrint("Hive 初始化失败");
    }

    return;
  }
}
