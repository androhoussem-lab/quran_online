import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_online/utils/connectivity_util.dart';
import 'package:quran_online/utils/date_time_utils.dart';
import '../services/api_services.dart';



class CoursesController extends GetxController{
  RxBool loading = false.obs;
  var courses = [].obs;
  final ApiServices _apiServices = ApiServices.instance;
  final GetStorage subscriptionBox = GetStorage('account_data');
  final DateTimeUtils _dateTimeUtils = DateTimeUtils();
  ConnectivityUtil? _connectivityUtil;
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
    _connectivityUtil = ConnectivityUtil();
    _apiServices.init();
    _fetchCourses();
    super.onInit();
  }

  _fetchCourses()async{
    ConnectivityUtil.checkDeviceIsConnected().then((value){
      if(!value){
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
    loading(true);
        _apiServices.getAllCourses().then((value){
          if(value != null){
            courses(value);
            loading(false);
          }
        }).catchError((error, stackTrace){
          print(error.runtimeType);
        });
  }

  Future<bool>_checkCode()async{

    var jsonFromDatabase = await subscriptionBox.read('subscription_${courses[index].id!}_data');
    if(jsonFromDatabase == null){
      return false;
    }else{
      var subscriptionData = json.decode(jsonFromDatabase);
      var expireDate = subscriptionData['expire_date'];
      if(_dateTimeUtils.getDaysBetween(expireDate) <= 0){
        return true;
      }else{
        return false;
      }
    }
  }

  checkAndGoToNextPage()async{
    _checkCode().then((value){
      if(value){
        Get.toNamed(
          '/course_detail_page',
          arguments: {
            'course_id': courses[index].id!.toString(),
            'course_name': courses[index].name!,
            'video_url':courses[index].videoUrl!,
            'course_description': courses[index].description!,
            'course_teacher': courses[index].teacher!,
            'course_price': courses[index].price.toString(),
            'user_is_subscribed' : true,
          },
        );
      }else{
        Get.toNamed(
          '/course_detail_page',
          arguments: {
            'course_id': courses[index].id!.toString(),
            'course_name': courses[index].name!,
            'video_url':courses[index].videoUrl!,
            'course_description': courses[index].description!,
            'course_teacher': courses[index].teacher!,
            'course_price': courses[index].price.toString(),
            'user_is_subscribed' : false,
          },
        );
      }
    });
  }

  @override
  void onClose() {
    pageController!.dispose();
    super.onClose();
  }
}