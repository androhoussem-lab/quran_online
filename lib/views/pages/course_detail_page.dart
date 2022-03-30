import 'package:flutter/material.dart';
import 'package:quran_online/controllers/course_detail_controller.dart';
import 'package:get/get.dart';
import 'package:quran_online/views/widgets/custom_Text_viewer.dart';
import 'package:quran_online/views/widgets/custom_button.dart';
import 'package:quran_online/views/widgets/custom_video_player.dart';

class CourseDetailPage extends StatelessWidget {
  CourseDetailPage({Key? key}) : super(key: key);

  final CourseDetailController _courseDetailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _courseDetailController.courseName,
          style: const TextStyle(fontFamily: 'cairo'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: _getScreenSize(context)),
          child: Column(
            children: [
              CustomVideoPlayer(),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextViewer(
                          text: _courseDetailController.courseDescription,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'مقدمة من طرف : ',
                            style: TextStyle(fontFamily: 'cairo'),
                          ),
                          Text(
                            _courseDetailController.courseTeacher,
                            style: TextStyle(
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            'سعر الإشتراك :  ',
                            style: TextStyle(fontFamily: 'cairo'),
                          ),
                          Text(
                            '${_courseDetailController.coursePrice} دج',
                            style: TextStyle(
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                          onPressed: () {
                            _courseDetailController.checkSubscription(context);
                          },
                          text: (_courseDetailController.userIsSubscribed)?'الدخول إلى الدورة':'الاشتراك في الدورة',
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getScreenSize(BuildContext context){
    double screenHeightMinusAppBarMinusStatusBar = MediaQuery.of(context).size.height
        - AppBar().preferredSize.height
        - MediaQuery.of(context).padding.top;
    return screenHeightMinusAppBarMinusStatusBar;
  }
}
