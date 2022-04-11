import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/isar_ctl.dart';

class OptionReset extends GetView {
  openResetdialog() async {
    return await Get.dialog(
      AlertDialog(
        title: Text("Reset".tr),
        content: Text("Are you sure you want to reset".tr),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: Text("cancel".tr)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Get.back(result: true);
              },
              child: Text("confirm".tr))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExpansionTile(
          onExpansionChanged: (b) async {},
          title: Text("Reset".tr),
          children: [
            Card(
                child: ListTile(
              onLongPress: () async {
                bool rtn = await openResetdialog();

                if (rtn) {
                  IsarCtl.resetSetting();
                  // controller.resetSetting();
                }
              },
              title: Text("Reset settings".tr),
            )),
            Card(
                child: ListTile(
              onLongPress: () async {
                bool rtn = await openResetdialog();
                if (rtn) {
                  IsarCtl.resetHistory();
                  // controller.resetHistory();
                }
              },
              title: Text("history reset".tr),
            )),
            Card(
                child: ListTile(
              onLongPress: () async {
                bool rtn = await openResetdialog();
                if (rtn) {
                  IsarCtl.resetFilter();
                  // controller.resetFilter();
                }
              },
              title: Text("filter reset".tr),
            )),
          ],
        ),
      ],
    );
  }
}
