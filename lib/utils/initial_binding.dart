import 'package:get/get.dart';
import 'package:quran_online/controllers/course_content_controller.dart';
import 'package:quran_online/controllers/course_detail_controller.dart';
import 'package:quran_online/controllers/courses_controller.dart';
import 'package:quran_online/controllers/login_controller.dart';
import 'package:quran_online/controllers/payment_controller.dart';
import 'package:quran_online/controllers/video_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => CoursesController(), fenix: true);
    Get.lazyPut(() => CourseDetailController(), fenix: true);
    Get.lazyPut(() => CourseContentController(), fenix: true);
    Get.lazyPut(() => VideoController(),fenix: true);
  }
}
