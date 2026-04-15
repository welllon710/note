import 'package:flutter_note/src/model/NoteInfo.dart';
import 'package:flutter_note/src/utils/api_service.dart';
import 'package:get/get.dart';

class Homepagecontroller extends GetxController {
  late int pageIndex = 0;
  List<NoteInfo> noteList = [];
  bool isLoading = false;
  Future<void> initData() async {
    isLoading = true;
    if (pageIndex == 0) {
      ApiService().getPublishNoteList(page: 1, pageSize: 20).then((value) {
        noteList = value;
        isLoading = false;
        update(['root']);
      });
    } else {}
    return;
  }
}
