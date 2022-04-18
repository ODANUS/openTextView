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
import 'package:collection/collection.dart' show compareNatural;

const int MAXOCRCNT = 1000;

class LibraryPage extends GetView {
  List<String> sortList = ["name", "size", "date", "access"];
  List<String> filterList = ["ALL", "txt", "zip", "epub"];
  RxString sortStr = "access".obs;
  RxString searchText = "".obs;
  RxString filterText = "ALL".obs;
  RxBool asc = false.obs;
  RxInt epubTotal = 0.obs;
  RxInt epubCurrent = 0.obs;

  Future<bool> newLineTheorem(File f) async {
    var rtn = await AdCtl.openInterstitialAdNewLine();
    // var rtn = true;
    if (rtn) {
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;

      String rtnStr = await Utils.newLineTheorem(f);

      File outputFile = File("$path/newline_$fileName.txt");
      if (!outputFile.existsSync()) {
        outputFile.createSync();
      }
      outputFile.writeAsStringSync(rtnStr);
      outputFile.setLastAccessedSync(DateTime.now());
      return true;
    }
    return false;
  }

  Future<bool> saveAs(File f) async {
    // if (!AdCtl.hasOpenRewardedInterstitialAd()) {
    //   return await Get.dialog(AlertDialog(title: Text("다른 이름으로 저장."), content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    // }
    // var rtn = await AdCtl.openSaveAsAd();
    // if (rtn) {
    final params = SaveFileDialogParams(sourceFilePath: f.path);
    await FlutterFileDialog.saveFile(params: params);
    // }
    return true;
  }

  Future<bool> epubConv(File f) async {
    var rtn = await AdCtl.openInterstitialAdEpubConv();
    // var rtn = true;
    if (rtn) {
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;
      String rtnStr = await Utils.convEpub(f, onProcess: (total, cur) {
        epubTotal(total);
        epubCurrent(cur);
      }, onFont: () async {
        return Get.dialog(AlertDialog(
          content: Text("There are built-in fonts.".tr),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text("close".tr)),
            ElevatedButton(
                onPressed: () {
                  Get.back(result: true);
                  AdCtl.startRewardedAd();
                },
                child: Text("confirm".tr)),
          ],
        ));
      });
      // return false;
      epubTotal(0);
      epubCurrent(0);

