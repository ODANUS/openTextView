import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:get/get.dart';

class OptionReview extends GetView {
  @override
  Widget build(BuildContext context) {
    // final pageCtl = Get.put(OptionOsslicenseCtl());

    return Row(
      children: [
        IconButton(
            onPressed: () async {
              final InAppReview inAppReview = InAppReview.instance;
              if (await inAppReview.isAvailable()) {
                inAppReview.openStoreListing();
              }
            },
            icon: Icon(Icons.rate_review_outlined)),
        IconButton(
            onPressed: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              Share.share(
                  'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
            },
            icon: Icon(Icons.share)),
      ],
    );
  }
}
