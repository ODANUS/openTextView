import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenModal {
  static openModalSelect({required String title}) {
    final Completer completer = Completer();

    Get.dialog(AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(title),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              completer.complete(false);
              Get.back();
            },
            child: Text("취소")),
        ElevatedButton(
            onPressed: () {
              completer.complete(true);
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }

  static openModal({required String title}) {
    final Completer completer = Completer();

    Get.dialog(AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(title),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }

  static openJumpModal() {
    final Completer completer = Completer();
    final ctl = Get.find<GlobalController>();
    Timer? _timer;
    Get.dialog(AlertDialog(
      title: Text("위치 이동"),
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Obx(() => Center(
                    child: Text("현재 위치 : ${ctl.lastData.value.pos}"),
                  )),
              Obx(() => Slider(
                  value: ctl.lastData.value.pos.toDouble(),
                  min: 0,
                  max: ctl.contents.length.toDouble(),
                  divisions: ctl.contents.length,
                  label: "${ctl.lastData.value.pos}",
                  onChanged: (double v) {
                    ctl.itemScrollctl.jumpTo(index: v.toInt());
                  })),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }

  static openSearchModal() {
    final Completer completer = Completer();
    final ctl = Get.find<GlobalController>();
    final modalCtl = Get.put(openSearchCtl());

    Get.dialog(AlertDialog(
      title: Text("페이지 검색"),
      content: Container(
          constraints: BoxConstraints(maxHeight: 500),
          width: double.maxFinite,
          child: Obx(() {
            List<String> searchList = [];
            if (modalCtl.text.value.length > 0) {
              searchList.assignAll(ctl.contents.where((p) {
                return p
                        .toLowerCase()
                        .indexOf(modalCtl.text.value.toLowerCase()) >=
                    0;
              }).toList());
            }
            return ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "검색할 단어 / 문장을 입력해 주세요.",
                  ),
                  onChanged: (v) {
                    modalCtl.text(v);
                  },
                ),
                ...searchList.map((e) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        int idx = ctl.contents.indexOf(e);
                        ctl.itemScrollctl.jumpTo(index: idx);
                      },
                      title: Text(e),
                    ),
                  );
                }).toList()
              ],
            );
          })),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {
      modalCtl.text("");
    });

    return completer.future;
  }
}

class openSearchCtl extends GetxController {
  final text = "".obs;

  @override
  void onClose() {
    text("");
    // TODO: implement onClose
    super.onClose();
  }
}
