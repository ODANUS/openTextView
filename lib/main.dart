import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/i18n.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/pages/main_page.dart';
import 'package:open_textview/pages/merge_page.dart';
import 'package:open_textview/pages/ocr_edit_page%20.dart';
import 'package:open_textview/pages/ocr_page.dart';
import 'package:open_textview/pages/texteditor_page.dart';
import 'package:open_textview/provider/custom_theme.dart';
import 'package:wakelock/wakelock.dart';

// !I/de.opentextvie, !DynamiteModule, !DynamitePackage, !Ads, !Codec, !audio, !Ad with id , !ExoPlayerImpl, !ReflectedParamUpdater, !OMXClient, !BufferPoolAccessor, !SurfaceUtils , !MetadataUtil, !BpHwBinder

Future<void> initCtl() async {
  // await Get.putAsync<IsarCtl>(() => IsarCtl().init());
  // Get.put(BoxCtl());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // Get.lazyPut(() => GlobalController());
  // await initCtl();
  await IsarCtl.init();
  await AudioPlay.init();
  AdCtl.init();
  Wakelock.enable();
  // IsarCtl.bScreenHelp(true);
  runApp(ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) {
        ScreenUtil().setSp(24);

        return GetMaterialApp(
            translations: Messages(),
            locale: Get.deviceLocale,
            // locale: Locale('ko'),
            theme: CustomTheme.darkTheme(),
            darkTheme: CustomTheme.darkTheme(),
            fallbackLocale: Locale('en'),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            getPages: [
              GetPage(name: '/', page: () => MainPage()),
              GetPage(name: '/ocr', page: () => OcrPage()),
              GetPage(name: '/ocr/edit', page: () => OcrEditPage()),
              GetPage(name: '/merge', page: () => MergePage()),
              GetPage(name: '/editor', page: () => TextEditorPage()),
            ]);
      }));

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Future.delayed(1.seconds).then((value) {
      IsarCtl.bScreenHelp(false);
    });
  });
}
