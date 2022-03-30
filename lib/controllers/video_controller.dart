import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quran_online/services/download_service.dart';
import 'package:open_file/open_file.dart';
import 'package:quran_online/views/dialogs/waiting_dialog.dart';
import '../services/api_services.dart';
import '../views/dialogs/rating_dialog.dart';

class VideoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController? noteController;
  final GetStorage noteBox = GetStorage('app_note');
  final GetStorage appBox = GetStorage('app_data');
  static final GetStorage _downloadBox = GetStorage('document_data');
  final GetStorage subscriptionBox = GetStorage('account_data');

  final ApiServices _apiServices = ApiServices.instance;
  RxDouble progress = 0.0.obs;
  RxString downloadState = 'ready'.obs;
  RxInt index = 0.obs;
  final videoId = Get.arguments['video_id'];
  String videoTitle = Get.arguments['video_title'];
  String videoDescription = Get.arguments['video_description'];
  String videoUrl = Get.arguments['video_url'];
  List<dynamic>? documents = Get.arguments['video_documents'];

  @override
  void onInit() async {
    _apiServices.init();
    tabController = TabController(length: 3, vsync: this);
    noteController = TextEditingController();
    documents ??
        await _checkDataAndDownload(
            documents![index.value].id!, documents![index.value].name);
    _getNotes();
    super.onInit();
  }

  @override
  void onClose() {
    noteController!.dispose();
    tabController!.dispose();
    super.onClose();
  }

  addNote(BuildContext context) {
    if(noteController!.text.isNotEmpty){
      noteBox.write('video_${videoId}_notes', noteController!.text);
      Fluttertoast.showToast(
          msg: 'تم الحفظ',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColorDark,
          textColor: Colors.white,
          fontSize: 16.0);
    }else{
      Fluttertoast.showToast(
          msg: 'يرجى اضافة ملاحظات ليتم الحفظ',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColorDark,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }

  _getNotes() async {
    String? notes = noteBox.read('video_${videoId}_notes');
    if (notes == null) {
      noteController!.text = '';
    } else {
      noteController!.text = notes;
    }
  }

  showReview(BuildContext context) async {
    var reviewWasSeen = await appBox.read('review_${videoId}_was_seen');
    if (reviewWasSeen == null) {

      Get.dialog(
          showRatingDialog(context, 'قرأن أون لاين',
              'برجاء وضع تقييمكم وأي تعليقات على الدرس'),
          barrierDismissible: false);
    }
  }

  downloadFile() async {
    int documentId = documents![index.value].id!;
    String documentName = documents![index.value].name!;
    String path = await _getFilePath(documentId, documentName);
    await _checkDataAndDownload(documentId, documentName).then((value) async {
      if (value) {
        OpenFile.open(path);
      } else {
        DownloadService.downloadFile(
            context: Get.context!,
            savePath: path,
            documentId: documents![index.value].id!,
            url: documents![index.value].documentUrl!,
            documentName: documents![index.value].name!);
      }
    });
  }

  Future<bool> _checkDataAndDownload(
      int documentId, String documentName) async {
    var documentFromDataBase =
        await _downloadBox.read('download_${documentId}_$documentName');
    if (documentFromDataBase == null) {
      downloadState.value = 'downloaded';
      return true;
    }
    downloadState.value = 'ready';
    return false;
  }

  static Future<String> _getFilePath(
      int documentId, String documentName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/downloads/${documentId}_$documentName.pdf';

    return path;
  }

  sendReview(
      {required BuildContext context,
      required int stars,
      required String review,}) async {
    showWaitingDialog();
    var userData = await subscriptionBox.read('subscription_${videoId}_data');
    if (userData != null) {}
    var stringToMap = json.decode(userData);
    Map<String, dynamic> reviewData = {
      'stars': stars.toString(),
      'review': review,
      'code': stringToMap['code'].toString(),
      'video_id': videoId.toString()
    };

    _apiServices.sendReview(reviewData).then((value) async{
      if (value != null && value['success'] == true) {
        Get.back();
        await appBox.write('review_${videoId}_was_seen', true);
        Fluttertoast.showToast(
            msg: 'شكرا لكم على أرائكم',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColorDark,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      }else{
        Get.back();
        Fluttertoast.showToast(
            msg: 'خطأ في الإرسال يرجى إعادة المحاولة لاحقا',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      }
    }).onError((error, stackTrace) {
      Get.back();
      Fluttertoast.showToast(
          msg: 'خطأ في الإرسال يرجى إعادة المحاولة لاحقا',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Get.back();
    });
  }
}
