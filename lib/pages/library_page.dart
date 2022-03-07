import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/net.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryPageCtl extends GetxController {
  final libList = [];
  RxList<String> delList = RxList<String>();
  RxString tmpDir = "".obs;
  RxBool reload = false.obs;
  RxList<String> sortList = ["name", "size", "date", "access"].obs;
  RxString sortTarget = "access".obs;
  RxBool asc = false.obs;

  RxString searchText = "".obs;

  @override
  void onInit() async {
    loadtmpDir();
    debounce(tmpDir, (v) => loadtmpDir());
    super.onInit();
  }

  void loadtmpDir() async {
    var tmp = await getTemporaryDirectory();
    var dir = Directory("${tmp.path}/file_picker");
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    tmpDir(dir.path);
  }
}

class LibraryPage extends GetView<BoxCtl> {
  final ctl = Get.put(LibraryPageCtl());
  editImage(HistoryBox v) async {
    String name = v.name.split("/").last;
    var result = await Get.toNamed("/searchpage", arguments: name);
    if (result != null) {
      var cur = controller.currentHistory.value;

      if (cur.id == v.id) {
        cur.searchKeyWord = result["searchKeyWord"];
        cur.imageUri = result["imageUri"];
        controller.currentHistory.refresh();
      }
      v.searchKeyWord = result["searchKeyWord"];
      v.imageUri = result["imageUri"];

      controller.editHistory(v);
      ctl.tmpDir.refresh();
    }
  }

