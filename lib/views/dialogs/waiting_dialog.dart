import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

showWaitingDialog() {
  Get.defaultDialog(
    barrierDismissible: false,
    title: 'يرجى اللإنتظار ...',
    titleStyle: const TextStyle(fontFamily: 'Montserrat'),
    content: const SpinKitCubeGrid(
      size: 48,
      color: Color(0xFFea526f),
    ),
  );
}
