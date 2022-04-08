import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';

class LibraryPage extends GetView {
  List<String> sortList = ["name", "size", "date", "access"];
  RxString sortStr = "access".obs;
  RxString searchText = "".obs;
  RxBool asc = false.obs;

  Future<bool> newLineTheorem(File f) async {
    if (!AdCtl.hasOpenInterstitialAd() && !kDebugMode) {
      return await Get.dialog(AlertDialog(title: Text("개행정리"), content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    }
    if (await AdCtl.openInterstitialAdNewLine()) {
      f.setLastAccessedSync(DateTime.now());
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;

      String rtnStr = await Utils.newLineTheorem(f);

      File outputFile = File("$path/newline_$fileName(${Utils.DF(DateTime.now(), f: 'yyyy-MM-dd HH:mm:ss')}).txt");
      outputFile.createSync();
      outputFile.writeAsStringSync(rtnStr);
      outputFile.setLastAccessedSync(DateTime.now());
      return true;
    }
    return false;
  }

  // Future<bool> saveAs(File f) async {
  //   if (!AdCtl.hasOpenRewardedInterstitialAd()) {
  //     return await Get.dialog(AlertDialog(title: Text("다른 이름으로 저장."), content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
  //   }
  //   var rtn = await AdCtl.openSaveAsAd();
  //   if (rtn) {
  //     final params = SaveFileDialogParams(sourceFilePath: f.path);
  //     await FlutterFileDialog.saveFile(params: params);
  //   }
  //   return true;
  // }

  Future<bool> epubConv(File f) async {
    var rtn = await AdCtl.openInterstitialAdEpubConv();
    if (rtn) {
      f.setLastAccessedSync(DateTime.now());
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;
      String rtnStr = await Utils.convEpub(f);
      File outputFile = File("$path/epub_$fileName(${Utils.DF(DateTime.now(), f: 'yyyy-MM-dd HH:mm:ss')}).txt");
      outputFile.createSync();
      outputFile.writeAsStringSync(rtnStr);
      outputFile.setLastAccessedSync(DateTime.now());
      return true;
    }
    return true;
  }

  Future<bool> ocrZipFile(File f) async {
    var pathList = f.path.split("/");
    var path = pathList.sublist(0, pathList.length - 1).join("/");
    var fileName = pathList.last.split(".").first;

    final bytes = f.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    // archive.
    var tmpDir = await getTemporaryDirectory();
    tmpDir = Directory("${tmpDir.path}/ocr");
    if (!tmpDir.existsSync()) {
      tmpDir.createSync(recursive: true);
    }
    IsarCtl.unzipTotal(archive.length);
    var idx = 0;
    for (final file in archive) {
      final filename = file.name;
      IsarCtl.unzipCurrent(idx++);
      if (file.isFile && (file.name.contains(".gif") || file.name.contains(".png") || file.name.contains(".jpg") || file.name.contains(".jpeg"))) {
        final data = file.content as List<int>;
        File("${tmpDir.path}/$filename")
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory("${tmpDir.path}/$filename").create(recursive: true);
      }
    }
    IsarCtl.unzipTotal(0);
    var len = tmpDir.listSync().length;
    if (len <= 60 && !AdCtl.hasOpenInterstitialAd()) {
      return await Get.dialog(AlertDialog(title: Text("이미지 -> 텍스트."), content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    }
    if (len > 60 && !AdCtl.hasOpenRewardedAd()) {
      return await Get.dialog(AlertDialog(title: Text("이미지 -> 텍스트."), content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    }
    var rtn = await Get.toNamed("/ocr");
    if (rtn != null) {
      File outputFile = File("$path/ocr_$fileName(${Utils.DF(DateTime.now(), f: 'yyyy-MM-dd HH:mm:ss')}).txt");
      outputFile.createSync();
      outputFile.writeAsStringSync(rtn);
      outputFile.setLastAccessedSync(DateTime.now());
    }

    return true;
  }

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
                SizedBox(width: 1),
                IconButton(
                    onPressed: () {
                      if (AdCtl.hasOpenInterstitialAd()) {
                        AdCtl.openInterstitialAd();
                      }
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
                child: AdBanner(
                  key: Key("library"),
                ),
              ),
            ),
            body: Stack(
              children: [
                StreamBuilder<Directory>(
                    stream: getTemporaryDirectory().asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) return SizedBox();
                      var dir = Directory("${snapshot.data!.path}/file_picker");
                      if (!dir.existsSync()) {
                        dir.createSync(recursive: true);
                      }
                      var refFiles = dir.listSync();

                      return IsarCtl.rxHistory((p0, p1) {
                        return Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 2, bottom: 2, left: 20, right: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "Please enter word".tr,
                                  ),
                                  onChanged: (v) => searchText(v),
                                )),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async => reloadFn(!reloadValue!),
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
                                      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 200),
                                      itemCount: files.length,
                                      itemBuilder: (ctx, idx) {
                                        File file = files[idx] as File;
                                        String name = file.path.split("/").last;
                                        String ex = name.split(".").last;
                                        HistoryIsar? history = IsarCtl.historyByName(name);
                                        String size = Utils.getFileSize(file);
                                        if (ex == "zip") {
                                          return Card(
                                              child: ExpansionTile(
                                            title: Text(name),
                                            subtitle: Text("${size}"),
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(primary: Colors.red),
                                                    onPressed: () {
                                                      file.deleteSync();
                                                      reloadFn(!reloadValue!);
                                                    },
                                                    child: Text("delete".tr),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                                                    onPressed: () async {
                                                      if (await ocrZipFile(file)) {
                                                        reloadFn(!reloadValue!);
                                                      }
                                                    },
                                                    child: Text("OCR".tr),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ));
                                        }
                                        if (ex == "epub") {
                                          return Card(
                                              child: ExpansionTile(
                                            title: Text(name),
                                            subtitle: Text("${size}"),
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(primary: Colors.red),
                                                    onPressed: () {
                                                      file.deleteSync();
                                                      reloadFn(!reloadValue!);
                                                    },
                                                    child: Text("delete".tr),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                                                    onPressed: () async {
                                                      if (await epubConv(file)) {
                                                        reloadFn(!reloadValue!);
                                                      }
                                                    },
                                                    child: Text("text conv".tr),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ));
                                        }
                                        return Card(
                                          child: ExpansionTile(
                                            key: Key("file${Random().nextInt(100000)}"),
                                            title: Text(name),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (history != null) Text("${Utils.rdgPos(history)}"),
                                                // Text("${(history.cntntPstn / history.contentsLen * 100).toStringAsFixed(2)}% (${history.contentsLen ~/ 160000}${"books".tr})"),
                                                if (history != null)
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
                                                          style: ElevatedButton.styleFrom(primary: Colors.blue, padding: EdgeInsets.all(1)),
                                                          onPressed: () async {
                                                            if (await newLineTheorem(file)) {
                                                              reloadFn(!reloadValue!);
                                                            }
                                                          },
                                                          child: Text("newline theorem".tr, style: TextStyle(fontSize: 13)),
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(primary: Colors.red),
                                                          onPressed: () {
                                                            file.deleteSync();
                                                            reloadFn(!reloadValue!);
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
                                                          onPressed: () async {
                                                            await IsarCtl.openFile(file);
                                                            reloadFn(!reloadValue!);
                                                          },
                                                          child: Text("open".tr),
                                                        ),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    //   children: [
                                                    //     ElevatedButton(
                                                    //       style: ElevatedButton.styleFrom(primary: Colors.blue),
                                                    //       onPressed: () async {
                                                    //         if (await newLineTheorem(file)) {
                                                    //           reloadFn(!reloadValue!);
                                                    //         }
                                                    //       },
                                                    //       child: Text("newline theorem".tr),
                                                    //     ),
                                                    //     // ElevatedButton(
                                                    //     //   style: ElevatedButton.styleFrom(primary: Colors.blue),
                                                    //     //   onPressed: () {
                                                    //     //     saveAs(file);
                                                    //     //   },
                                                    //     //   child: Text("save as".tr),
                                                    //     // ),
                                                    //   ],
                                                    // ),
                                                    // if (Get.locale?.languageCode == "ko")
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
                    }),
                if (IsarCtl.unzipTotal > 0)
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black54,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text("${IsarCtl.unzipCurrent}/${IsarCtl.unzipTotal}"),
                        ],
                      ))
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: "library",
              onPressed: () async {
                await Utils.selectFile();
                reloadFn(!reloadValue!);
              },
              label: Text('Add_file'.tr),
              icon: Icon(Ionicons.add),
            ),
          );
        });
  }
}
