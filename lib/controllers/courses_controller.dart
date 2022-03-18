import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/models/course_model.dart';

import '../services/api_services.dart';


class CoursesController extends GetxController{
  RxBool loading = false.obs;
  var courses = [].obs;
  final ApiServices _apiServices = ApiServices.instance;

  PageController? pageController;
  int _index = 0;




  set index(int index){
    _index = index;
    update();
  }

  int get index => _index;



  @override
  void onInit() {
    pageController = PageController(
        initialPage: 0,
        viewportFraction: 1
    );
    _apiServices.init();
    _fetchCourses();
    super.onInit();
  }

  _fetchCourses(){
    loading(true);
    _apiServices.getAllCourses().then((value){
      if(value != null){
        courses(value);
        loading(false);
      }
    }).onError((error, stackTrace) => null);
  }


}