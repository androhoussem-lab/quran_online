import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:quran_online/consts/routes.dart';
import 'package:quran_online/database/database.dart';
import 'package:quran_online/utils/initial_binding.dart';
import 'package:quran_online/utils/custom_theme.dart';
import 'package:quran_online/views/pages/authentication/authentication_page.dart';



void main() async{
  await DataBase.init();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'dz'),
      theme: CustomTheme.myTheme,
      initialBinding: InitialBinding(),
      getPages: pages,
      home: const AuthenticationPage(),
    );
  }
}
