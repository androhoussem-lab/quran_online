import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_online/views/dialogs/confirmation_alert_dialog.dart';

class CourseDetailController extends GetxController {
  final GetStorage _paymentBox = GetStorage('payment_data');

  @override
  void onInit() async {
    super.onInit();
  }

  checkPaymentRequest(
      BuildContext context, int courseId, String courseName) async {
    Map<String, dynamic>? _paymentData = await _getPaymentFromStorage(courseId);

    if (_paymentData == null) {
      Get.offNamed('/payment_page' , arguments: {
        'course_id':courseId,
      });
    } else {
      showConfirmationDialog(
          context: context,
          title: 'طلب الإشتراك',
          body:
              'لقد قمت بالفعل بطلب الإشتراك في دورة $courseName  ، هل تريد الطلب مرة أخرى',
          confirmButtonText: 'بالتأكيد',
          cancelButtonText: 'رجوع',
          confirm: () {
            Get.back();
            Get.toNamed('/payment_page' , arguments: {
              'course_id':courseId,
            });
          },
          cancel: () {
            Get.back();
          });
    }
  }

  Future<Map<String, dynamic>?>? _getPaymentFromStorage(int courseId) async {
    var paymentData = await _paymentBox.read('payment_$courseId');
    Map<String, dynamic>? paymentFromDatabase;
    if (paymentData != null) {
      paymentFromDatabase = json.decode(paymentData);
      return paymentFromDatabase!;
    }
    return paymentFromDatabase;
  }

  checkSubscription(BuildContext context){
    bool userIsSubscribed = Get.arguments['user_is_subscribed'];
    if(userIsSubscribed){
      Get.offNamed('/course_content_page' , arguments: {
        'course_id' : Get.arguments['course_id'],
        'course_name' : Get.arguments['course_name']!,
      });
    }else{
      checkPaymentRequest(context ,int.parse(Get.arguments['course_id']),Get.arguments['course_name']!);
    }
  }
}
