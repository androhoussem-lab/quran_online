import 'package:get/get.dart';
import '../views/pages/about_page.dart';
import '../views/pages/authentication/authentication_page.dart';
import '../views/pages/authentication/login_page.dart';
import '../views/pages/authentication/payment_page.dart';
import '../views/pages/course_content_page.dart';
import '../views/pages/course_detail_page.dart';
import '../views/pages/courses_page.dart';
import '../views/pages/video_page.dart';


List<GetPage> pages = [

    GetPage(
      name: '/authentication_page',
      page: () => const AuthenticationPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: '/login_page',
      page: () => LoginPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: '/payment_page',
      page: () => PaymentPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: '/home',
      page: () => CoursePage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: '/course_detail_page',
      page: () => CourseDetailPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: '/course_content_page',
      page: () => CourseContentPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: '/video_page',
      page: () => VideoPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),

    GetPage(
      name: '/about_page',
      page: () => const AboutPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
  ];
