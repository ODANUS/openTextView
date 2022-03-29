import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:path_provider/path_provider.dart';

// class HistoryPageCtl extends GetxController {
//   RxString searchText = "".obs;
//   RxList<HistoryBox> list = RxList<HistoryBox>();
//   @override
//   void onInit() {
//     // loadAllHistory();
//     ever(Get.find<BoxCtl>().tabIndex, (v) {
//       if (v == 3) {
//         loadAllHistory();
//       }
//     });
//     super.onInit();
//   }

//   loadAllHistory() {
//     var tmp = Get.find<BoxCtl>().getHistorys();
//     tmp.sort((v1, v2) {
//       return v1.date.compareTo(v2.date);
//     });
//     list(tmp);
//   }
// }

class HistoryPage extends GetView<BoxCtl> {
  // final ctl = Get.put(HistoryPageCtl());

  // editImage(HistoryBox v) async {
  //   String name = v.name.split("/").last;
  //   var result = await Get.toNamed("/searchpage", arguments: name);
  //   if (result != null) {
  //     var cur = controller.currentHistory.value;

  //     if (cur.id == v.id) {
  //       cur.searchKeyWord = result["searchKeyWord"];
  //       cur.imageUri = result["imageUri"];
  //       controller.currentHistory.refresh();
  //     }
  //     v.searchKeyWord = result["searchKeyWord"];
  //     v.imageUri = result["imageUri"];

  //     controller.editHistory(v);
  //     ctl.loadAllHistory();
  //   }
  // }

  // editMemo(HistoryBox v) async {
  //   var result = await OpenModal.openMemoModal(v.memo);
  //   if (result != null) {
  //     var cur = controller.currentHistory.value;
  //     if (cur.id == v.id) {
  //       cur.memo = result;
  //       controller.currentHistory.refresh();
  //     }
  //     v.memo = result;
  //     controller.editHistory(v);
  //     ctl.loadAllHistory();
  //   }
  // }

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

                // var header = '이미지,제목,읽은 위치,일자,읽은 퍼센트,총 권수,메모';
                var header = '제목,읽은 위치,일자,읽은 퍼센트,총 권수,메모';

                var str = [
                  header,
                  ...IsarCtl.historys.map((e) {
                    // String imageUri = "";
                    // if (e.imageUri.isNotEmpty) {
                    //   imageUri = "=IMAGE(\"${e.imageUri}\")";
                    // }
                    String pos = "";
                    if (e.pos > 0 && e.length > 0) {
                      pos = (e.pos / e.length * 100).toStringAsFixed(2) + "%";
                    }
                    String total_books = "";
                    if (e.contentsLen > 0) {
                      total_books = "${e.contentsLen ~/ 160000}${"books".tr}";
                    }
                    return '"${e.name.split(".").first}","${e.pos}","${e.date}",$pos,$total_books,${e.memo}';
                  })
                ];
                tmpFile.writeAsStringSync(str.join("\r\n"));

                final params = SaveFileDialogParams(sourceFilePath: tmpFile.path);

                await FlutterFileDialog.saveFile(params: params);
              },
              icon: Icon(Icons.download))
        ],
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: AdsComp(),
        ),
      ),
      body: IsarCtl.rxHistory((p0, p1) {
        return ObxValue<RxString>((keyword) {
          var historyList = IsarCtl.historyListByName(keyword.value);

          historyList.sort((a, b) {
            return b.date.compareTo(a.date);
          });
          // copyHistoryList = copyHistoryList.where((el) => el.name.indexOf(ctl.searchText.value) >= 0).toList();
          return Column(
            children: [
              ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Please enter word".tr,
                          ),
                          onChanged: (v) {
                            keyword(v);
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
                child: ListView(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
                  children: historyList.map((e) {
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
                          IsarCtl.deleteHistory(e);
                        },
                        background: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [delwidget, delwidget],
                          ),
                        ),
                        child: ExpansionTile(
                          title: Text(e.name),
                          subtitle: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${(e.pos / e.length * 100).toStringAsFixed(2)}% : ${e.pos}/${e.length}"),
                                  if (e.contentsLen > 0) Text(" (${e.contentsLen ~/ 160000} ${"books".tr})"),
                                ],
                              ),
                              Row(children: [
                                Flexible(
                                  child: Text(
                                    "${"memo".tr} : ${e.memo}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          children: [
                            ObxValue<RxBool>((bMemo) {
                              return Column(
                                children: [
                                  if (bMemo.value)
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue: e.memo,
                                        onFieldSubmitted: (v) {
                                          IsarCtl.putHistory(e..memo = v);
                                        },
                                      ),
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.red),
                                        onPressed: () {
                                          IsarCtl.deleteHistory(e);
                                        },
                                        child: Text("delete".tr),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.green),
                                        onPressed: () {
                                          bMemo(!bMemo.value);
                                        },
                                        child: Text("memo".tr),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }, false.obs),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }, "".obs);
      }),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }
}
