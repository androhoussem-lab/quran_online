import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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


  _fetchVideosByCourseId(int courseId){
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


}
