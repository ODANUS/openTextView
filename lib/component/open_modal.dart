import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';

class openSearchCtl extends GetxController {
  final text = "".obs;
  final autoexitValue = (0.0).obs;

  @override
  void onClose() {
    text("");
    // TODO: implement onClose
    super.onClose();
  }
}

class OpenModal {
  static openAutoExitModal() {
    final modalCtl = Get.put(openSearchCtl());

    return Get.dialog(AlertDialog(
      title: Text("Auto shutdown settings".tr),
      content: Container(
          color: Colors.transparent,
          width: double.maxFinite,
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("@num minutes".trParams({"num": modalCtl.autoexitValue.value.toString()})),
                Slider(
                    min: 0,
                    max: 200,
                    divisions: 200,
                    label: "@num minutes".trParams({"num": modalCtl.autoexitValue.value.toString()}),
                    value: modalCtl.autoexitValue.value,
                    onChanged: (v) {
                      modalCtl.autoexitValue(v);
                    })
              ],
            );
          })),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("cancel".tr)),
        ElevatedButton(
            onPressed: () {
              Get.back(result: modalCtl.autoexitValue.value.toInt());
            },
            child: Text("confirm".tr))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {
      modalCtl.text("");
      modalCtl.autoexitValue(0.0);
    });
  }
}
