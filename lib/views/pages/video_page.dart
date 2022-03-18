import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/controllers/video_controller.dart';
import 'package:quran_online/models/document_model.dart';
import 'package:quran_online/views/dialogs/rating_dialog.dart';
import 'package:quran_online/views/widgets/custom_Text_viewer.dart';
import 'package:quran_online/views/widgets/custom_button.dart';
import 'package:quran_online/views/widgets/custom_icon_button.dart';

import '../widgets/custom_video_player.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key? key}) : super(key: key);
  final List<DocumentModel> documents = Get.arguments['video_documents'];

  final VideoController _videoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(showRatingDialog(
            context, 'قرأن أون لاين', 'برجاء وضع تقييمك وأي ملاحظات في الدرس'));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Get.arguments['video_title']!,
            style: const TextStyle(fontFamily: 'cairo'),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomVideoPlayer(videoUrl: Get.arguments['video_url']),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 60,
              child: TabBar(
                controller: _videoController.tabController,
                isScrollable: false,
                indicatorWeight: 3,
                indicatorColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                tabs: [
                  Tab(
                    child: Text(
                      'الوصف',
                      style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'المرفقات',
                      style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'ملاحظاتي',
                      style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _videoController.tabController,
                children: [
                  CustomTextViewer(text: Get.arguments['video_description']!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      documents[index].name!,
                                      style: TextStyle(
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    CustomIconButton(
                                        onTap: () {},
                                        icon: Icons.arrow_circle_down,
                                        size: 24,
                                        color: Theme.of(context).primaryColor),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _videoController.noteController,
                              cursorColor: Theme.of(context).primaryColor,
                              maxLength: 255,
                              maxLines: 20,
                              decoration: InputDecoration(
                                label: Text('ملاحظاتي' , style: TextStyle(fontSize: 16 , color: Theme.of(context).primaryColor),),
                                labelStyle: TextStyle(
                                    letterSpacing: 1.5,
                                    fontFamily: 'cairo',
                                    color: Theme.of(context).primaryColor),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          CustomButton(onPressed: (){}, text: 'حفظ', color: Theme.of(context).primaryColor)

                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
