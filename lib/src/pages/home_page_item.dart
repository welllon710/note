import 'package:flutter/material.dart';
import 'package:flutter_note/src/controller/HomePageController.dart';
import 'package:flutter_note/src/model/NoteInfo.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePageItem extends StatefulWidget {
  final int pageIndex;
  const HomePageItem({super.key, required this.pageIndex});

  @override
  State<HomePageItem> createState() => _HomePageItemState();
}

class _HomePageItemState extends State<HomePageItem> {
  late final String _tag;
  late Homepagecontroller _controller;

  @override
  void initState() {
    _tag = 'home_page_item_${widget.pageIndex}';
    _controller = Get.put(Homepagecontroller(), tag: _tag);
    super.initState();
    Future.delayed(Duration.zero, () {
      _controller.initData();
    });
  }

  @override
  void dispose() {
    if (Get.isRegistered<Homepagecontroller>(tag: _tag)) {
      Get.delete<Homepagecontroller>(tag: _tag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homepagecontroller>(
      tag: _tag,
      id: 'root',
      builder: (controller) {
        bool isLoading = controller.isLoading;
        if (isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.noteList.isEmpty) {
          return Center(child: Text("暂无数据"));
        }
        return Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            // borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            itemCount: controller.noteList.length,
            itemBuilder: (context, index) {
              NoteInfo note = controller.noteList[index];
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF667eea),
                                const Color(0xFF764ba2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '精选',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(width: 24, height: 24, color: Colors.blue),
                        // Image.network(
                        //   note.avatar,
                        //   width: 24,
                        //   height: 24,
                        //   fit: BoxFit.cover,
                        // ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.nickName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '2024-06-01',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Text(
                      note.content,
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
