import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomVideoPlayer extends StatelessWidget {
  final String? videoUrl;
  const CustomVideoPlayer({Key? key , required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        videoUrl!,
        //videoUrl!,
        betterPlayerConfiguration:  const BetterPlayerConfiguration(
          aspectRatio: 16 / 9,  // default aspect ratio
          fullScreenAspectRatio: 16 / 9,  // fullscreen mode aspect ratio
          autoPlay: true,
          //placeholder: Center(child: SpinKitCubeGrid(size: 32,color: Theme.of(context).primaryColor,)),
          allowedScreenSleep: false,

        ),
      ),
    );
  }
}
