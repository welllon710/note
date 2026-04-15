//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

import 'package:flutter_note/src/model/UserInfo.dart';

class NoteInfo {
  String id = '';
  String title = "";
  String content = "";
  String noteSummary = '';

  num noteFormat = 0;

  UserInfo? author;

  String nickName = '';
  String avatar = '';
  String createTime = '';

  num viewCount = 0;
  num likeCount = 0;
  NoteInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    noteSummary = json['noteSummary'] ?? '';
    noteFormat = json['noteFormat'] ?? 0;
    title = json['title'] ?? "";
    content = json['content'] ?? "";
    nickName = json['nickName'] ?? '';
    avatar = json['avatar'] ?? '';
    viewCount = json['viewCount'] ?? 0;
    likeCount = json['likeCount'] ?? 0;
    createTime = json['createTime'] ?? '';
    if (json['author'] != null) {
      author = UserInfo.fromJson(json['author']);
    }
  }
}
