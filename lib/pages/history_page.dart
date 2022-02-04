import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:path_provider/path_provider.dart';

class HistoryPageCtl extends GetxController {
  RxString searchText = "".obs;
  RxList<HistoryBox> list = RxList<HistoryBox>();
  @override
  void onInit() {
    // loadAllHistory();
    ever(Get.find<BoxCtl>().tabIndex, (v) {
      if (v == 3) {
        loadAllHistory();
      }
    });
    super.onInit();
  }

  loadAllHistory() {
    list(Get.find<BoxCtl>().getHistorys());
  }
}

class HistoryPage extends GetView<BoxCtl> {
  final ctl = Get.put(HistoryPageCtl());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("history".tr),
        actions: [
          IconButton(
              onPressed: () async {
                var tmpdir = await getTemporaryDirectory();
                var tmpFile = File("${tmpdir.path}/openTextView.csv");

                var header = '이미지,제목,읽은 위치,일자,읽은 퍼센트,총 권수';

                var str = [
                  header,
                  ...ctl.list.map((e) {
                    String imageUri = "";
                    if (e.imageUri.isNotEmpty) {
                      imageUri = "=IMAGE(\"${e.imageUri}\")";
                    }
                    String pos = "";
                    if (e.pos > 0 && e.length > 0) {
                      pos = (e.pos / e.length * 100).toStringAsFixed(2) + "%";
                    }
                    String total_books = "";
                    if (e.contentsLen > 0) {
                      total_books = "${e.contentsLen ~/ 160000}권";
                    }
                    return '$imageUri,"${e.name.split(".").first}","${e.pos}","${e.date}",$pos,$total_books';
                  })
                ];
                tmpFile.writeAsStringSync(str.join("\r\n"));

                final params =
                    SaveFileDialogParams(sourceFilePath: tmpFile.path);

                await FlutterFileDialog.saveFile(params: params);
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: Obx(() {
        var historyList = ctl.list;
        var copyHistoryList = List<HistoryBox>.from(historyList);
        copyHistoryList.sort((a, b) {
          return b.date.compareTo(a.date);
        });
        copyHistoryList = copyHistoryList
            .where((el) => el.name.indexOf(ctl.searchText.value) >= 0)
            .toList();
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: AdsComp(),
            ),
            ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText:
                              "Please enter a word/sentence to search for".tr,
                        ),
                        onChanged: (v) {
                          ctl.searchText(v);
                        },
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: new Icon(
                    Ionicons.search,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  color: Colors.black26,
                  onPressed: () {},
                )),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                ctl.loadAllHistory();
              },
              child: ListView(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
                children: copyHistoryList.map((e) {
                  Widget delwidget = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      Text(
                        "Drag to delete".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                  return Card(
                    child: Dismissible(
                      key: Key(e.name),
                      onDismissed: (direction) {
                        controller.removeHistory(e);
                        ctl.loadAllHistory();
                      },
                      background: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [delwidget, delwidget],
                        ),
                      ),
                      child: ListTile(
                        onTap: () {},
                        title: Text(e.name),
                        subtitle: Row(
                          children: [
                            Text("${"last position".tr} : "),
                            Text("${e.pos}")
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ))
          ],
        );
      }),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }
}
