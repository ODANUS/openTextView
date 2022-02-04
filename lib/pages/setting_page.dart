import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/option_backup.dart';
import 'package:open_textview/component/option_clipboard.dart';
import 'package:open_textview/component/option_developer_notes.dart';
import 'package:open_textview/component/option_filter.dart';
import 'package:open_textview/component/option_layout.dart';
import 'package:open_textview/component/option_osslicense.dart';
import 'package:open_textview/component/option_popup_ads.dart';
import 'package:open_textview/component/option_review.dart';
import 'package:open_textview/component/option_theme.dart';
import 'package:open_textview/component/option_tts.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends GetView<BoxCtl> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(Get.locale);
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
          OptionPopupAds(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
        children: [
          AdsComp(),
          SizedBox(height: 5),
          Card(child: OptionTheme()),
          // Card(child: OptionHistory()),
          Card(child: OptionBackup()),
          Card(child: OptionTts()),
          Card(child: OptionFilter()),
          Card(child: OptionLayout()),
          Card(child: OptionClipboard()),

          Card(child: DeveloperNotes()),

          // Card(child: OptionCache()),
          // Card(child: OptionOcr()),
          Card(
            child: ListTile(
                title: Text('See_how_to_solve_the_tts_voice_problem'.tr),
                onTap: () {
                  launch(
                      "https://github.com/khjde1207/openTextView/blob/main/datas/ttsapk/README.md");
                }),
          ),
          Card(child: OptionOsslicense()),
          Divider(),
          if (kDebugMode)
            ElevatedButton(
                onPressed: () async {
                  Utils.loadprefs();
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
