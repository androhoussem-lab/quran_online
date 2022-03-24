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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                    offset: const Offset(1.0, -200),
                    child: const Icon(Icons.book_outlined,
                        size: 64, color: Colors.white)),
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
