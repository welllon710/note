//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

class UserInfo {
  String id = '';
  String signature = "";
  String mobile = "";

  String nickName = '';
  String avatar = '';
  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    signature = json['signature'] ?? "";
    mobile = json['mobile'] ?? "";
    nickName = json['nickName'] ?? '';
    avatar = json['avatar'] ?? '';
    if (nickName.isEmpty) {
      nickName = json['name'] ?? '';
    }
    if (signature.isEmpty) {
      signature = "作者很懒 什么也没写~~";
    }
  }
}
