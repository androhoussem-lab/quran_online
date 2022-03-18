import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:get/get.dart';

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
        image: const FlutterLogo(size: 80),
        submitButtonText: 'إرسال',
        submitButtonTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
        commentHint: 'أضف تعليق',
        onCancelled: () => print('إلغاء'),
        onSubmitted: (response) {
          print('rating: ${response.rating}, comment: ${response.comment}');
          Get.back();
    // TODO: add your own logic
          if (response.rating < 3.0) {
    // send their comments to your email or anywhere you wish
    // ask the user to contact you instead of leaving a bad review
          } else {
            _rateAndReviewApp();
          }
        },
      );
    }

    void _rateAndReviewApp() async {
    // refer to: https://pub.dev/packages/in_app_review
      final _inAppReview = InAppReview.instance;

      if (await _inAppReview.isAvailable()) {
        print('request actual review from store');
        _inAppReview.requestReview();
      } else {
        print('open actual store listing');
    // TODO: use your own store ids
        _inAppReview.openStoreListing(
          appStoreId: '<your app store id>',
          microsoftStoreId: '<your microsoft store id>',
        );
      }
    }
