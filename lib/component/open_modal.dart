import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
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
            child: Text("cancel".tr)),
        ElevatedButton(
            onPressed: () {
              completer.complete(true);
              Get.back();
            },
            child: Text("confirm".tr))
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
            child: Text("confirm".tr))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }

  static openJumpModal() {
    final Completer completer = Completer();
    final ctl = Get.find<GlobalController>();
    Timer? _timer;
    TextEditingController c = TextEditingController()
      ..text = ctl.lastData.value.pos.toString();
    Get.dialog(AlertDialog(
      title: Text("move_location".tr),
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Obx(() => Center(
                    child: Text(
                        "${"Current_location".tr} : ${ctl.lastData.value.pos}"),
                  )),
              Obx(() => Slider(
                  value: ctl.lastData.value.pos.toDouble(),
                  min: 0,
                  max: ctl.contents.length.toDouble(),
                  divisions: ctl.contents.length,
                  label: "${ctl.lastData.value.pos}",
                  onChanged: (double v) {
                    if (ctl.contents.length >= v.toInt() &&
                        !ctl.scrollstat.value) {
                      ctl.itemScrollctl.jumpTo(index: v.toInt());
                      c.text = v.toInt().toString();
                    }
                  })),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: "move_location".tr,
                  ),
                  controller: c,
                  // initialValue: ctl.lastData.value.pos.toString(),
                  onChanged: (v) {
                    if (ctl.contents.length >= int.parse(v) &&
                        !ctl.scrollstat.value) {
                      ctl.itemScrollctl.jumpTo(index: int.parse(v));
                    }
                  })
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("confirm".tr))
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
      title: Text("page_search".tr),
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
                    labelText: "Please enter a word/sentence to search for".tr,
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
                        if (ctl.contents.length >= idx &&
                            !ctl.scrollstat.value) {
                          ctl.itemScrollctl.jumpTo(index: idx);
                        }
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
            child: Text("confirm".tr))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {
      modalCtl.text("");
    });

    return completer.future;
  }

  static openFontSizeModal() {
    final Completer completer = Completer();
    final ctl = Get.find<GlobalController>();
    final modalCtl = Get.put(openSearchCtl());

    Get.dialog(AlertDialog(
      title: Text("폰트 설정".tr),
      content: Container(
          constraints: BoxConstraints(maxHeight: 400),
          color: Colors.transparent,
          width: double.maxFinite,
          child: Obx(() {
            List<String> searchList = [];
            return ListView(
              shrinkWrap: true,
              // mainAxisSize: MainAxisSize.min,
              children: [
                // Size
                Text("크기 설정".tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          ctl.userData.update((val) {
                            val!.ui.fontSize += 1;
                          });
                        },
                        icon: Icon(Ionicons.add_outline)),
                    Text("${ctl.userData.value.ui.fontSize}"),
                    IconButton(
                        onPressed: () {
                          ctl.userData.update((val) {
                            val!.ui.fontSize -= 1;
                          });
                        },
                        icon: Icon(Ionicons.remove_outline)),
                  ],
                ),
                // FontWeight
                Text("굵기 설정".tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: ctl.userData.value.ui.fontWeight >= 8
                            ? null
                            : () {
                                ctl.userData.update((val) {
                                  val!.ui.fontWeight += 1;
                                });
                              },
                        icon: Icon(Ionicons.add_outline)),
                    Text("${ctl.userData.value.ui.fontWeight}"),
                    IconButton(
                        onPressed: ctl.userData.value.ui.fontWeight <= 0
                            ? null
                            : () {
                                ctl.userData.update((val) {
                                  val!.ui.fontWeight -= 1;
                                });
                              },
                        icon: Icon(Ionicons.remove_outline)),
                  ],
                ),
                // Font
                Text("폰트 설정".tr),
                ...ctl.listFont.map((e) {
                  var ff = ctl.userData.value.ui.fontFamily ?? 'default';
                  return RadioListTile(
                      title: Text(e),
                      value: e,
                      groupValue: ff,
                      onChanged: (f) {
                        if (f == 'default') {
                          ctl.userData.update((val) {
                            val!.ui.fontFamily = null;
                          });
                        } else {
                          ctl.userData.update((val) {
                            val!.ui.fontFamily = f as String;
                          });
                        }
                      });
                }).toList(),

                // ListView(
                //   // crossAxisCount: 2,
                //   shrinkWrap: true,
                //   // childAspectRatio: 4 / 1,
                //   children: [
                //     ...ctl.listFont.map((e) {
                //       var ff = ctl.userData.value.ui.fontFamily ?? 'default';
                //       return RadioListTile(
                //           title: Text(e),
                //           value: e,
                //           groupValue: ff,
                //           onChanged: (f) {
                //             ctl.userData.update((val) {
                //               val!.ui.fontFamily = f as String;
                //             });
                //           });
                //     }).toList(),
                //   ],
                // )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     IconButton(
                //         onPressed: () {
                //           ctl.userData.update((val) {
                //             val!.ui.fontSize += 1;
                //           });
                //         },
                //         icon: Icon(Ionicons.add_outline)),
                //     Text("${ctl.userData.value.ui.fontSize}"),
                //     IconButton(
                //         onPressed: () {
                //           ctl.userData.update((val) {
                //             val!.ui.fontSize -= 1;
                //           });
                //         },
                //         icon: Icon(Ionicons.remove_outline)),
                //   ],
                // )
              ],
            );
          })),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("confirm".tr))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {
      modalCtl.text("");
    });

    return completer.future;
  }

  static openAutoExitModal() {
    final Completer completer = Completer();
    final modalCtl = Get.put(openSearchCtl());

    Get.dialog(AlertDialog(
      title: Text("Auto shutdown settings".tr),
      content: Container(
          color: Colors.transparent,
          width: double.maxFinite,
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("@num minutes".trParams(
                    {"num": modalCtl.autoexitValue.value.toString()})),
                Slider(
                    min: 0,
                    max: 200,
                    divisions: 200,
                    label: "@num minutes".trParams(
                        {"num": modalCtl.autoexitValue.value.toString()}),
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
              completer.complete();
            },
            child: Text("cancel".tr)),
        ElevatedButton(
            onPressed: () {
              Get.back();
              completer.complete(modalCtl.autoexitValue.value.toInt());
            },
            child: Text("confirm".tr))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {
      modalCtl.text("");
      modalCtl.autoexitValue(0.0);
    });

    return completer.future;
  }
}

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
