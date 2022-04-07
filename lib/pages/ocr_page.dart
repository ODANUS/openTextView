import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';

class OcrPage extends GetView {
  OcrPage() {
    getTemporaryDirectory().then((tmpDir) {
      tmpDir = Directory("${tmpDir.path}/ocr");
      var list = tmpDir.listSync(recursive: true);
      list.forEach((e) {
        if (e is File) {
          fileList.add(e);
        }
      });
    });
  }
  RxList<File> fileList = RxList<File>();
  Rx<int> lang = 4.obs;
  Rx<bool> bnewLine = true.obs;
  Rx<int> total = 0.obs;
  Rx<int> current = 0.obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // <-  WillPopScope로 감싼다.
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
          appBar: AppBar(leadingWidth: 0, leading: Text(""), title: Text("OCR")),
          body: Stack(
            children: [
              Obx(() {
                return Column(children: [
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
                    child: ReorderableListView(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 100),
                      onReorder: ((oldIndex, newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final File item = fileList.removeAt(oldIndex);
                        fileList.insert(newIndex, item);
                      }),
                      children: [
                        ...fileList.map((e) {
                          var pathList = e.path.split("/");
                          var fileName = pathList.last;
                          return Card(
                              key: Key("${fileName}"),
                              child: ListTile(
                                title: Text(fileName),
                              ));
                        }).toList(),
                      ],
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
                              var tmpDir = await getTemporaryDirectory();
                              tmpDir = Directory("${tmpDir.path}/ocr");
                              if (tmpDir.existsSync()) {
                                tmpDir.deleteSync(recursive: true);
                              }
                              Get.back();
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
                        ElevatedButton(
                            onPressed: () async {
                              TextDetectorV2 textDetector = GoogleMlKit.vision.textDetectorV2();
                              var langCode = TextRecognitionOptions.values[lang.value];
                              List<String> tmpList = [];
                              // AdCtl.
                              total(fileList.length);
                              if (fileList.length <= 60 && AdCtl.hasOpenInterstitialAd()) {
                                AdCtl.startInterstitialAd();
                              }
                              if (fileList.length > 60 && AdCtl.hasOpenRewardedAd()) {
                                AdCtl.startRewardedAd();
                              }

                              for (var file in fileList) {
                                var idx = fileList.indexOf(file);
                                var inputImage = InputImage.fromFile(file);
                                final recognisedText = await textDetector.processImage(inputImage, script: langCode);
                                recognisedText.blocks.forEach((e) {
                                  tmpList.add(e.text);
                                });
                                current(idx);
                              }
                              String rtnStr = "";

                              if (bnewLine.value) {
                                rtnStr = Utils.newLineTheoremStr(tmpList.join("\n"));
                              } else {
                                rtnStr = tmpList.join("\n");
                              }

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
                            Text("${current}/${total}"),
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
