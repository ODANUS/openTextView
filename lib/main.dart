import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/i18n.dart';
import 'package:open_textview/pages/main_page.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  Get.lazyPut(() => GlobalController());
  await AudioPlay.init();
  Wakelock.enable();
  runApp(
    GetMaterialApp(
        translations: Messages(),
        locale: Get.deviceLocale,
        // locale: Locale('ko'),
        fallbackLocale: Locale('en'),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        getPages: [GetPage(name: '/', page: () => MainPage())]),
  );
}
