import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/readpage_overlay.dart';

class OptionUI extends GetView<BoxCtl> {
  openColorPicker(int colorData, Function(Color) fn, {bool balpha = true}) {
    Get.dialog(
      AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius:
              MediaQuery.of(Get.context!).orientation == Orientation.portrait
                  ? const BorderRadius.vertical(
                      top: Radius.circular(500),
                      bottom: Radius.circular(100),
                    )
                  : const BorderRadius.horizontal(right: Radius.circular(500)),
        ),
        content: SingleChildScrollView(
          child: HueRingPicker(
            portraitOnly: false,
            pickerColor: Color(colorData),
            onColorChanged: (c) {
              fn(c);
            },
            enableAlpha: balpha,
            displayThumbColor: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExpansionTile(
          onExpansionChanged: (b) async {},
          title: Text("UI Settings".tr),
          children: [
            Obx(() => Card(
                child: ListTile(
                    onTap: () {
                      openColorPicker(controller.setting.value.backgroundColor,
                          (c) {
                        controller.setting.value.backgroundColor = c.value;
                        controller.setting.refresh();
                      });
                    },
                    leading: Container(
                        width: 30,
                        height: 30,
                        color: Color(controller.setting.value.backgroundColor)),
                    title: Text("Background Color".tr),
                    trailing: ElevatedButton(
                        onPressed: () {
                          controller.setting.value.backgroundColor = 0x00FFFFFF;
                          controller.setting.refresh();
                        },
                        child: Text("delete".tr))))),
            Obx(() => Card(
                    child: ListTile(
                  onTap: () {
                    openColorPicker(
                        controller.setting.value.fontColor == 0
                            ? Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color!
                                .value
                            : controller.setting.value.fontColor, (c) {
                      controller.setting.value.fontColor = c.value;
                      controller.setting.refresh();
                    }, balpha: false);
                  },
                  leading: Container(
                      width: 30,
                      height: 30,
                      color: Color(controller.setting.value.fontColor == 0
                          ? Theme.of(Get.context!)
                              .textTheme
                              .bodyText1!
                              .color!
                              .value
                          : controller.setting.value.fontColor)),
                  title: Text("Font Color".tr),
                  trailing: ElevatedButton(
                      onPressed: () {
                        controller.setting.value.fontColor = 0;
                        controller.setting.refresh();
                      },
                      child: Text("delete".tr)),
                ))),
          ],
        ),
      ],
    );
  }
}
