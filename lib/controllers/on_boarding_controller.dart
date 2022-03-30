import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';


class OnBoardingController extends GetxController{

  final GetStorage appBox = GetStorage('app_data');
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() {

    super.onInit();
  }

  initialize(BuildContext context){
    videoPlayerController = VideoPlayerController.asset('assets/media/on_boarding_video.mp4');
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoInitialize: true,
      looping: true,
      aspectRatio: MediaQuery.of(context).size.aspectRatio,
      showControls: false,
      showControlsOnInitialize: false,
      autoPlay: true,
      errorBuilder: (context, errorMessage) {
        return  Center(
          child:  Text(
            'خطأ في رابط الفيديو',
            style: TextStyle(fontFamily: 'Cairo',color: Theme.of(Get.context!).primaryColor , fontSize: 20),
          ),
        );
      },
    );


  }






  saveSeenAndGoToNextPage()async{
    Get.offNamed('/authentication_page');
  }

  @override
  void onClose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.onClose();
  }

}