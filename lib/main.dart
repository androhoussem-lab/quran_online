import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/database/database.dart';
import 'package:quran_online/utils/initial_binding.dart';
import 'package:quran_online/utils/custom_theme.dart';
import 'package:quran_online/views/pages/authentication/authentication_page.dart';
import 'package:quran_online/views/pages/authentication/login_page.dart';
import 'package:quran_online/views/pages/authentication/payment_page.dart';
import 'package:quran_online/views/pages/course_content_page.dart';
import 'package:quran_online/views/pages/course_detail_page.dart';
import 'package:quran_online/views/pages/courses_page.dart';
import 'package:quran_online/views/pages/video_page.dart';

void main() async{
  await DataBase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'dz'),
      theme: CustomTheme.myTheme,
      initialBinding: InitialBinding(),
      getPages: [
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
      ],
      home: const AuthenticationPage(),
    );
  }
}
