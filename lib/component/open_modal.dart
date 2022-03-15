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
  static openFocusModal() async {
    Get.dialog(AlertDialog(
        content: TextField(
      autofocus: true,
      // keyboardType: TextInputType.none,
      // focusNode: FirstDisabledFocusNode(),
    )));
    await Future.delayed(50.milliseconds);
    Get.back();
  }

  static openJumpModal() async {
    final ctl = Get.find<BoxCtl>();
    Timer? _timer;
    TextEditingController c = TextEditingController()
      ..text = ctl.currentHistory.value.pos.toString();
    return Get.dialog(AlertDialog(
      title: Text("move_location".tr),
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Obx(() => Center(
                    child: Text(
                        "${"Current_location".tr} : ${ctl.currentHistory.value.pos}"),
                  )),
              Obx(() => Slider(
                  value: ctl.currentHistory.value.pos.toDouble(),
                  min: 0,
                  max: ctl.contents.length.toDouble(),
                  divisions: ctl.contents.length,
                  label: "${ctl.currentHistory.value.pos}",
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
  }

  static openSearchModal() {
    final ctl = Get.find<BoxCtl>();
    final modalCtl = Get.put(openSearchCtl());

    return Get.dialog(AlertDialog(
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
  }

  static openFontSizeModal() {
    final ctl = Get.find<BoxCtl>();
    final modalCtl = Get.put(openSearchCtl());

    return Get.dialog(AlertDialog(
      title: Text("Font settings".tr),
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
                Text("font size setting".tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          ctl.setting.update((val) {
                            val!.fontSize += 1;
                          });
                        },
                        icon: Icon(Ionicons.add_outline)),
                    Text("${ctl.setting.value.fontSize}"),
                    IconButton(
                        onPressed: () {
                          ctl.setting.update((val) {
                            val!.fontSize -= 1;
                          });
                        },
                        icon: Icon(Ionicons.remove_outline)),
                  ],
                ),
                // FontWeight
                Text("font weight setting".tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: ctl.setting.value.fontWeight >= 8
                            ? null
                            : () {
                                ctl.setting.update((val) {
                                  val!.fontWeight += 1;
                                });
                              },
                        icon: Icon(Ionicons.add_outline)),
                    Text("${ctl.setting.value.fontWeight}"),
                    IconButton(
                        onPressed: ctl.setting.value.fontWeight <= 0
                            ? null
                            : () {
                                ctl.setting.update((val) {
                                  val!.fontWeight -= 1;
                                });
                              },
                        icon: Icon(Ionicons.remove_outline)),
                  ],
                ),
                // font height
                Text("font height setting".tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: ctl.setting.value.fontHeight >= 8
                            ? null
                            : () {
                                ctl.setting.update((val) {
                                  var fh = val!.fontHeight += 0.1;
                                  val.fontHeight =
                                      double.parse(fh.toStringAsFixed(1));
                                });
                              },
                        icon: Icon(Ionicons.add_outline)),
                    Text("${ctl.setting.value.fontHeight}"),
                    IconButton(
                        onPressed: ctl.setting.value.fontHeight <= 0
                            ? null
                            : () {
                                ctl.setting.update((val) {
                                  var fh = val!.fontHeight -= 0.1;
                                  val.fontHeight =
                                      double.parse(fh.toStringAsFixed(1));
                                });
                              },
                        icon: Icon(Ionicons.remove_outline)),
                  ],
                ),

                Text("letter_spacing".tr),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: ctl.setting.value.letterSpacing >= 3
                            ? null
                            : () {
                                ctl.setting.update((val) {
                                  var fh = val!.letterSpacing += 0.1;
                                  val.letterSpacing =
                                      double.parse(fh.toStringAsFixed(1));
                                });
                              },
                        icon: Icon(Ionicons.add_outline)),
                    Text("${ctl.setting.value.letterSpacing}"),
                    IconButton(
                        onPressed: ctl.setting.value.letterSpacing <= 0
                            ? null
                            : () {
                                ctl.setting.update((val) {
                                  var fh = val!.letterSpacing -= 0.1;
                                  val.letterSpacing =
                                      double.parse(fh.toStringAsFixed(1));
                                });
                              },
                        icon: Icon(Ionicons.remove_outline)),
                  ],
                ),
                // Font
                Text("Font settings".tr),
                ...ctl.listFont.map((e) {
                  var ff = ctl.setting.value.fontFamily;
                  if (ff.isEmpty) {
                    ff = "default";
                  }

                  return RadioListTile(
                      title: Text(e),
                      value: e,
                      groupValue: ff,
                      onChanged: (f) {
                        if (f == 'default') {
                          ctl.setting.update((val) {
                            val!.fontFamily = "";
                          });
                        } else {
                          ctl.setting.update((val) {
                            val!.fontFamily = f as String;
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
  }

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

  static openMemoModal(String initValue) {
    var rtnText = initValue;
    return Get.dialog(AlertDialog(
      title: Text("MEMO".tr),
      content: Container(
          color: Colors.transparent,
          width: double.maxFinite,
          child: TextFormField(
            initialValue: initValue,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (str) {
              rtnText = str;
            },
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("cancel".tr)),
        ElevatedButton(
            onPressed: () {
              Get.back(result: rtnText);
            },
            child: Text("confirm".tr))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});
  }
}
