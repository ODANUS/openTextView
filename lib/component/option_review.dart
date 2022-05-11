import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:package_info/package_info.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:store_checker/store_checker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OptionReview extends GetView {
  OptionReview() {
    StoreChecker.getSource.then((value) {
      installationSource(value);
    });
  }
  Rxn<Source> installationSource = Rxn<Source>();
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SizedBox();
    }
    return Obx(() {
      if (installationSource.value != Source.IS_INSTALLED_FROM_PLAY_STORE &&
          installationSource.value != Source.IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE &&
          installationSource.value != Source.IS_INSTALLED_FROM_LOCAL_SOURCE &&
          installationSource.value != Source.IS_INSTALLED_FROM_APP_STORE) {
        return SizedBox();
      }
      return Row(
        children: [
          IconButton(
              onPressed: () async {
                if (installationSource.value == Source.IS_INSTALLED_FROM_PLAY_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  launchUrlString('https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
                }
                if (installationSource.value == Source.IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  launchUrlString('https://apps.samsung.com/appquery/appDetail.as?appId=${packageInfo.packageName}');
                }
                if (installationSource.value == Source.IS_INSTALLED_FROM_LOCAL_SOURCE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  if (Platform.isAndroid) {
                    launchUrlString('https://apps.samsung.com/appquery/appDetail.as?appId=${packageInfo.packageName}');
                  } else if (Platform.isIOS) {
                    launchUrlString('https://apps.apple.com/app/${packageInfo.packageName}');
                  }
                }
                if (installationSource.value == Source.IS_INSTALLED_FROM_APP_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  launchUrlString('https://apps.apple.com/app/${packageInfo.packageName}');
                  // launch('https://apps.samsung.com/appquery/appDetail.as?appId=${packageInfo.packageName}');
                }
              },
              icon: Icon(Icons.rate_review_outlined)),
          IconButton(
              onPressed: () async {
                if (installationSource.value == Source.IS_INSTALLED_FROM_PLAY_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  Share.share('https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
                }
                if (installationSource.value == Source.IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  Share.share('https://apps.samsung.com/appquery/appDetail.as?appId=${packageInfo.packageName}');
                }
                if (installationSource.value == Source.IS_INSTALLED_FROM_LOCAL_SOURCE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  Share.share('https://apps.samsung.com/appquery/appDetail.as?appId=${packageInfo.packageName}');
                }
                if (installationSource.value == Source.IS_INSTALLED_FROM_APP_STORE) {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  Share.share('https://apps.apple.com/app/${packageInfo.packageName}');
                }
              },
              icon: Icon(Icons.share)),
        ],
      );
    });
  }
}
