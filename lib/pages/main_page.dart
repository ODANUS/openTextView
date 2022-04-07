import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

import 'package:get/get.dart';
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
        child: Scaffold(
          body: Obx(() => IndexedStack(index: IsarCtl.tabIndex.value, children: [
                ReadPage(),
                LibraryPage(),
                SettingPage(),
                HistoryPage(),
              ])),

          bottomNavigationBar: Obx(
            () => AnimatedContainer(
              key: Key("bottombar"),
              color: Colors.transparent,
              duration: const Duration(milliseconds: 300),
              height: IsarCtl.bfullScreen.value ? 0 : 60,
              // transform: Matrix4.translationValues(
              //     0, IsarCtl.bfullScreen.value ? 60 : 0, 0),
              // onEnd: () => v(IsarCtl.bfullScreen.value),
              child: ListView(
                shrinkWrap: true,
                children: [
                  BottomNavigationBar(

                      // backgroundColor: Colors.red,
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
                      ]),
                ],
              ),
            ),
          ),

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
        ));
  }
}
