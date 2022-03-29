import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';

class LibraryPage extends GetView<BoxCtl> {
  List<String> sortList = ["name", "size", "date", "access"];
  RxString sortStr = "access".obs;
  RxString searchText = "".obs;
  RxBool asc = true.obs;
  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
        initialValue: true,
        builder: (reloadValue, reloadFn) {
          return Scaffold(
            appBar: AppBar(
              title: Text("my_library".tr),
              actions: [
                ...sortList.map((e) {
                  return Obx(() => TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.only(left: 10), minimumSize: Size.zero, primary: Colors.white),
                        onPressed: () {
                          sortStr(e);
                          asc(!asc.value);
                        },
                        child: Row(
                          children: [Text(e), if (e == sortStr.value && asc.value) Icon(Icons.arrow_drop_up) else if (e == sortStr.value && !asc.value) Icon(Icons.arrow_drop_down)],
                        ),
                      ));
                }).toList(),
                SizedBox(width: 10),
              ],
              bottom: PreferredSize(
                preferredSize: Size(Get.width, 50),
                child: AdsComp(),
              ),
            ),
            body: StreamBuilder<Directory>(
                stream: getTemporaryDirectory().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return SizedBox();
                  var dir = Directory("${snapshot.data!.path}/file_picker");
                  var refFiles = dir.listSync();

                  return IsarCtl.rxHistory((p0, p1) {
                    return Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Please enter word".tr,
                              ),
                              onChanged: (v) => searchText(v),
                            )),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async => reloadFn(reloadValue),
                            child: Obx(() {
                              var files = refFiles.where((e) => e.path.split("/").last.contains(searchText)).toList();
                              if (sortStr.contains("name")) {
                                files.sort((e1, e2) {
                                  String name1 = e1.path.split("/").last;
                                  String name2 = e2.path.split("/").last;

                                  if (asc.value) {
                                    return name1.compareTo(name2);
                                  } else {
                                    return name2.compareTo(name1);
                                  }
                                });
                              }
                              if (sortStr.contains("size")) {
                                files.sort((e1, e2) {
                                  int size1 = (e1 as File).lengthSync();
                                  int size2 = (e2 as File).lengthSync();
                                  if (asc.value) {
                                    return size1.compareTo(size2);
                                  } else {
                                    return size2.compareTo(size1);
                                  }
                                });
                              }
                              if (sortStr.contains("date")) {
                                files.sort((e1, e2) {
                                  DateTime date1 = (e1 as File).lastModifiedSync();
                                  DateTime date2 = (e2 as File).lastModifiedSync();
                                  if (asc.value) {
                                    return date1.compareTo(date2);
                                  } else {
                                    return date2.compareTo(date1);
                                  }
                                });
                              }
                              if (sortStr.contains("access")) {
                                files.sort((e1, e2) {
                                  DateTime date1 = (e1 as File).lastAccessedSync();
                                  DateTime date2 = (e2 as File).lastAccessedSync();
                                  if (asc.value) {
                                    return date1.compareTo(date2);
                                  } else {
                                    return date2.compareTo(date1);
                                  }
                                });
                              }

                              return ListView.builder(
                                  padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 100),
                                  itemCount: files.length,
                                  itemBuilder: (ctx, idx) {
                                    File file = files[idx] as File;
                                    String name = file.path.split("/").last;
                                    HistoryIsar? history = IsarCtl.historyByName(name);
                                    String size = Utils.getFileSize(file);
                                    return Card(
                                      child: ExpansionTile(
                                        title: Text(name),
                                        subtitle: history == null
                                            ? SizedBox()
                                            : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${(history.pos / history.length * 100).toStringAsFixed(2)}% (${history.contentsLen ~/ 160000}${"books".tr})"),
                                                  Row(children: [
                                                    Flexible(
                                                      child: Text(
                                                        "${"memo".tr} : ${history.memo}",
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ]),
                                                  Text("${size}"),
                                                ],
                                              ),
                                        children: [
                                          ObxValue<RxBool>((bMemo) {
                                            return Column(
                                              children: [
                                                if (bMemo.value && history != null)
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: TextFormField(
                                                      initialValue: history.memo,
                                                      onFieldSubmitted: (v) {
                                                        IsarCtl.putHistory(history..memo = v);
                                                      },
                                                    ),
                                                  ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(primary: Colors.red),
                                                      onPressed: () {
                                                        file.deleteSync();
                                                        reloadFn(reloadValue);
                                                      },
                                                      child: Text("delete".tr),
                                                    ),
                                                    if (history != null)
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(primary: Colors.green),
                                                        onPressed: () {
                                                          bMemo(!bMemo.value);
                                                        },
                                                        child: Text("memo".tr),
                                                      ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        IsarCtl.openFile(file);
                                                      },
                                                      child: Text("open".tr),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }, false.obs),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                          ),
                        )
                      ],
                    );
                  });
                }
                // if you need to call something outside the builder method.
                // onUpdate: (value) => print("Value updated: $value"),
                // onDispose: () => print("Widget unmounted"),
                ),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: "library",
              onPressed: () async {
                await Utils.selectFile();
                reloadFn(reloadValue);
              },
              label: Text('Add_file'.tr),
              icon: Icon(Ionicons.add),
            ),
          );
        });
  }
}
