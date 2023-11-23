import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkList extends StatelessWidget {
  final List<dynamic> bookmarks;

  const BookmarkList(this.bookmarks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length ~/ 2,
        itemBuilder: (context, index) {
          int moduleIndex = bookmarks[index * 2];
          double videoTime = bookmarks[index * 2 + 1];

          return ListTile(
            title: Text('Module ${moduleIndex + 1}'),
            subtitle: Text(
                'Bookmark at ${Duration(seconds: videoTime.toInt()).toString().split('.')[0]}'),
            onTap: () {
              Get.back(
                  result: {'moduleIndex': moduleIndex, 'videoTime': videoTime});
            },
          );
        },
      ),
    );
  }
}