  editMemo(HistoryBox v) async {
    var result = await OpenModal.openMemoModal(v.memo);
    if (result != null) {
      var cur = controller.currentHistory.value;
      if (cur.id == v.id) {
        cur.memo = result;
        controller.currentHistory.refresh();
      }
      v.memo = result;
      controller.editHistory(v);
      ctl.tmpDir.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("my_library".tr),
        actions: [
          Obx(
            () => SizedBox(
              width: Get.width * 0.7,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                reverse: true,

                // ctl.sortList
                children: ctl.sortList.reversed.map((e) {
                  ButtonStyle? style = TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      primary: Colors.white,
                      minimumSize: Size.zero);
                  return TextButton(
                      style: style,
                      onPressed: () {
                        ctl.sortTarget(e);
                        ctl.asc(!ctl.asc.value);
                      },
                      child: Row(children: [
                        Text(e),
                        if (ctl.sortTarget.contains(e) && ctl.asc.value)
                          Icon(Icons.arrow_drop_up)
                        else if (ctl.sortTarget.contains(e) && !ctl.asc.value)
                          Icon(Icons.arrow_drop_down)
                        else
                          SizedBox()
                      ]));
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 5, bottom: 3), child: AdsComp()),
        Container(
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Please enter a word/sentence to search for".tr,
              ),
              onChanged: (v) {
                ctl.searchText(v);
              },
            )),
        Expanded(
          child: Obx(() {
            if (ctl.tmpDir.isEmpty) {
              return SizedBox();
            }

            Directory dir = Directory(ctl.tmpDir.value);
            var fileList = dir.listSync();
            if (ctl.sortTarget.contains("name")) {
              fileList.sort((e1, e2) {
                String name1 = e1.path.split("/").last;
                String name2 = e2.path.split("/").last;

                if (ctl.asc.value) {
                  return name1.compareTo(name2);
                } else {
                  return name2.compareTo(name1);
                }
              });
            }
            if (ctl.sortTarget.contains("size")) {
              fileList.sort((e1, e2) {
                int size1 = (e1 as File).lengthSync();
                int size2 = (e2 as File).lengthSync();
                if (ctl.asc.value) {
                  return size1.compareTo(size2);
                } else {
                  return size2.compareTo(size1);
                }
              });
            }
            if (ctl.sortTarget.contains("date")) {
              fileList.sort((e1, e2) {
                DateTime date1 = (e1 as File).lastModifiedSync();
                DateTime date2 = (e2 as File).lastModifiedSync();
                if (ctl.asc.value) {
                  return date1.compareTo(date2);
                } else {
                  return date2.compareTo(date1);
                }
              });
            }
            if (ctl.sortTarget.contains("access")) {
              fileList.sort((e1, e2) {
                DateTime date1 = (e1 as File).lastAccessedSync();
                DateTime date2 = (e2 as File).lastAccessedSync();
                if (ctl.asc.value) {
                  return date1.compareTo(date2);
                } else {
                  return date2.compareTo(date1);
                }
              });
            }

            fileList = fileList
                .where((el) =>
                    el.path
                        .split("/")
                        .last
                        .toLowerCase()
                        .indexOf(ctl.searchText.value.toLowerCase()) >=
                    0)
                .toList();
            return Stack(children: [
              RefreshIndicator(
                  onRefresh: () async {
                    ctl.tmpDir.refresh();
                  },
                  child: ListView(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 150),
                      children: [
                        ...fileList.map((e) {
                          if (e is Directory || e is Link) {
                            return SizedBox();
                          }
                          File file = e as File;

                          String ex = "";
                          var exList = file.path.split(".");
                          if (exList.isNotEmpty) {
                            ex = exList.last.toLowerCase();
                          }
                          String name = file.path.split("/").last;
                          List<HistoryBox> targetList =
                              controller.getHistorys().where((e) {
                            return e.name == name;
                          }).toList();
                          if (targetList.isEmpty &&
                              controller.currentHistory.value.name == name) {
                            targetList = [controller.currentHistory.value];
                          }
                          String size = Utils.getFileSize(file);
                          ActionPane actionPane = ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: targetList.isNotEmpty ? 0.6 : 0.3,
                              children: [
                                SlidableAction(
                                  label: 'remove_from_library'.tr,
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  flex: 1,
                                  onPressed: (c) async {
                                    await file.delete();
                                    ctl.tmpDir.refresh();
                                  },
                                ),
                                if (targetList.isNotEmpty)
                                  SlidableAction(
                                    label: 'memo'.tr,
                                    backgroundColor: Colors.green,
                                    icon: Icons.edit,
                                    flex: 1,
                                    onPressed: (c) async {
                                      editMemo(targetList.first);
                                    },
                                  )
                              ]);
                          return Card(
                              child: Slidable(
                                  key: UniqueKey(),
                                  startActionPane: actionPane,
                                  endActionPane: actionPane,
                                  child: ListTile(
                                    leading: targetList.isNotEmpty
                                        ? InkWell(
                                            onTap: () =>
                                                editImage(targetList.first),
                                            child: targetList
                                                    .first.imageUri.isEmpty
                                                ? Icon(Icons.image_search_sharp)
                                                : Image.network(
                                                    targetList.first.imageUri,
                                                    errorBuilder: (c, o, s) {
                                                      return Container(
                                                        child: Text(
                                                            "Image\nNot\nfound"),
                                                      );
                                                    },
                                                  ))
                                        : Icon(Ionicons.document),
                                    title: Text(name),
                                    isThreeLine: true,
                                    subtitle: targetList.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                    '${(targetList.first.pos / targetList.first.length * 100).toStringAsFixed(2)}%'),
                                                Row(children: [
                                                  Flexible(
                                                    child: Text(
                                                      "${"memo".tr} : ${targetList.first.memo}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ]),
                                              ])
                                        : Text(""),
                                    trailing: Text("${size}"),
                                    onTap: () async {
                                      var c = Get.find<BoxCtl>();
                                      c.openFile(file);
                                      // controller.openFile(file);
                                    },
                                    onLongPress: () async {
                                      Get.dialog(AlertDialog(
                                        title: Text("Open Text Viewer"),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceAround,
                                        actions: [
                                          if (targetList.isNotEmpty)
                                            ElevatedButton(
                                                onPressed: () {
                                                  editMemo(targetList.first);
                                                },
                                                child: Text("memo".tr)),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                              onPressed: () async {
                                                await file.delete();
                                                ctl.tmpDir.refresh();
                                              },
                                              child: Text(
                                                  'remove_from_library'.tr))
                                        ],
                                      ));
                                    },
                                  )));
                        })
                      ])),
              if (controller.bConvLoading.value)
                Container(
                    color: Colors.black38,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          "Converting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
            ]);
          }),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "library",
        onPressed: () async {
          await Utils.selectFile();
          ctl.tmpDir.refresh();
        },
        label: Text('Add_file'.tr),
        icon: Icon(Ionicons.add),
      ),
    );
  }
}
