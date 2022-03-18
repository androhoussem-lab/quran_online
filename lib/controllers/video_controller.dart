import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;
  TextEditingController? noteController;
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    noteController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    noteController!.dispose();
    tabController!.dispose();
    super.onClose();
  }


}