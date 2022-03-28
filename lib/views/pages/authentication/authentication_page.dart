import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/utils/custom_painter.dart';
import 'package:quran_online/views/widgets/background_widget.dart';
import 'package:quran_online/views/widgets/custom_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: AuthenticationPageBackground(
                color: Theme.of(context).primaryColor),
            child: Container(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BackgroundWidget(
              imagePath: 'assets/images/background.png',
              opacity: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8 , right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
                Image.asset('assets/images/app_icon_white.png' , width: 100 , height: 100,),
                SizedBox(height:  MediaQuery.of(context).size.height * 0.15,),
                CustomButton(
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                    text: 'التسجيل',
                    color: Theme.of(context).primaryColorDark),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    onPressed: () {
                      Get.toNamed('/login_page');
                    },
                    text: 'الدخول',
                    color: Theme.of(context).primaryColorDark),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    onPressed: () {
                      Get.toNamed('/about_page');
                    },
                    text: 'عن التطبيق',
                    color: Theme.of(context).primaryColorDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
