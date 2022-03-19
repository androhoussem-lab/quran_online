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
          Get.arguments['course_name']!,
          style: const TextStyle(fontFamily: 'cairo'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomVideoPlayer(videoUrl: Get.arguments['video_url']),
           Expanded(
             flex: 1,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child:  Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:  [
                    Expanded(
                     child:  CustomTextViewer(
                       text: Get.arguments['course_description'],
                     ),
                   ),
                  Row(
                    children: [
                      const Text(
                        'مقدمة من طرف : ',
                        style: TextStyle(fontFamily: 'cairo'),
                      ),
                      Text(
                        Get.arguments['course_teacher']!,
                        style: TextStyle(
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                     children: [
                       const Text(
                         'سعر الإشتراك :  ',
                         style: TextStyle(fontFamily: 'cairo'),
                       ),
                       Text(
                         '${Get.arguments['course_price']!} دج',
                         style: TextStyle(
                             fontFamily: 'cairo',
                             fontWeight: FontWeight.bold,
                             color: Theme.of(context).primaryColor),
                       ),
                     ],
                   ),
                   const SizedBox(height: 8,),
                   CustomButton(
                       onPressed: () {
                         //TODO:check this ligne
                          _courseDetailController.checkPaymentRequest(context ,int.parse(Get.arguments['course_id']),Get.arguments['course_name']!);
                         //Get.toNamed('/course_content_page' , arguments: {
                         //  'course_name' : Get.arguments['course_name']!,
                         //});
                       },
                       text: 'الاشتراك في الدورة',
                       color: Theme.of(context).primaryColor),
                 ],
               ),
             ),
           ),
        ],
      ),
    );
  }
}
