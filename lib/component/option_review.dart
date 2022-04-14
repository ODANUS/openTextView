import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:get/get.dart';
import 'package:store_checker/store_checker.dart';

class OptionReview extends GetView {
  OptionReview() {
    StoreChecker.getSource.then((value) {
      installationSource(value);
    });
  }
  Rxn<Source> installationSource = Rxn<Source>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (installationSource.value != Source.IS_INSTALLED_FROM_PLAY_STORE) {
        return SizedBox();
      }
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
                if (installationSource.value == Source.IS_INSTALLED_FROM_PLAY_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  Share.share('https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
                }
              },
              icon: Icon(Icons.share)),
        ],
      );
    });
  }
}
