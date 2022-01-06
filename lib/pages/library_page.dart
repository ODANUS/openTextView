import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryPageCtl extends GetxController {
  final libList = [];
  RxList<String> delList = RxList<String>();
  RxString tmpDir = "".obs;
  RxBool reload = false.obs;
  RxList<String> sortList = ["name", "size", "date", "access"].obs;
  RxString sortTarget = "name".obs;
  RxBool asc = true.obs;

  @override
  void onInit() async {
    loadtmpDir();
    debounce(tmpDir, (v) => loadtmpDir());
    super.onInit();
  }

  void loadtmpDir() async {
    var tmp = await getTemporaryDirectory();
    var dir = Directory("${tmp.path}/file_picker");
    if (dir.existsSync()) {
      tmpDir(dir.path);
    }
  }
}

class LibraryPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(LibraryPageCtl());
    String path = controller.lastData.value.path;
    List<History> listHistory = controller.userData.value.history;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("my_library".tr),
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 2, bottom: 2), child: AdsComp()),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...ctl.sortList.map((e) {
                  ButtonStyle? style =
                      ElevatedButton.styleFrom(primary: Colors.grey);
                  if (ctl.sortTarget == e) {
                    style = null;
                  }
                  return ElevatedButton(
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
                })
              ],
            )),
        Divider(),
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
            return Stack(children: [
              RefreshIndicator(
                  onRefresh: () async {
                    ctl.tmpDir.refresh();
                  },
                  child: ListView(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 30, bottom: 150),
                      children: [
                        ...fileList.map((e) {
                          if (e is Directory || e is Link) {
                            return SizedBox();
                          }
                          File file = e as File;
                          Widget delIcon = IconSlideAction(
                            caption: 'remove_from_library'.tr,
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () async {
                              await file.delete();
                              ctl.tmpDir.refresh();
                            },
                          );
                          String ex = "";
                          var exList = file.path.split(".");
                          if (exList.isNotEmpty) {
                            ex = exList.last.toLowerCase();
                          }
                          String name = file.path.split("/").last;
                          List<History> targetList = listHistory.where((e) {
                            return e.name == name;
                          }).toList();
                          String size = Utils.getFileSize(file);
                          return Card(
                              child: Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  // actionExtentRatio: 0.2,
                                  secondaryActions: [delIcon],
                                  actions: [delIcon],
                                  child: ListTile(
                                    leading: Icon(Ionicons.document_outline),
                                    title: Text(name),
                                    subtitle: targetList.isNotEmpty &&
                                            targetList.first.length > 0 &&
                                            ex == "txt"
                                        ? Text(
                                            '${(targetList.first.pos / targetList.first.length * 100).toStringAsFixed(2)}%')
                                        : Text(''),
                                    trailing: Text("${size}"),
                                    onTap: () async {
                                      controller.openFile(file);
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
        onPressed: () async {
          var path = await Utils.selectFile();

          ctl.tmpDir.refresh();
        },
        label: Text('Add_file'.tr),
        icon: Icon(Ionicons.add),
      ),
    );
  }
}
