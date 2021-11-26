import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionReview extends GetView {
  @override
  Widget build(BuildContext context) {
    // final pageCtl = Get.put(OptionOsslicenseCtl());

    return Stack(
      children: [
        ListTile(
          onTap: () async {
            final InAppReview inAppReview = InAppReview.instance;

            if (await inAppReview.isAvailable()) {
              inAppReview.openStoreListing();
            }
          },
          title: Text("리뷰 하러 가기"),
        ),
      ],
    );
  }
}
