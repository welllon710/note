//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_note/src/model/AppVersionInfo.dart';
import 'package:flutter_note/src/model/NoteInfo.dart';
import 'package:flutter_note/src/utils/SnackBarHepler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/NoteCategory.dart';
import '../model/UserInfo.dart';
import 'SecureHiveUtil.dart';

class ApiService {
  late Dio _dio;
  PackageInfo? _packageInfo;
  ApiService._() {
    _dio = Dio(
      BaseOptions(
        // baseUrl: "http://192.168.1.191:8081/football-api",
        baseUrl: "http://fluttertest.jinbangshichuang.com/miniapi",
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              String token = SecureHiveUtil.getToken();
              if (token.isNotEmpty) {
                options.headers["token"] = token;
              }

              //app 的信息
              // _packageInfo ??= await PackageInfo.fromPlatform();

              // options.headers["appVersionName"] = _packageInfo!.version;
              // options.headers["appVersionCode"] = _packageInfo!.buildNumber;

              // if (Platform.isAndroid) {
              //   options.headers["platform"] = "android";
              // } else {
              //   options.headers["platform"] = "ios";
              // }

              // options.headers["application"] = "note";

              return handler.next(options);
            },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print("请求 路径  ${options.path}");
          print("请求参数 ${options.queryParameters}");
          print("请求参数  ${options.data}");
          return handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
              print("响应路径  ${response.requestOptions.path}");
              print("响应参数  ${response.data}");
              return handler.next(response);
            },
      ),
    );
  }

  //静态实例
  static final ApiService _apiService = ApiService._();
  //工厂方法
  factory ApiService() => _apiService;

  //获取公开 笔记列表
  Future<List<NoteInfo>> getPublishNoteList({
    required int page,
    required int pageSize,
  }) async {
    //post 请求
    Response response = await _dio.post(
      "/api/noteinfo/user/page/p",
      data: {"page": page, "pageSize": pageSize, 'type': 'public'},
    );
    if (response.statusCode == 200) {
      dynamic data = response.data;
      int code = data['code'] ?? -1;
      String msg = data['msg'] ?? "";
      dynamic obj = data['data'] ?? [];
      //解析 数据
      if (code == 0) {
        List<NoteInfo> list = [];
        for (int i = 0; i < obj.length; i++) {
          list.add(NoteInfo.fromJson(obj[i]));
        }
        return list;
      }
    } else {
      SnackBarHelper.showError2("网络请求错误 无法公开笔记~~");
    }
    return [];
  }

  Future<AppVersionInfo?> checkAppVersion() async {
    Response response = await _dio.get("/api/appversion/newv2");
    if (response.statusCode == 200) {
      dynamic data = response.data;
      int code = data['code'] ?? -1;
      String msg = data['msg'] ?? "";
      dynamic obj = data['data'];
      //解析 数据
      if (code == 0 && obj != null) {
        return AppVersionInfo.fromJson(obj);
      }
    } else {}
    return null;
  }

  //请求发送验证码
  Future<void> sendSmsCode(String phone) async {
    //
    await Future.delayed(Duration(seconds: 1));
    return null;
  }

  Future<String> pwdLogin(String phone, String pwd) async {
    Response response = await _dio.post(
      '/api/oauth/app/pwdLogin',
      data: {'mobile': phone, 'code': pwd},
    );
    if (response.statusCode == 200 && response.data['code'] == 0) {
      return response.data['data']['token'];
    } else {
      throw Exception("登录失败 ${response.data['msg']}");
    }
  }

  Future<bool> refreshToken() async {
    Response response = await _dio.get('/api/token/refresh');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("登录失败 ${response.data['msg']}");
    }
  }

  //获取用户信息
  Future<UserInfo> getUserInfo() async {
    Response response = await _dio.get('/api/flutter/user/app/userInfo');
    if (response.statusCode == 200 && response.data['code'] == 0) {
      dynamic data = response.data['data'];
      //解析一下
      debugPrint("--");
      return UserInfo.fromJson(data);
    } else {
      throw Exception("获取用户信息失败 ${response.data['msg']}");
    }
  }

  Future<UserInfo?> getUserInfoFromUserId(String userId) async {
    Response response = await _dio.get(
      '/api/flutter/user/app/userInfo/$userId',
    );
    if (response.statusCode == 200 && response.data['code'] == 0) {
      dynamic data = response.data['data'];
      //解析一下
      debugPrint("--");
      return UserInfo.fromJson(data);
    } else {
      throw Exception("获取用户信息失败 ${response.data['msg']}");
    }
  }

  Future<List<NoteInfo>> getNoteListFromUserId(String userId) async {
    Response response = await _dio.post(
      '/api/noteinfo/user/page/u',
      data: {'page': 1, 'pageSize': 100, 'type': 'user'},
    );
    if (response.statusCode == 200 && response.data['code'] == 0) {
      dynamic data = response.data['data'];
      //解析一下
      List dataList = data ?? [];

      List<NoteInfo> list = [];
      for (int i = 0; i < dataList.length; i++) {
        NoteInfo info = NoteInfo.fromJson(dataList[i]);
        list.add(info);
      }
      return list;
    } else {
      throw Exception("获取用户信息失败 ${response.data['msg']}");
    }
  }

  Future<void> updateUserInfo(String nikname, String signature) async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<void> uploadFile(
    XFile selectImageFile,
    ProgressCallback onSendProgress,
  ) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(selectImageFile.path),
      'filename': 'test',
    });

    await _dio.post(
      "/api/upload",
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
      onSendProgress: (int count, int total) {
        //上传进度回调
        onSendProgress(count, total);
      },
    );
  }

  Future<List<NoteCategory>> getNoteCategories() async {
    Response response = await _dio.get(
      '/api/notecategory/list',
      queryParameters: {'page': 1, 'pageSize': 100},
    );
    if (response.statusCode == 200 && response.data['code'] == 0) {
      dynamic data = response.data['data'];
      //解析一下
      List dataList = data ?? [];

      List<NoteCategory> list = [];
      for (int i = 0; i < dataList.length; i++) {
        NoteCategory info = NoteCategory.fromJson(dataList[i]);
        list.add(info);
      }
      return list;
    } else {
      throw Exception("获取分类信息失败 ${response.data['msg']}");
    }
  }

  Future<NoteInfo?> getNoteDetail(String noteId) async {
    Response response = await _dio.get('/api/noteinfo/info/$noteId');
    if (response.statusCode == 200 && response.data['code'] == 0) {
      dynamic data = response.data['data'];
      //解析一下

      return NoteInfo.fromJson(data);
    } else {
      throw Exception("获取详情失败 ${response.data['msg']}");
    }
  }

  //单例
}
