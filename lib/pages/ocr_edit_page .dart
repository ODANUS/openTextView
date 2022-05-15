import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as imglib;
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart' show compareNatural;

class OcrEditPage extends GetView {
  OcrEditPage() {
    if (Get.arguments is String) {
      file(File(Get.arguments));
      refimgByte(imglib.decodeImage(File(Get.arguments).readAsBytesSync()));
      imgByte(imglib.decodeImage(file.value.readAsBytesSync()));
    }
    ever(imgByte, (imglib.Image? v) async {});
  }
  loadFile() async {
    if (imgByte.value != null) {
      var pathList = file.value.path.split("/");
      var path = pathList.sublist(0, pathList.length - 2).join("/");
      var fileName = pathList.last.split(".").first;

      var f1 = File("${path}/ocrtemp/${fileName}.png");
      if (!f1.existsSync()) {
        f1.createSync(recursive: true);
      }
      f1.writeAsBytesSync(imglib.encodePng(imgByte.value!));
      var langCode = TextRecognitionScript.korean;
      TextRecognizer textDetector = TextRecognizer(script: langCode);
      var process = await textDetector.processImage(InputImage.fromFile(f1));
      textBlock(process.blocks);
    }
  }

  Rx<File> file = File("").obs;
  Rxn<imglib.Image> refimgByte = Rxn<imglib.Image>();
  Rxn<imglib.Image> imgByte = Rxn<imglib.Image>();
  RxList<bool> bcutList = RxList<bool>();
  RxList<TextBlock> textBlock = RxList<TextBlock>();
  RxInt contrast = 100.obs;
  RxInt saturation = 0.obs;

  // RxList<File> fileList = RxList<File>();
  // Rx<int> lang = 4.obs;
  // Rx<bool> bnewLine = true.obs;
  // Rx<int> total = 0.obs;
  // Rx<int> current = 0.obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
          appBar: AppBar(
            // leadingWidth: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),

            title: Text("OCR Edit"),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       // splitImageFiles();
              //       if (bcutList.isEmpty) {
              //         bcutList(fileList.map((element) => true).toList());
              //       } else {
              //         bcutList.clear();
              //       }
              //     },
              //     icon: Icon(Icons.content_cut))
            ],
            bottom: PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: AdBanner(key: Key("ocr")),
            ),
          ),
          body: Stack(
            children: [
              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: Image.memory(imglib.encodePng(imgByte.value!) as Uint8List),
                    ),
                    Expanded(
                        child: Wrap(children: [
                      ...textBlock.map((e) {
                        return Text(
                          e.text,
                        );
                      }),
                    ])),
                  ],
                );
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ObxValue<RxInt>((tmpv) {
                    return Slider(
                      value: tmpv.value.toDouble(),
                      min: 0.0,
                      divisions: 100,
                      max: 100.0,
                      onChanged: (v) {
                        tmpv(v.toInt());
                      },
                      onChangeEnd: (v) {
                        // imglib.contrast(refimgByte.value, v.toInt());
                        var ss = imglib.contrast(refimgByte.value!.clone(), v.toInt());
                        imgByte(ss);
                        imgByte.refresh();
                        loadFile();
                      },
                    );
                  }, contrast),
                  ObxValue<RxInt>((tmpv) {
                    return Slider(
                      value: tmpv.value.toDouble(),
                      min: 0,
                      divisions: 255,
                      max: 255,
                      onChanged: (v) {
                        tmpv(v.toInt());
                      },
                      onChangeEnd: (v) {
                        var ss = imglib.brightness(refimgByte.value!.clone(), v.toInt());
                        imgByte(ss!);
                        imgByte.refresh();

                        loadFile();
                      },
                    );
                  }, saturation),
                  ElevatedButton(
                      onPressed: () {
                        var ss = imglib.invert(imgByte.value!.clone());
                        imgByte(ss);
                        imgByte.refresh();

                        loadFile();
                      },
                      child: Text("asda"))
                ],
              ),
            ],
          ),
        ));
  }
}
