import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_online/views/dialogs/waiting_dialog.dart';

import '../services/api_services.dart';
import '../utils/date_time_utils.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController? codeController;
  final ApiServices _apiServices = ApiServices.instance;
  final GetStorage subscriptionBox = GetStorage('account_data');
  final DateTimeUtils _dateTimeUtils = DateTimeUtils();


  @override
  void onInit() {
    codeController = TextEditingController();
    _apiServices.init();
    super.onInit();
  }

  @override
  void onClose() {
    codeController!.dispose();
    super.onClose();
  }

  subscribe(BuildContext context){
    if(formKey.currentState!.validate()){
      //TODO:check device name
      Map<String,dynamic> subscriptionData = {
        'code' : codeController!.text,
        'device_name' : 'ccc'
      };
      showWaitingDialog();
      _apiServices.getCourseByCode(subscriptionData).then((value)async{
        if(value != null && value.containsKey('token')){
          var expireDate = value['expire_date'];
          if(_dateTimeUtils.getDaysBetween(expireDate) < 0){
            Get.back();
            await subscriptionBox.write('subscription_${value['formation_id']}_data', json.encode(value));
            Get.toNamed('/home');
          }
          else{
            Fluttertoast.showToast(
                msg: 'الرمز الذي قمت بإدخاله غير صالج',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }else{
          Fluttertoast.showToast(
              msg: 'الرمز الذي قمت بإدخاله غير صالج',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    }
  }
}
