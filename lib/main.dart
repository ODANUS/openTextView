import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/MainCtl.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/pages/main_page.dart';

void main() async {
  Get.lazyPut(() => MainCtl());
  Get.lazyPut(() => GlobalController());
  await AudioPlay.init();
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        getPages: [GetPage(name: '/', page: () => MainPage())]),
  );
}

      // WillPopScope(
      //       child: ,
      //       onWillPop: () async {
      //         var ctl = Get.find<MainCtl>();
      //         var rtn = true;
      //         rtn &= ctl.ocrData['brun'] == 0;
      //         // rtn &= !AudioService.runningStream.value;

      //         ctl.update();
      //         return rtn;
      //       },
      //     )),