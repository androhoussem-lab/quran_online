import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayerController extends GetxController {
  VideoPlayerController? _videoPlayerController;
  ChewieController? chewieController;
  String videoUrl = Get.arguments['video_url'];

  @override
  void onInit() {
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
      autoInitialize: true,
        materialProgressColors: ChewieProgressColors(
            playedColor: Theme.of(Get.context!).primaryColor,
            bufferedColor: Theme.of(Get.context!).primaryColor.withOpacity(0.2),
            handleColor: Theme.of(Get.context!).primaryColor,
        ),
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        aspectRatio: 16 / 9 ,
        errorBuilder: (context, errorMessage) {
        return  Center(
          child:  Text(
            'خطأ في رابط الفيديو',
            style: TextStyle(fontFamily: 'Cairo',color: Theme.of(Get.context!).primaryColor , fontSize: 20),
          ),
        );
      },
    );
    super.onInit();
  }
  @override
  void onClose() {
    _videoPlayerController!.dispose();
    chewieController!.dispose();
    super.onClose();
  }
}
