import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as imglib;
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart' show compareNatural;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OcrPage extends GetView {
  OcrPage() {
    loadFile();
    // checkFileSize();
    // return compareNatural(a.name, b.name);
  }
  loadFile() {
    fileList.clear();
    getTemporaryDirectory().then((tmpDir) {
      tmpDir = Directory("${tmpDir.path}/ocr");
      var list = tmpDir.listSync(recursive: true);
      list.forEach((e) {
        if (e is File) {
          fileList.add(e);
        }
      });
      fileList.sort((a, b) {
        var aName = a.path.split("ocr/").last;
        var bName = b.path.split("ocr/").last;
        return compareNatural(aName, bName);
      });
    });
  }

  splitImageFiles() async {
    if (total.value > 0) {
      return;
    }
    total(bcutList.where((b) => b).length);
    await AdCtl.startRewardedAd();
    var cnt = 0;
    for (var i = 0; i < fileList.length; i++) {
      var e = fileList[i];
      var bSplit = bcutList[i];
      if (!bSplit) {
        continue;
      }
      imglib.Image? img = imglib.decodeImage(e.readAsBytesSync());
      if (img != null) {
        var pathList = e.path.split("/");
        var path = pathList.sublist(0, pathList.length - 1).join("/");
        var fileName = pathList.last.split(".").first;

        if (img.height < img.width) {
          var img1 = imglib.copyCrop(img, 0, 0, img.width ~/ 2, img.height);
          var img2 = imglib.copyCrop(img, img.width ~/ 2, 0, img.width, img.height);

          var f1 = File("${path}/${fileName}_1.png")..createSync();
          await f1.writeAsBytes(imglib.encodePng(img1));

          var f2 = File("${path}/${fileName}_2.png")..createSync();
          await f2.writeAsBytes(imglib.encodePng(img2));

          e.deleteSync();
        }
      }
      current(cnt++);
    }
    total(0);
    current(0);
    bcutList.clear();
    // fileList.forEach((e) {
    // });
    loadFile();
  }

  close() async {
    var tmpDir = await getTemporaryDirectory();
    tmpDir = Directory("${tmpDir.path}/ocr");
    if (tmpDir.existsSync()) {
      tmpDir.deleteSync(recursive: true);
    }
    Get.back();
  }

  RxList<bool> bcutList = RxList<bool>();

  RxList<File> fileList = RxList<File>();
  Rx<int> lang = 4.obs;
  Rx<bool> bnewLine = true.obs;
  Rx<int> total = 0.obs;
  Rx<int> current = 0.obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => true);
        },
        child: Scaffold(
          appBar: AppBar(
            // leadingWidth: 0,
            leading: IconButton(
              onPressed: () {
                close();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text("OCR"),
            actions: [
              IconButton(
                  onPressed: () {
                    // splitImageFiles();
                    if (bcutList.isEmpty) {
                      bcutList(fileList.map((element) => true).toList());
                    } else {
                      bcutList.clear();
                    }
                  },
                  icon: Icon(Icons.content_cut))
            ],
            bottom: PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: AdBanner(key: Key("ocr")),
            ),
          ),
          body: Stack(
            children: [
              Obx(() {
                // checkFileSize();
                // fileList.forEach((e) {
                // });
                return Column(children: [
                  if (bcutList.isNotEmpty)
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      ElevatedButton(onPressed: () => bcutList(bcutList.map((e) => true).toList()), child: Text("Select All".tr)),
                      ElevatedButton(onPressed: () => bcutList(bcutList.map((e) => false).toList()), child: Text("Unselect All".tr))
                    ]),
                  Card(
                      child: ListTile(
                    title: Text("Long press to change the order".tr),
                    subtitle: RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(text: "${"Total number of images".tr}"),
                        TextSpan(text: " ${fileList.length}  "),
                        TextSpan(text: "If the number of pages".tr),
                      ],
                    )),
                  )),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 100),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                        childAspectRatio: 1 / 1.1, //item 의 가로 1, 세로 2 의 비율
                        mainAxisSpacing: 5, //수평 Padding
                        crossAxisSpacing: 5, //수직 Padding
                      ),
                      itemCount: fileList.length,
                      itemBuilder: (ctx, idx) {
                        var e = fileList[idx];
                        return Obx(
                          () => Card(
                              child: InkWell(
                                  onTap: kDebugMode
                                      ? () {
                                          Get.toNamed("/ocr/edit", arguments: fileList[idx].path);
                                          // print("onTap");
                                        }
                                      : null,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.file(e, height: 140),
                                      if (bcutList.isNotEmpty)
                                        Checkbox(
                                            value: bcutList[idx],
                                            onChanged: (bool? v) {
                                              bcutList[idx] = v!;
                                              bcutList.refresh();
                                            })
                                    ],
                                  ))),
                        );
                      },
                      // onReorder: ((oldIndex, newIndex) {
                      //   if (oldIndex < newIndex) {
                      //     newIndex -= 1;
                      //   }
                      //   final File item = fileList.removeAt(oldIndex);
                      //   fileList.insert(newIndex, item);
                      // }),
                      // children: [
                      //   ...imageList.map((e) {
                      //     return Card(
                      //         child: ListTile(
                      //       title: Image.memory(imglib.encodePng(e) as Uint8List, width: 100, height: 100,),
                      //     ));
                      //   }).toList(),
                      // ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () async {
                              close();
                              // var tmpDir = await getTemporaryDirectory();
                              // tmpDir = Directory("${tmpDir.path}/ocr");
                              // if (tmpDir.existsSync()) {
                              //   tmpDir.deleteSync(recursive: true);
                              // }
                              // Get.back();
                            },
                            child: Text("cancel".tr)),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: bnewLine.value, onChanged: (v) => bnewLine(v)),
                                Text("newline theorem".tr),
                              ],
                            ),
                            DropdownButton<int>(
                                value: lang.value,
                                items: [
                                  DropdownMenuItem(value: 4, child: Text("한국어")),
                                  DropdownMenuItem(value: 0, child: Text("English")),
                                  DropdownMenuItem(value: 3, child: Text("日本")),
                                  DropdownMenuItem(value: 1, child: Text("中國語")),
                                ],
                                onChanged: (v) => lang(v)),
                          ],
                        ),
                        bcutList.isNotEmpty
                            ? ElevatedButton(
                                onPressed: () {
                                  splitImageFiles();
                                },
                                child: Text("Crop".tr))
                            : ElevatedButton(
                                onPressed: () async {
                                  // --------------------------------------------------------------
                                  var langCode = TextRecognitionScript.values[lang.value];
                                  TextRecognizer textDetector = TextRecognizer(script: langCode);
                                  List<String> tmpList = [];

                                  total(fileList.length);
                                  if (fileList.length <= 60 && !kDebugMode) {
                                    await AdCtl.startInterstitialAd();
                                  }
                                  if (fileList.length > 60 && !kDebugMode) {
                                    await AdCtl.startRewardedAd();
                                  }

                                  for (var file in fileList) {
                                    var idx = fileList.indexOf(file);
                                    var inputImage = InputImage.fromFile(file);
                                    final recognisedText = await textDetector.processImage(inputImage);

                                    recognisedText.blocks.forEach((e) {
                                      tmpList.add("${e.text} ");
                                    });
                                    current(idx);
                                  }
                                  String rtnStr = "";

                                  var str = tmpList.join("\n");
                                  // str = str.replaceAll("“", "\"");
                                  // str = str.replaceAll("”", "\"");
                                  // str = str.replaceAll("'", "\'");
                                  // str = str.replaceAll("”", "\"");

                                  if (bnewLine.value) {
                                    rtnStr = await Utils.newLineTheoremStr(str, useKss: false);
                                  } else {
                                    rtnStr = tmpList.join("\n");
                                  }
                                  total(0);
                                  current(0);
                                  var tmpDir = await getTemporaryDirectory();
                                  tmpDir = Directory("${tmpDir.path}/ocr");
                                  if (tmpDir.existsSync()) {
                                    tmpDir.deleteSync(recursive: true);
                                  }

                                  Get.back(result: rtnStr);
                                },
                                child: Text("confirm".tr)),
                      ],
                    ),
                  )
                ]);
              }),
              Obx(
                () => total.value > 0
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text(
                              "${current}/${total}",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ],
                        ))
                    : SizedBox(),
              )
            ],
          ),
          // bottomNavigationBar:
        ));
  }
}
