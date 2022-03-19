import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:quran_online/controllers/video_player_controller.dart';
import 'package:get/get.dart';
class CustomVideoPlayer extends StatelessWidget {
  final String? videoUrl;
  CustomVideoPlayer({Key? key , required this.videoUrl}) : super(key: key);
  final CustomVideoPlayerController _videoPlayerController = Get.put(CustomVideoPlayerController());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(
        controller: _videoPlayerController.chewieController!,
      ),
    );
  }
}
