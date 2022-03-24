import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/controllers/video_controller.dart';
import 'package:quran_online/views/widgets/custom_Text_viewer.dart';
import 'package:quran_online/views/widgets/custom_button.dart';
import 'package:quran_online/views/widgets/download_widget.dart';

import '../widgets/custom_video_player.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key? key}) : super(key: key);
  final VideoController _videoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _videoController.showReview(context);
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
                    child: (_videoController.documents == null || _videoController.documents!.isEmpty)
                        ? ( Center(
                            child: Text(
                              'لا توجد مرفقات',
                              style: TextStyle(fontFamily: 'Cairo' , color: Theme.of(context).primaryColor),
                            ),
                          ))
                        : ListView.builder(
                      itemCount: _videoController.documents!.length,
                      itemBuilder: (context, index) {
                        return Obx(()=> GestureDetector(
                          onTap: () {
                            _videoController.downloadFile();
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height *
                                  0.1,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _videoController.documents![index].name!,
                                        style: TextStyle(
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                          TextDecoration.underline,
                                          color: Theme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                      DownloadWidget(
                                          downloadState: _videoController
                                              .downloadState.value,
                                          progress: _videoController
                                              .progress.value),
                                    ],
                                  ),
                                ),
                              )),
                        ));
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _videoController.noteController,
                              cursorColor: Theme.of(context).primaryColor,
                              maxLength: 255,
                              maxLines: 20,
                              decoration: InputDecoration(
                                label: Text(
                                  'ملاحظاتي',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ),
                                labelStyle: TextStyle(
                                    letterSpacing: 1.5,
                                    fontFamily: 'cairo',
                                    color: Theme.of(context).primaryColor),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          CustomButton(
                              onPressed: () {
                                _videoController.addNote(context);
                              },
                              text: 'حفظ',
                              color: Theme.of(context).primaryColor)
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
