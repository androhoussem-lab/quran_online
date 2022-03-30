import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:quran_online/controllers/on_boarding_controller.dart';
import 'package:get/get.dart';
import 'package:quran_online/views/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnBoardingController _onBoardingController = Get.find()..initialize(context);
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox.expand(
              child: VideoPlayer( _onBoardingController.videoPlayerController!)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16 , horizontal: 8),
              child: CustomButton(
                onPressed: () {
                  _onBoardingController.saveSeenAndGoToNextPage();
                },
                text: 'البدء',
                color: Theme.of(context).primaryColor,
              )),
        ],
      ),
    );
  }


}