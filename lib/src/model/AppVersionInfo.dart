//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

class AppVersionInfo {
  String apkUrl = '';
  String iosUrl = '';
  String versionName = '';
  String versionDesc = '';

  int foceUpdate = 0; //0非强制  1强制

  AppVersionInfo.fromJson(Map<String, dynamic> json) {
    apkUrl = json['apkUrl'] ?? '';
    iosUrl = json['iosUrl'] ?? '';
    versionName = json['versionName'] ?? '';
    foceUpdate = json['foceUpdate'] ?? 0;
    versionDesc = json['versionDesc'] ?? '';
  }
}
