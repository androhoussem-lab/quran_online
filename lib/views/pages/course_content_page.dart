import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/controllers/course_content_controller.dart';
import 'package:quran_online/models/video_model.dart';
import 'package:quran_online/views/widgets/custom_video_item.dart';

class CourseContentPage extends StatelessWidget {
  CourseContentPage({Key? key}) : super(key: key);

  final CourseContentController _courseContentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Get.arguments['course_name']!,
          style: const TextStyle(fontFamily: 'cairo'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _courseContentController.videosList.length,
            itemBuilder: (context, index) => CustomVideoItem(
                  index: index,
              videoModel: _courseContentController.videosList[index],
                )),
      ),
    );
  }
}
