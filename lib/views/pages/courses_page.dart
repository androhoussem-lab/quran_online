import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quran_online/controllers/courses_controller.dart';
import 'package:get/get.dart';
import 'package:quran_online/views/widgets/custom_circle_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CoursePage extends StatelessWidget {
  CoursePage({Key? key}) : super(key: key);

  final CoursesController _courseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'قران أون لاين',
          style: TextStyle(fontSize: 20, fontFamily: 'cairo', letterSpacing: 2),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx((){
          if(_courseController.loading.isTrue){
            return  Center(child: SpinKitCubeGrid(
              size: 50,
              color: Theme.of(context).primaryColor,
            ),);
          }
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'الدورات المتاحة :',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SmoothPageIndicator(
                      controller: _courseController.pageController!,
                      // PageController
                      count: _courseController.courses.length,
                      effect: WormEffect(
                          activeDotColor: Theme.of(context).primaryColor,
                          dotColor: Colors.grey),
                      // your preferred effect
                      onDotClicked: (index) {}),
                ],
              ),
              _buildPages(context),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPages(BuildContext context) {
    return PageView.builder(
      itemCount: _courseController.courses.length,
      controller: _courseController.pageController,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Get.toNamed(
            '/course_detail_page',
            arguments: {
              'course_id': _courseController.courses[index].id!.toString(),
              'course_name': _courseController.courses[index].name!,
              'video_url': _courseController.courses[index].videoUrl!,
              'course_description': _courseController.courses[index].description!,
              'course_teacher': _courseController.courses[index].teacher!,
              'course_price': _courseController.courses[index].price.toString(),
            },
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomCircleImage(
                width: 300,
                height: 300,
                imagePath: _courseController.courses[index].imageUrl!,
                borderColor: Theme.of(context).primaryColor,
                opacity: 0.3),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _courseController.courses[index].name!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${_courseController.courses[index].videosCount!}  درس ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'cairo',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
