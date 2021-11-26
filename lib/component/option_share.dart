import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionShare extends GetView {
  @override
  Widget build(BuildContext context) {
    // final pageCtl = Get.put(OptionOsslicenseCtl());

    return Stack(
      children: [
        ListTile(
          onTap: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();

            Share.share(
                'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
          },
          title: Text("어플 공유하기"),
        ),
      ],
    );
  }
}
