import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:quran_online/models/user_model.dart';
import 'package:quran_online/services/api_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:quran_online/utils/connectivity_util.dart';
import 'dart:io' show Platform;

import 'package:quran_online/views/dialogs/waiting_dialog.dart';

import '../models/payment_model.dart';
import '../views/dialogs/confirmation_alert_dialog.dart';

class PaymentController extends GetxController {
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? mobileController;
  final ApiServices _apiServices = ApiServices.instance;
  final GetStorage paymentBox = GetStorage('payment_data');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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

  void makePayment(BuildContext context , int courseId) async {
   await ConnectivityUtil.checkDeviceIsConnected().then((value)async{
     if(value){
       if (formKey.currentState!.validate()) {
         if (_path!.isNotEmpty) {
           showConfirmationDialog(
               context: context,
               title: 'طلب الإشتراك',
               body:
               'هل تريد إرسال هذه المعلومات؟',
               confirmButtonText: 'بالتأكيد',
               cancelButtonText: 'رجوع',
               confirm: () async{
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
                   'formation_id': courseId.toString(),
                   'image': MultipartFile.fromFileSync(_path!, filename: fileName , contentType: MediaType('image','jpeg')),
                 };
                 showWaitingDialog();
                 _apiServices.makePayment(paymentData).then((result) {
                   if(result != null){
                     _saveDateToDataBase(result);
                     Fluttertoast.showToast(
                         msg: 'تمت عملية الإرسال بنجاح',
                         toastLength: Toast.LENGTH_LONG,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Theme.of(context).primaryColorDark,
                         textColor: Colors.white,
                         fontSize: 16.0);
                     Get.offAllNamed('/home');
                   }
                 }).onError((error, stackTrace) {
                   Fluttertoast.showToast(
                       msg: error.toString(),
                       toastLength: Toast.LENGTH_LONG,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Theme.of(context).primaryColor,
                       textColor: Colors.white,
                       fontSize: 16.0);
                   Get.back();
                   return null;
                 });
               },
               cancel: () {
                 Get.back();
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
     else{
       Fluttertoast.showToast(
           msg: 'لا يوجد إتصال بالأنتورنات',
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Theme.of(Get.context!).primaryColor,
           textColor: Colors.white,
           fontSize: 16.0);
     }
   });
  }

  Future<String?> getDeviceName() async {
    String? deviceName;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = '${androidInfo.id}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    }
    return deviceName;
  }

  _saveDateToDataBase(PaymentModel paymentModel)async{
    var paymentToJson = json.encode(paymentModel.toMap());
    await paymentBox.write('payment_${paymentModel.courseId}', paymentToJson);
  }

}
