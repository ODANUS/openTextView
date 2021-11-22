import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/option_backup.dart';
import 'package:open_textview/component/option_filter.dart';
import 'package:open_textview/component/option_history.dart';
import 'package:open_textview/component/option_osslicense.dart';
import 'package:open_textview/component/option_theme.dart';
import 'package:open_textview/component/option_tts.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings".tr),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Card(child: OptionBackup()),
          Card(child: OptionTts()),
          Card(child: OptionFilter()),
          Card(child: OptionHistory()),

          Card(child: OptionTheme()),
          // Card(child: OptionCache()),
          // Card(child: OptionOcr()),
          Card(child: OptionOsslicense()),
          Card(
            child: ListTile(
                title: Text('See_how_to_solve_the_tts_voice_problem'.tr),
                onTap: () {
                  launch(
                      "https://github.com/khjde1207/openTextView/blob/main/datas/ttsapk/README.md");
                }),
          ),
          Divider(),
          AdsComp(),
          if (kDebugMode)
            ElevatedButton(
                onPressed: () async {
                  var status = await Permission.storage.status;

                  if (!status.isGranted) {
                    await Permission.storage.request();
                  }
                  Directory d = Directory("${controller.libraryPaths[0]}/OCR");
                  File("${d.path}/test_ocr.txt")
                      .writeAsStringSync("testestestes");
                },
                child: Text("test")),
        ],
      ),
    );
  }
}
