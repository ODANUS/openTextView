import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/i18n.dart';
import 'package:open_textview/pages/image_search_page.dart';
import 'package:open_textview/pages/main_page.dart';
import 'package:open_textview/provider/custom_theme.dart';
import 'package:wakelock/wakelock.dart';

// !I/de.opentextvie, !DynamiteModule, !DynamitePackage, !Ads, !Codec, !audio, !Ad with id , !ExoPlayerImpl, !ReflectedParamUpdater, !OMXClient, !BufferPoolAccessor, !SurfaceUtils , !MetadataUtil, !BpHwBinder
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get.lazyPut(() => GlobalController());
  Get.put(BoxCtl());

  await AudioPlay.init();
  Wakelock.enable();
  // FlutterDownloader.initialize(
  //     debug: true // optional: set false to disable printing logs to console
  //     );
  runApp(ScreenUtilInit(
      //  BoxConstraints(
      //       maxWidth: MediaQuery.of(context).size.width,
      //       maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(1080 / 2.5, 2400 / 2.5),
      // allowFontScaling: false,
      // data: MediaQuery.of(Get.context!).copyWith(textScaleFactor: 1.0),
      builder: () {
        ScreenUtil().setSp(24);
        return GetMaterialApp(
            translations: Messages(),
            locale: Get.deviceLocale,
            // locale: Locale('ko'),
            theme: CustomTheme.lightTheme(),
            darkTheme: CustomTheme.darkTheme(),
            fallbackLocale: Locale('en'),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            getPages: [
              GetPage(name: '/', page: () => MainPage()),
              GetPage(name: '/searchpage', page: () => ImageSearchPage()),
            ]);
      }));
}
