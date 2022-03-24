import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/views/widgets/background_widget.dart';
import 'package:quran_online/views/widgets/custom_button.dart';
import 'package:quran_online/views/widgets/custom_text_form_field.dart';

import '../../../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text(
          'الدخول',
          style: TextStyle(fontFamily: 'cairo'),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const Center(
              child: BackgroundWidget(
            imagePath: 'assets/images/background_2.png',
            opacity: 0.5,
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _loginController.formKey,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                              enabled: true,
                              controller: _loginController.codeController,
                              maxLength: 30,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              labelText: 'رمز الاشتراك',
                              color: Theme.of(context).primaryColorDark,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return 'يرجى إدخال رمز تفعيل صالح';
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),
                  ),
                )),
                CustomButton(
                    onPressed: () {
                      _loginController.subscribe(context);
                    },
                    text: 'الدخول',
                    color: Theme.of(context).primaryColorDark)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
