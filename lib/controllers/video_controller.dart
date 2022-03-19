import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../views/dialogs/rating_dialog.dart';

class VideoController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;
  TextEditingController? noteController;
  final GetStorage noteBox = GetStorage('app_note');
  final GetStorage appBox = GetStorage('app_data');
  final videoId = Get.arguments['video_id'];

  @override
  void onInit() {
    print('>>>>>>>>>>>>>> $videoId');
    tabController = TabController(length: 3, vsync: this);
    noteController = TextEditingController();
    _getNotes();
    super.onInit();
  }

  @override
  void onClose() {
    noteController!.dispose();
    tabController!.dispose();
    super.onClose();
  }



  addNote(BuildContext context){
    noteBox.write('video_${videoId}_notes', noteController!.text);
    Fluttertoast.showToast(
        msg: 'تم الحفظ',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  _getNotes()async{
    String? notes = noteBox.read('video_${videoId}_notes');
    if(notes == null){
      noteController!.text= '';
    }else{
      noteController!.text = notes;
    }
  }

  showReview(BuildContext context)async{
    var reviewWasSeen = await appBox.read('review_${videoId}_was_seen');
    if (reviewWasSeen == null){
      await appBox.write('review_${videoId}_was_seen',true);
      Get.dialog(showRatingDialog(
          context, 'قرأن أون لاين', 'برجاء وضع تقييمك وأي ملاحظات في الدرس'));
    }
  }


}