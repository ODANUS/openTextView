import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/component/option_backup.dart';

import 'package:open_textview/component/option_developer_notes.dart';
import 'package:open_textview/component/option_filter.dart';
import 'package:open_textview/component/option_osslicense.dart';
import 'package:open_textview/component/option_reset.dart';
import 'package:open_textview/component/option_review.dart';
import 'package:open_textview/component/option_tts.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("Settings".tr),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionReview(),
            ],
          ),
          // OptionPopupAds(),
          IconButton(
              onPressed: () {
                // if (AdCtl.hasOpenInterstitialAd()) {
                AdCtl.openInterstitialAd();
                // }
                // hasOpenInterstitialAd
              },
              icon: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Icon(Icons.smart_display),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "AD",
                    ),
                  ),
                ],
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: AdBanner(key: Key("setting")),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
        children: [
          SizedBox(height: 5),
          Card(child: OptionBackup()),
          Card(child: OptionTts()),
          Card(child: OptionFilter()),
          Card(child: DeveloperNotes()),
          Card(
            child: ListTile(
                title: Text('See_how_to_solve_the_tts_voice_problem'.tr),
                onTap: () {
                  launch("https://github.com/khjde1207/openTextView/blob/main/datas/ttsapk/README.md");
                }),
          ),
          Card(child: OptionOsslicense()),
          Card(child: OptionReset()),
          Divider(),
          if (kDebugMode)
            ElevatedButton(
                onPressed: () async {
                  // Utils.loadprefs();
                  // 15890496
                  // var d = await getLibraryDirectory();
                  // d.list().listen((event) {
                  //   print(event.path);
                  //   if (event is Directory) {
                  //     print(">>>>>>>>>>>>>>>>>>>> ${event.listSync()}");
                  //   }
                  //   // try {
                  //   //   var d1 = Directory(event.path);
                  //   // } catch (e) {}
                  // });

                  // var d1 = await getExternalCacheDirectories();
                  // d1!.forEach((element) {
                  //   element.list().listen((event) {
                  //     print(event.path);
                  //   });
                  // });
                  // var status = await Permission.storage.status;

                  // if (!status.isGranted) {
                  //   await Permission.storage.request();
                  // }
                  // Directory d = Directory("${controller.libraryPaths[0]}/OCR");
                  // File("${d.path}/test_ocr.txt")
                  //     .writeAsStringSync("testestestes");
                },
                child: Text("test")),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }
}
