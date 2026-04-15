//公众号 biglead  欢迎关注
//bibi课程 https://www.bilibili.com/cheese/play/ss723931614
//如有开发需求 可联系作者  app 小程序  h5  java php

class NoteCategory {
  String id = '';
  String categoryName = "";

  NoteCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    categoryName = json['categoryName'] ?? "";
  }
}
