import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController? codeController;

  @override
  void onInit() {
    codeController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    codeController!.dispose();
    super.onClose();
  }
}
