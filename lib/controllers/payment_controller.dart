import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:quran_online/models/user_model.dart';
import 'package:quran_online/services/api_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io' show Platform;

import 'package:quran_online/views/dialogs/waiting_dialog.dart';

class PaymentController extends GetxController {
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? mobileController;
  final ApiServices _apiServices = ApiServices.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _path = '';

  set path(String? path) {
    _path = path;
    update();
  }

  String? get path => _path!;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    _apiServices.init();
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController!.dispose();
    lastNameController!.dispose();
    emailController!.dispose();
    mobileController!.dispose();
    super.onClose();
  }

  void makePayment(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (_path!.isNotEmpty) {
        formKey.currentState!.save();
        print(_path);
        showWaitingDialog();
        String fileName = path!.split('/').last;
        UserModel user = UserModel(
            firstName: firstNameController!.text,
            lastName: lastNameController!.text,
            email: emailController!.text,
            mobile: mobileController!.text);
        Map<String, dynamic> paymentData = {
          'nom': user.firstName,
          'prenom': user.lastName,
          'email': user.email,
          'telephone': user.mobile,
          'name_image': fileName,
          'device_name': await getDeviceName(),
          'formation_id': 3,
          'image': MultipartFile.fromFileSync(_path!, filename: fileName , contentType: MediaType('image','jpeg')),
        };
        _apiServices.makePayment(paymentData).then((result) {
          if(result != null){
            Get.close(0);
            Fluttertoast.showToast(
                msg: 'تمت عملية الإرسال بنجاح',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColorDark,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          //Get.back();
        }).onError((error, stackTrace) {
          debugPrint('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  ' +
              stackTrace.toString() +
              '>>>>>>>>>>>');
          Fluttertoast.showToast(
              msg: 'هناك خطأ، برجى إعادة المحاولة لاحقا',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.back();
          return null;
        });
      } else {
        Fluttertoast.showToast(
            msg: 'يرجى إضافة صورة الوصل',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<String?> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceName;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = '${androidInfo.id}';
      print(deviceName);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    }
    return deviceName;
  }
}
