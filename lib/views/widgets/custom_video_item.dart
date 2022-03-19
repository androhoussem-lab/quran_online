import 'package:flutter/material.dart';
import 'package:quran_online/models/video_model.dart';
import 'package:quran_online/views/widgets/custom_icon_button.dart';
import 'package:get/get.dart';

class CustomVideoItem extends StatelessWidget {
  final int? index;
  final VideoModel? videoModel;

  const CustomVideoItem(
      {Key? key, required this.index, required this.videoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/quran_background.jpg',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                CustomIconButton(
                    onTap: () {
                      Get.toNamed('/video_page',arguments: {
                        'video_id' : videoModel!.id!,
                        'video_title' : videoModel!.title!,
                        'video_description' : videoModel!.description!,
                        'video_url' : videoModel!.videoUrl!,
                        //'video_documents' : videoModel!.documents,
                      });
                    },
                    icon: Icons.play_circle_outline,
                    size: 64,
                    color: Colors.white)
              ],
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' ${index! + 1} - ${videoModel!.title!}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          videoModel!.time!,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontFamily: 'cairo',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
