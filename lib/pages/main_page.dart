import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

import 'package:get/get.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/pages/history_page.dart';
import 'package:open_textview/pages/library_page.dart';
import 'package:open_textview/pages/read_page.dart';
import 'package:open_textview/pages/setting_page.dart';

class MainPage extends GetView {
  var bClose = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!bClose) {
          bClose = true;
          Future.delayed(1.seconds, () {
            bClose = false;
          });
          Fluttertoast.showToast(
              msg: "Press once more to close".tr,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);

          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(child: OrientationBuilder(builder: (_, orientation) {
        return Scaffold(
          body: Obx(() {
            var bFullScreen = IsarCtl.bfullScreen.value;
            var tabIndex = IsarCtl.tabIndex.value;
            return Column(
              children: [
                IsarCtl.rxSetting((ctx, setting) {
                  if (IsarCtl.bRemoveAd.value && tabIndex == 0) return SizedBox();
                  if (!bFullScreen && setting.adPosition == 1)
                    return SizedBox(
                      width: Get.width,
                      height: 50,
                      child: AdBanner(),
                    );
                  return SizedBox();
                }),
                Expanded(
                  child: IndexedStack(index: IsarCtl.tabIndex.value, children: [
                    ReadPage(),
                    LibraryPage(),
                    SettingPage(),
                    HistoryPage(),
                  ]),
                ),
              ],
            );
          }),
          bottomNavigationBar: Obx(() {
            var bFullScreen = IsarCtl.bfullScreen.value;
            var tabIndex = IsarCtl.tabIndex.value;
            return AnimatedContainer(
              key: Key("bottombar"),
              color: Colors.transparent,
              duration: const Duration(milliseconds: 300),
              height: IsarCtl.bfullScreen.value ? 0 : null,
              // transform: Matrix4.translationValues(
              //     0, IsarCtl.bfullScreen.value ? 60 : 0, 0),
              // onEnd: () => v(IsarCtl.bfullScreen.value),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: IsarCtl.tabIndex.value,
                    onTap: IsarCtl.tabIndex,
                    items: [
                      BottomNavigationBarItem(
                        label: "text_viewer".tr,
                        icon: Icon(Icons.menu_book_outlined),
                      ),
                      BottomNavigationBarItem(
                        label: "my_library".tr,
                        icon: Icon(Ionicons.library_outline),
                      ),
                      BottomNavigationBarItem(
                        label: "Settings".tr,
                        icon: Icon(Ionicons.settings_outline),
                      ),
                      BottomNavigationBarItem(
                        label: "history".tr,
                        icon: Icon(Icons.history),
                      ),
                    ],
                  ),
                  IsarCtl.rxSetting((ctx, setting) {
                    if (IsarCtl.bRemoveAd.value && tabIndex == 0) return SizedBox();
                    if (!bFullScreen && setting.adPosition == 0)
                      return SizedBox(
                        width: Get.width,
                        height: 50,
                        child: AdBanner(),
                      );
                    return SizedBox();
                  })
                  // Obx(() => IsarCtl.bfullScreen.value ? SizedBox() : AdBanner()),
                ],
              ),
            );
          }),
        );

        // Obx(() => IsarCtl.bfullScreen.value
        //     ? SizedBox()
        //     : BottomNavigationBar(
        //         type: BottomNavigationBarType.fixed,
        //         currentIndex: IsarCtl.tabIndex.value,
        //         onTap: IsarCtl.tabIndex,
        //         items: [
        //             BottomNavigationBarItem(
        //               label: "text_viewer".tr,
        //               icon: Icon(Icons.menu_book_outlined),
        //             ),
        //             BottomNavigationBarItem(
        //               label: "my_library".tr,
        //               icon: Icon(Ionicons.library_outline),
        //             ),
        //             BottomNavigationBarItem(
        //               label: "Settings".tr,
        //               icon: Icon(Ionicons.settings_outline),
        //             ),
        //             BottomNavigationBarItem(
        //               label: "history".tr,
        //               icon: Icon(Icons.history),
        //             ),
        //           ])),
        // );
      })),
    );
  }
}
