import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/controller/ad_ctl.dart';

import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';

class HistoryPage extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("history".tr),
        actions: [
          IsarCtl.rxHistory((ctx, history) {
            return Center(child: Text("Total : ${history.length}"));
          }),
          IconButton(
              onPressed: () async {
                var tmpdir = await getTemporaryDirectory();
                var tmpFile = File("${tmpdir.path}/openTextView.csv");

                // var header = '이미지,제목,읽은 위치,일자,읽은 퍼센트,총 권수,메모';
                var header = '제목,일자,읽은 퍼센트,총 권수,메모';

                var str = [
                  header,
                  ...IsarCtl.historys.map((e) {
                    // String imageUri = "";
                    // if (e.imageUri.isNotEmpty) {
                    //   imageUri = "=IMAGE(\"${e.imageUri}\")";
                    // }
                    String pos = "";
                    pos = Utils.rdgPos(e);
                    String total_books = "";
                    total_books = Utils.rdgPos(e, bpercent: false, bBooks: true);

                    return '"${e.name.split(".").first}","${e.date}",$pos,$total_books,"${e.memo}"';
                  })
                ];
                tmpFile.writeAsStringSync(str.join("\r\n"));

                final params = SaveFileDialogParams(sourceFilePath: tmpFile.path);

                await FlutterFileDialog.saveFile(params: params);
              },
              icon: Icon(Icons.download)),
          IconButton(
              onPressed: () {
                if (AdCtl.hasOpenInterstitialAd()) {
                  AdCtl.openInterstitialAd();
                }
                // hasOpenInterstitialAd
              },
              icon: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Icon(Icons.smart_display),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "AD",
                    ),
                  ),
                ],
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: AdBanner(key: Key("history")),
        ),
      ),
      body: ObxValue<RxString>((rxkeyword) {
        var keyword = rxkeyword.value;
        return IsarCtl.rxHistory((p0, p1) {
          var historyList = IsarCtl.historyListByName(keyword);

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
                            rxkeyword(v);
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
                                  Text("${Utils.rdgPos(e, bnumber: true, bBooks: true)}"),
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
        });
      }, "".obs),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }
}
