import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quran_online/utils/connectivity_util.dart';
import '../services/api_services.dart';

class CourseContentController extends GetxController {

  List<dynamic> videosList = [].obs;
  RxBool loading = false.obs;
  final ApiServices _apiServices = ApiServices.instance;
  int courseID = int.parse(Get.arguments['course_id']);

  @override
  void onInit() {
    _fetchVideosByCourseId(courseID);
    super.onInit();
  }


  _fetchVideosByCourseId(int courseId)async{
    await ConnectivityUtil.checkDeviceIsConnected().then((value){
      if(value){
        loading(true);
        _apiServices.getVideosByCourseId(courseId).then((value){
          if(value != null){
            loading(false);
            videosList = value;
          }else{
            Fluttertoast.showToast(
                msg: 'لا توجد بيانات حاليا',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(Get.context!).primaryColor,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
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


}
