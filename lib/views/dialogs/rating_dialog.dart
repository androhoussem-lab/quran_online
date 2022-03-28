import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:quran_online/controllers/video_controller.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:get/get.dart';

VideoController _videoController = Get.find();

    showRatingDialog(
      BuildContext context,
      String title,
      String content,
    ) {
      return RatingDialog(
        initialRating: 1.0,
    // your app's name?
        starColor: Theme.of(context).primaryColor,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
    // encourage your user to leave a high rating?
        message: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'cairo', fontSize: 16, color: Colors.grey.shade700),
        ),
    // your app's logo?
        image:  Image.asset('assets/images/app_icon.png' , width: 80,height: 80,),
        submitButtonText: 'إرسال',
        submitButtonTextStyle: TextStyle(
            fontFamily: 'cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
        commentHint: 'أضف تعليق',
        onCancelled: () => print('إلغاء'),
        onSubmitted: (response) {
          if(response.comment.isEmpty){
            Fluttertoast.showToast(
                msg: 'يرجى كتابة رأيكم لأنه مهم بالنسبة لنا',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 16.0);
          }else{
            _videoController.sendReview(context: context, stars: response.rating.toInt(), review: response.comment);
          }
        },
      );
    }
