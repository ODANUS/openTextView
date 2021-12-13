import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import 'package:get/get.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/controller/global_controller.dart';
// import 'package:open_textview/pages/image_viewer_page.dart';
import 'package:open_textview/pages/library_page.dart';
import 'package:open_textview/pages/read_page.dart';
import 'package:open_textview/pages/setting_page.dart';

class MainPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(index: controller.tabIndex.value, children: [
            ReadPage(),
            // ImageViewerPage(),
            LibraryPage(),
            SettingPage()
          ])),

      bottomNavigationBar: Obx(() {
        if (controller.bFullScreen.value) {
          return SizedBox();
        }

        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.tabIndex.value,
            onTap: (idx) => controller.tabIndex(idx),
            items: [
              BottomNavigationBarItem(
                label: "text_viewer".tr,
                icon: Icon(Icons.menu_book_outlined),
              ),
              // BottomNavigationBarItem(
              //   label: "이미지 뷰어",
              //   icon: Icon(Icons.image_outlined),
              // ),
              BottomNavigationBarItem(
                label: "my_library".tr,
                icon: Icon(Ionicons.library_outline),
              ),
              BottomNavigationBarItem(
                label: "Settings".tr,
                icon: Icon(Ionicons.settings_outline),
              ),
            ]);
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // floatingActionButton: FloatingButton(),
    );
  }
}