      if (rtnStr.trim().isEmpty) {
        Get.dialog(AlertDialog(
          content: Text("Failed to convert epub.".tr),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("confirm".tr))
          ],
        ));
        return false;
      }

      File outputFile = File("$path/epub_$fileName.txt");
      if (!outputFile.existsSync()) {
        outputFile.createSync();
      }
      outputFile.writeAsStringSync(rtnStr);
      outputFile.setLastAccessedSync(DateTime.now());

      return true;
    }
    return false;
  }

  Future<bool> ocrZipFile(File f) async {
    var pathList = f.path.split("/");
    var path = pathList.sublist(0, pathList.length - 1).join("/");
    var fileName = pathList.last.split(".").first;

    final bytes = f.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    // archive.
    var rootTmpDir = await getTemporaryDirectory();
    var tmpDir = Directory("${rootTmpDir.path}/ocr");
    if (tmpDir.existsSync()) {
      tmpDir.deleteSync(recursive: true);
    }
    tmpDir.createSync(recursive: true);

    archive.files.sort((a, b) {
      return compareNatural(a.name, b.name);
    });

    if (archive.length > MAXOCRCNT + 10) {
      AdCtl.startInterstitialAd();
      IsarCtl.unzipTotal(archive.length);
      var idx = 0;
      var cnt = 0;
      var total = 0;
      ZipFileEncoder encoder = ZipFileEncoder();

      try {
        for (var file in archive) {
          if (cnt == 0) {
            if (idx > 0) {
              encoder.close();
            }
            encoder.create("${rootTmpDir.path}/file_picker/${"${++idx}_div".padLeft(2, "0")}_${fileName}.zip");
          }
          final filename = file.name;
          if (file.isFile &&
              (file.name.contains(".gif") || file.name.contains(".png") || file.name.contains(".jpg") || file.name.contains(".jpeg"))) {
            final data = file.content as List<int>;
            var tmpFile = File("${tmpDir.path}/$filename");
            if (!tmpFile.existsSync()) {
              await tmpFile.create(recursive: true);
            }

            await tmpFile.writeAsBytes(data);
            IsarCtl.unzipCurrent(total);
            encoder.addFile(tmpFile);
          }
          total++;
          if (cnt++ >= MAXOCRCNT - 1) {
            cnt = 0;
          }
        }
        encoder.close();
      } catch (e) {}
      IsarCtl.unzipTotal(0);
      tmpDir.deleteSync(recursive: true);
    } else {
      IsarCtl.unzipTotal(archive.length);
      var idx = 0;
      for (final file in archive) {
        final filename = file.name;
        if (file.isFile && (file.name.contains(".gif") || file.name.contains(".png") || file.name.contains(".jpg") || file.name.contains(".jpeg"))) {
          final data = file.content as List<int>;
          var tmpFile = File("${tmpDir.path}/$filename");
          if (!tmpFile.existsSync()) {
            await tmpFile.create(recursive: true);
          }

          await tmpFile.writeAsBytes(data);
          IsarCtl.unzipCurrent(idx++);
        } else {
          Directory("${tmpDir.path}/$filename").create(recursive: true);
        }
      }
      IsarCtl.unzipTotal(0);
      var rtn = await Get.toNamed("/ocr");
      if (rtn != null) {
        File outputFile = File("$path/ocr_$fileName.txt");
        if (!outputFile.existsSync()) {
          outputFile.createSync();
        }
        outputFile.createSync();
        outputFile.writeAsStringSync(rtn);
        outputFile.setLastAccessedSync(DateTime.now());
      }
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
                          children: [
                            Text(e),
                            if (e == sortStr.value && asc.value)
                              Icon(Icons.arrow_drop_up)
                            else if (e == sortStr.value && !asc.value)
                              Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ));
                }).toList(),
                SizedBox(width: 1),
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
                IsarCtl.rxSetting((_, setting) {
                  return Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      image: setting.bgIdx <= 0
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(Color(setting.bgFilter), BlendMode.dstATop),
                              image: AssetImage('assets/images/${IsarCtl.listBg[setting.bgIdx]}'),
                            ),
                    ),
                  );
                }),
                StreamBuilder<Directory>(
                    stream: getTemporaryDirectory().asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) return SizedBox();

                      var dir = Directory("${snapshot.data!.path}/file_picker");
                      if (!dir.existsSync()) {
                        dir.createSync(recursive: true);
                      }
                      var refFiles = dir.listSync();
                      refFiles.forEach((element) {
                        var tmpEx = element.path.split(".").last.toLowerCase();
                        if (tmpEx == "png" || tmpEx == "jpg" || tmpEx == "jpeg" || tmpEx == "gif") {
                          element.deleteSync();
                          refFiles.remove(element);
                        }
                      });

                      return IsarCtl.rxHistory((p0, p1) {
                        return Column(
                          children: [
                            Card(
                              child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Obx(() => Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ...filterList.map((e) {
                                            return Row(
                                              children: [
                                                Checkbox(
                                                    value: filterText.value == e,
                                                    onChanged: (v) {
                                                      filterText(e);
                                                    }),
                                                Text("${e}"),
                                              ],
                                            );
                                          }).toList(),
                                        ],
                                      ))),
                            ),
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
                                  if (filterText.value != "ALL") {
                                    files = files.where((e) {
                                      var ex = e.path.split(".").last;
                                      return ex == filterText.value;
                                    }).toList();
                                  }

                                  return GridView.builder(
                                      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 200),
                                      itemCount: files.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                                        childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
                                        mainAxisSpacing: 10, //수평 Padding
                                        crossAxisSpacing: 10, //수직 Padding
                                      ),
                                      itemBuilder: (ctx, idx) {
                                        return Card();
                                      });
                                  // ListView.builder(
                                  //     padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 200),
                                  //     itemCount: files.length,
                                  //     itemBuilder: (ctx, idx) {
                                  //       File file = files[idx] as File;
                                  //       String name = file.path.split("/").last;
                                  //       String ex = name.split(".").last;
                                  //       HistoryIsar? history = IsarCtl.historyByName(name);
                                  //       String size = Utils.getFileSize(file);
                                  //       if (ex == "zip") {
                                  //         return Card(
                                  //             child: ExpansionTile(
                                  //           leading: Icon(Icons.folder_zip_outlined),
                                  //           title: Text(name),
                                  //           subtitle: Text("${size}"),
                                  //           children: [
                                  //             Row(
                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //               children: [
                                  //                 if (kDebugMode) ElevatedButton(onPressed: () => saveAs(file), child: Text("save as")),
                                  //                 ElevatedButton(
                                  //                   style: ElevatedButton.styleFrom(primary: Colors.red),
                                  //                   onPressed: () {
                                  //                     file.deleteSync();
                                  //                     reloadFn(!reloadValue!);
                                  //                   },
                                  //                   child: Text("delete".tr),
                                  //                 ),
                                  //                 ElevatedButton(
                                  //                   style: ElevatedButton.styleFrom(primary: Colors.blue),
                                  //                   onPressed: () async {
                                  //                     if (await ocrZipFile(file)) {
                                  //                       reloadFn(!reloadValue!);
                                  //                     }
                                  //                   },
                                  //                   child: Text("OCR".tr),
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ));
                                  //       }
                                  //       if (ex == "epub") {
                                  //         return Card(
                                  //             child: ExpansionTile(
                                  //           leading: Icon(Icons.menu_book_rounded),
                                  //           title: Text(name),
                                  //           subtitle: Text("${size}"),
                                  //           children: [
                                  //             Row(
                                  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //               children: [
                                  //                 ElevatedButton(
                                  //                   style: ElevatedButton.styleFrom(primary: Colors.red),
                                  //                   onPressed: () {
                                  //                     file.deleteSync();
                                  //                     reloadFn(!reloadValue!);
                                  //                   },
                                  //                   child: Text("delete".tr),
                                  //                 ),
                                  //                 ElevatedButton(
                                  //                   style: ElevatedButton.styleFrom(primary: Colors.blue),
                                  //                   onPressed: () async {
                                  //                     if (await epubConv(file)) {
                                  //                       reloadFn(!reloadValue!);
                                  //                     }
                                  //                   },
                                  //                   child: Text("text conv".tr),
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ));
                                  //       }
                                  //       return Card(
                                  //         child: ExpansionTile(
                                  //           key: Key("file_${Random().nextInt(1000000)}"),
                                  //           leading: Icon(Icons.description),
                                  //           title: Text(name),
                                  //           subtitle: Column(
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             children: [
                                  //               if (history != null) Text("${Utils.rdgPos(history)}"),
                                  //               // Text("${(history.cntntPstn / history.contentsLen * 100).toStringAsFixed(2)}% (${history.contentsLen ~/ 160000}${"books".tr})"),
                                  //               if (history != null)
                                  //                 Row(children: [
                                  //                   Flexible(
                                  //                     child: Text(
                                  //                       "${"memo".tr} : ${history.memo}",
                                  //                       overflow: TextOverflow.ellipsis,
                                  //                     ),
                                  //                   ),
                                  //                 ]),
                                  //               Text("${size}"),
                                  //             ],
                                  //           ),
                                  //           children: [
                                  //             ObxValue<RxBool>((bMemo) {
                                  //               return Column(
                                  //                 children: [
                                  //                   if (bMemo.value && history != null)
                                  //                     Container(
                                  //                       padding: EdgeInsets.all(10),
                                  //                       child: TextFormField(
                                  //                         initialValue: history.memo,
                                  //                         onFieldSubmitted: (v) {
                                  //                           IsarCtl.putHistory(history..memo = v);
                                  //                         },
                                  //                       ),
                                  //                     ),
                                  //                   Row(
                                  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //                     children: [
                                  //                       ElevatedButton(
                                  //                         style: ElevatedButton.styleFrom(primary: Colors.blue, padding: EdgeInsets.all(1)),
                                  //                         onPressed: () async {
                                  //                           if (await newLineTheorem(file)) {
                                  //                             reloadFn(!reloadValue!);
                                  //                           }
                                  //                         },
                                  //                         child: Text("newline theorem".tr, style: TextStyle(fontSize: 13)),
                                  //                       ),
                                  //                       ElevatedButton(
                                  //                         style: ElevatedButton.styleFrom(primary: Colors.red),
                                  //                         onPressed: () {
                                  //                           file.deleteSync();
                                  //                           reloadFn(!reloadValue!);
                                  //                         },
                                  //                         child: Text("delete".tr),
                                  //                       ),
                                  //                       if (history != null)
                                  //                         ElevatedButton(
                                  //                           style: ElevatedButton.styleFrom(primary: Colors.green),
                                  //                           onPressed: () {
                                  //                             bMemo(!bMemo.value);
                                  //                           },
                                  //                           child: Text("memo".tr),
                                  //                         ),
                                  //                       ElevatedButton(
                                  //                         onPressed: () async {
                                  //                           await IsarCtl.openFile(file);
                                  //                           reloadFn(!reloadValue!);
                                  //                         },
                                  //                         child: Text("open".tr),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ],
                                  //               );
                                  //             }, false.obs),
                                  //           ],
                                  //         ),
                                  //       );
                                  //     });
                                }),
                              ),
                            )
                          ],
                        );
                      });
                    }),
                Obx(() {
                  if (epubTotal.value > 0) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("${epubCurrent.value}/${epubTotal.value}"),
                          ],
                        ));
                  }
                  return SizedBox();
                }),
                Obx(() {
                  if (IsarCtl.unzipTotal.value > 0 && IsarCtl.unzipTotal.value > MAXOCRCNT) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Creating split compressed file".tr + " (${MAXOCRCNT})"),
                            Text("${IsarCtl.unzipCurrent.value}/${IsarCtl.unzipTotal.value}"),
                          ],
                        ));
                  }
                  if (IsarCtl.unzipTotal.value > 0 && IsarCtl.unzipTotal.value <= MAXOCRCNT + 10) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("${IsarCtl.unzipCurrent.value}/${IsarCtl.unzipTotal.value}"),
                          ],
                        ));
                  }
                  return SizedBox();
                })
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
