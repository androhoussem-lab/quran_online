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
        child: Obx(() {
          if (_courseController.loading.isTrue) {
            return Center(child: SpinKitCubeGrid(
              size: 50,
              color: Theme
                  .of(context)
                  .primaryColor,
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
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 20,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SmoothPageIndicator(
                      controller: _courseController.pageController!,
                      // PageController
                      count: (_courseController.courses.isEmpty)?1:_courseController.courses.length,
                      effect: WormEffect(
                          activeDotColor: Theme
                              .of(context)
                              .primaryColor,
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
    return GetBuilder<CoursesController>(builder: (coursesController) =>
        PageView.builder(
          itemCount: coursesController.courses.length,
          controller: coursesController.pageController,
          onPageChanged: (index) {
            coursesController.index = index;
          },
          itemBuilder: (context, index) =>
              GestureDetector(
                onTap: () {
                  _courseController.checkAndGoToNextPage();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomCircleImage(
                        width: 300,
                        height: 300,
                        imagePath: _courseController.courses[index].imageUrl!,
                        borderColor: Theme
                            .of(context)
                            .primaryColor,
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
                          ' ${_courseController.courses[index]
                              .videosCount!}  درس ',
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
        ));
  }
}
