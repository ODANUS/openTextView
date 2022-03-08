import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';

class OptionThemeCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;
}

class OptionTheme extends GetView<BoxCtl> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionThemeCtl());

    return Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                        groupValue: controller.setting.value.theme,
                        value: "light",
                        onChanged: (v) {
                          controller.setting.update((val) {
                            val!.theme = "light";
                          });
                          Get.changeTheme(ThemeData.light());
                        }),
                    Text('light theme'.tr),
                  ],
                ),
                Row(children: [
                  Radio(
                      groupValue: controller.setting.value.theme,
                      value: "dark",
                      onChanged: (v) {
                        controller.setting.update((val) {
                          val!.theme = "dark";
                        });
                        Get.changeTheme(ThemeData.dark());
                      }),
                  Text('Dark theme'.tr),
                ]),
              ],
            )
        // ExpansionTile(
        //   onExpansionChanged: (b) async {},
        //   title: Text("Style Theme settings".tr),
        //   children: [
        //     ListTile(
        //         title: Text('light theme'.tr),
        //         onTap: () {
        //           controller.userData.update((val) {
        //             val!.theme = "light";
        //           });
        //           Get.changeTheme(ThemeData.light());
        //         }),
        //     ListTile(
        //         title: Text('Dark theme'.tr),
        //         onTap: () {
        //           controller.userData.update((val) {
        //             val!.theme = "dark";
        //           });
        //           Get.changeTheme(ThemeData.dark());
        //         }),
        //   ],
        // ),
        // if (pageCtl.isLoading.value)
        //   Positioned.fill(
        //     child: Container(
        //       color: Colors.black12,
        //       alignment: Alignment.center,
        //       child: CircularProgressIndicator(),
        //     ),
        //   ),

        );
  }
}
