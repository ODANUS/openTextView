import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/readpage_overlay.dart';

class OptionClipboard extends GetView<BoxCtl> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => SwitchListTile(
          value: controller.setting.value.useClipboard,
          onChanged: (e) {
            controller.setting.value.useClipboard = e;
            controller.setting.refresh();
          },
          title: Text("Clipboard Settings".tr),
        ));
    // onExpansionChanged: (b) async {},
    // title: Text("Clipboard Settings".tr),
  }
}
