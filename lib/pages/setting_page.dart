import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';
import 'package:open_textview/component/option_backup.dart';
import 'package:open_textview/component/option_battery_optimization.dart';

import 'package:open_textview/component/option_developer_notes.dart';
import 'package:open_textview/component/option_filter.dart';
import 'package:open_textview/component/option_osslicense.dart';
import 'package:open_textview/component/option_reset.dart';
import 'package:open_textview/component/option_review.dart';
import 'package:open_textview/component/option_tts.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Settings".tr),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionReview(),
            ],
          ),
          // OptionPopupAds(),
        ],
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: AdBanner(key: Key("setting")),
        ),
      ),
      body: Stack(
        children: [
          IsarCtl.rxSetting((_, setting) {
            return Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                image: setting.bgIdx <= 0
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Color(setting.bgFilter), BlendMode.dstATop),
                        image: AssetImage('assets/images/${IsarCtl.listBg[setting.bgIdx]}'),
                      ),
              ),
            );
          }),
          ListView(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
            children: [
              SizedBox(height: 5),
              Card(child: OptionBackup()),
              Card(child: OptionTts()),
              Card(child: OptionFilter()),
              Card(child: DeveloperNotes()),
              if (Platform.isAndroid)
                Card(
                  child: ListTile(
                      title: Text('See_how_to_solve_the_tts_voice_problem'.tr),
                      onTap: () {
                        launchUrl(Uri.parse("https://github.com/khjde1207/openTextView/blob/main/datas/ttsapk/README.md"));
                      }),
                ),
              if (Platform.isAndroid) Card(child: OptionBatteryOptimization()),
              Card(child: OptionOsslicense()),
              Card(child: OptionReset()),
              Divider(),
              // if (kDebugMode)
              // ElevatedButton(
              //     onPressed: () async {
              //       var ss = "";

              //       var tts = FlutterTts();
              //       tts.speak(ss);

              //     },
              //     child: Text("test")),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }

  var ss = """
""";
}
