import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/provider/utils.dart';

class MergePage extends GetView {
  MergePage() {}
  RxString fileName = "".obs;
  @override
  Widget build(BuildContext context) {
    RxList<File> files = Get.arguments;
    fileName(files.first.path.split("/").last.split(".").first);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("merge".tr),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: AdBanner(key: Key("merge")),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: fileName.value,
              onFieldSubmitted: (v) {
                fileName(v);
              },
            ),
          ),
          Obx(() => Expanded(
                child: ReorderableListView(
                  onReorder: (int oldindex, int newindex) {
                    if (newindex > oldindex) {
                      newindex -= 1;
                    }
                    final items = files.removeAt(oldindex);
                    files.insert(newindex, items);
                  },
                  padding: EdgeInsets.all(10),
                  children: [
                    ...files
                        .asMap()
                        .map((k, e) {
                          return MapEntry(
                              k,
                              Card(
                                key: Key("$k"),
                                child: ListTile(
                                  leading: ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.red),
                                    onPressed: () {
                                      files.remove(e);
                                    },
                                    child: Text("delete".tr),
                                  ),
                                  title: Text(e.path.split("/").last),
                                  trailing: Icon(Icons.menu),
                                ),
                              ));
                        })
                        .values
                        .toList(),
                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Get.back();
              },
              child: Text("cancel".tr)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () async {
              List<String> strList = [];
              for (var file in files) {
                strList.add(await Utils.readFile(file));
              }
              File output = File("${IsarCtl.libDir.value.path}/merge_$fileName.txt");
              if (!output.existsSync()) {
                output.createSync();
              }
              output.writeAsStringSync(strList.join("\n\n"));
              files.clear();
              Get.back();
            },
            child: Text("merge".tr),
          )
        ]),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }
}
