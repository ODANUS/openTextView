import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive_io.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kss_dart/kss_dart.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart' show compareNatural;
import 'package:pdf_text/pdf_text.dart';
import 'package:flutter/src/foundation/isolates.dart' as iso;

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) =>
      fold(<K, List<E>>{}, (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

String testSplitSentences(String str) {
  Kss kss = Kss();
  return kss.splitSentences(str, maxRecoverLength: str.length).join("\n\n");
}

class Utils {
  static Future<bool> newLineTheoremFile(File f, {useKss = false}) async {
    var rtn = false;
    if (!kDebugMode) {
      rtn = await AdCtl.openInterstitialAdNewLine();
    }
    if (kDebugMode) rtn = true;
    // var rtn = true;
    if (rtn) {
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;

      String rtnStr = await newLineTheorem(f, useKss: useKss);
      String savePath = "newline_$fileName.txt";
      if (useKss) {
        savePath = "kss_$fileName.txt";
      }
      File outputFile = File("$path/$savePath");
      if (!outputFile.existsSync()) {
        outputFile.createSync();
      }
      outputFile.writeAsStringSync(rtnStr);
      outputFile.setLastAccessedSync(DateTime.now());
      return true;
    }
    return false;
  }

  static Future<bool> saveAs(File f) async {
    if (!await Get.dialog(AlertDialog(
        title: Text("precautions".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("save as cmd".tr),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text("Watch the ad and save the file as.".tr),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.red), onPressed: () => Get.back(result: false), child: Text("cancel".tr)),
          ElevatedButton.icon(onPressed: () => Get.back(result: true), icon: Icon(Icons.smart_display), label: Text("agreement".tr)),
        ]))) {
      return false;
    }
    // if (!AdCtl.hasOpenRewardedInterstitialAd()) {
    //   return await Get.dialog(AlertDialog(title: Text("다른 이름으로 저장."), content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    // }
    // var rtn = await AdCtl.openSaveAsAd();
    var rtn = await AdCtl.startSaveAsInterstitialAd();
    if (rtn) {
      final params = SaveFileDialogParams(sourceFilePath: f.path);
      await FlutterFileDialog.saveFile(params: params);
    }

    return true;
  }

  static Future<bool> epubConv(File f) async {
    var rtn = await AdCtl.openInterstitialAdEpubConv();
    // var rtn = true;
    if (rtn) {
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;
      String rtnStr = await Utils.convEpub(f, onProcess: (total, cur) {
        IsarCtl.epubTotal(total);
        IsarCtl.epubCurrent(cur);
      }, onFont: () async {
        return Get.dialog(AlertDialog(
          content: Text("There are built-in fonts.".tr),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text("epub->text")),
            ElevatedButton(
                onPressed: () {
                  Get.back(result: true);
                  AdCtl.startInterstitialAd();
                },
                child: Text("Epub->Image->OCR".tr)),
          ],
        ));
      });
      IsarCtl.epubTotal(0);
      IsarCtl.epubCurrent(0);

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

  static Future<bool> pdfConv(File f) async {
    var rtn = await AdCtl.openInterstitialAdPDFConv();
    // var rtn = true;
    if (rtn) {
      IsarCtl.bLoadingLib(true);
      var pathList = f.path.split("/");
      var path = pathList.sublist(0, pathList.length - 1).join("/");
      var fileName = pathList.last.split(".").first;

      String rtnStr = "";
      try {
        PDFDoc doc = await PDFDoc.fromFile(f);
        IsarCtl.bLoadingLib(false);

        IsarCtl.epubTotal(doc.pages.length);
        // for (var i = 0; i < 5; i++) {
        for (var i = 0; i < doc.pages.length; i++) {
          IsarCtl.epubCurrent(i);
          var v = doc.pages[i];
          rtnStr += await v.text;
        }
      } catch (e) {}
      IsarCtl.bLoadingLib(false);

      IsarCtl.epubTotal(0);
      rtnStr = await newLineTheoremStr(rtnStr);

      if (rtnStr.trim().isEmpty) {
        Get.dialog(AlertDialog(
          content: Text("Failed to convert pdf.".tr),
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

      File outputFile = File("$path/pdf_$fileName.txt");
      if (!outputFile.existsSync()) {
        outputFile.createSync();
      }
      outputFile.writeAsStringSync(rtnStr);
      outputFile.setLastAccessedSync(DateTime.now());

      return true;
    }
    return false;
  }

  static Future<bool> ocrZipFile(File f) async {
    var pathList = f.path.split("/");
    var path = pathList.sublist(0, pathList.length - 1).join("/");
    var zipFileName = pathList.last.split(".").first;

    final bytes = f.readAsBytesSync();
    Archive archive;

    try {
      archive = ZipDecoder().decodeBytes(bytes);
    } catch (e) {
      return false;
    }

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

    if (archive.length > IsarCtl.MAXOCRCNT + 10) {
      AdCtl.startInterstitialAd();
      IsarCtl.unzipTotal(archive.length);
      var idx = 0;
      var cnt = 0;
      var total = 0;
      ZipFileEncoder encoder = ZipFileEncoder();
      Directory newDir = Directory("${rootTmpDir.path}/file_picker/$zipFileName");
      if (!newDir.existsSync()) newDir.createSync();
      try {
        for (var file in archive) {
          if (cnt == 0) {
            if (idx > 0) {
              encoder.close();
            }
            encoder.create("${newDir.path}/${"${++idx}_div".padLeft(2, "0")}_${zipFileName}.zip");
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
          if (cnt++ >= IsarCtl.MAXOCRCNT - 1) {
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
        if (file.isFile && (file.name.contains(".zip"))) {
          var zipDir = Directory("$path")..createSync(recursive: true);

          final data = file.content as List<int>;
          var tmpFile = File("${zipDir.path}/$filename");
          if (!tmpFile.existsSync()) {
            await tmpFile.create(recursive: true);
          }
          IsarCtl.unzipCurrent(idx++);
          await tmpFile.writeAsBytes(data);
        }
        if (file.isFile && (file.name.contains(".gif") || file.name.contains(".png") || file.name.contains(".jpg") || file.name.contains(".jpeg"))) {
          final data = file.content as List<int>;
          var tmpFile = File("${tmpDir.path}/$filename");
          if (!tmpFile.existsSync()) {
            await tmpFile.create(recursive: true);
          }
          IsarCtl.unzipCurrent(idx++);
          await tmpFile.writeAsBytes(data);
        } else {
          Directory("${tmpDir.path}/$filename").create(recursive: true);
        }
      }
      IsarCtl.unzipTotal(0);
      var imglist = tmpDir.listSync(recursive: true).where((e) {
        var ex = e.path.split(".").last;

        return ex.contains("gif") || ex.contains("png") || ex.contains("jpg") || ex.contains("jpeg");
      });
      if (imglist.isNotEmpty) {
        var rtn = await Get.toNamed("/ocr");
        if (rtn != null) {
          File outputFile = File("$path/ocr_$zipFileName.txt");
          if (!outputFile.existsSync()) {
            outputFile.createSync();
          }
          outputFile.createSync();
          outputFile.writeAsStringSync(rtn);
          outputFile.setLastAccessedSync(DateTime.now());
        }
      }
    }

    return true;
  }

  static Future<String> newLineTheoremStr(String tmpStr, {bool useKss = false}) async {
    List<String> rtnStr = [];
    // Get.locale != null && Get.locale!.languageCode == "ko" && useKss && kDebugMode

    if (useKss) {
      var listTmpStr = tmpStr.split("\n");
      IsarCtl.epubTotal(listTmpStr.length);

      List<String> rtn = [];

      for (var i = 0; i < listTmpStr.length; i += 10) {
        IsarCtl.epubCurrent(i);
        var tmpStr = listTmpStr.getRange(i, min(i + 10, listTmpStr.length - 1));
        rtn.add(await iso.compute(testSplitSentences, tmpStr.join("\n")));
      }

      IsarCtl.epubTotal(0);

      return rtn.join("\n\n");
    } else {
      tmpStr = tmpStr.replaceAll(RegExp("\n{2,}"), "▤▤▤&&&");
      var strList = tmpStr.split("\n");

      var dotSpace = RegExp("( {1,}\\.)");
      // var colonSpace = RegExp("( {1,}\\,)");
      var questionSpace = RegExp("( {1,}\\?)");
      var exclamationSpace = RegExp("( {1,}\\!)");
      var endLine = RegExp(r"다\. {0,}");
      if (Get.locale?.languageCode != "ko") {
        endLine = RegExp("(\\.)|(\\. )|(\\。 )");
      }

      // var startCon1 = RegExp("‘");
      var startCon2 = RegExp("\^-");
      var startCon3 = RegExp("“");
      var startCon4 = RegExp("\^\"");

      var endCon0 = RegExp(" {0,}’ {1,}");
      var endCon1 = RegExp(" {0,}”");
      var endCon2 = RegExp("\\\"\n");
      var endCon3 = RegExp("\\\"\$");
      var endCon4 = RegExp("-\$");

      var endSpecialCon1 = RegExp(" {0,}▤▤▤&&& {0,}\’");
      var endSpecialCon2 = RegExp(" {0,}▤▤▤&&& {0,}\”");
      var endSpecialCon3 = RegExp(" {0,}▤▤▤&&& {0,}\"");
      var endSpecialCon4 = RegExp("\\? {0,}▤▤▤&&& {0,}\"");
      var endSpecialCon5 = RegExp("\\! {0,}▤▤▤&&& {0,}\"");
      var endSpecialCon6 = RegExp(" {0,}▤▤▤&&& {0,}\\\]");

      strList.forEach((v) {
        v = v.trim();

        v = v.replaceAllMapped(dotSpace, (match) => "\.");
        // v = v.replaceAllMapped(colonSpace, (match) => "\,");
        v = v.replaceAllMapped(questionSpace, (match) => "?");
        v = v.replaceAllMapped(exclamationSpace, (match) => "!");

        // v = v.replaceAllMapped(startCon1, (match) => "▤▤▤&&&‘");
        v = v.replaceAllMapped(startCon2, (match) => "▤▤▤&&&-");
        v = v.replaceAllMapped(startCon3, (match) => "&&&▒▒▒“");
        v = v.replaceAllMapped(startCon4, (match) => "&&&▒▒▒\"");

        if (!v.contains("&&&▒▒▒") && Get.locale?.languageCode == "ko") {
          v = v.replaceAllMapped(endLine, (match) => "다.▤▤▤&&&");
        } else if (Get.locale?.languageCode != "ko") {
          v = v.replaceAllMapped(endLine, (match) => ".▤▤▤&&&");
        }
        v = v.replaceAllMapped(endCon0, (match) => "\’▤▤▤&&&");
        v = v.replaceAllMapped(endCon1, (match) => "\”▤▤▤&&&");
        v = v.replaceAllMapped(endCon2, (match) => "\"▤▤▤&&&");
        v = v.replaceAllMapped(endCon3, (match) => "\"▤▤▤&&&");
        v = v.replaceAllMapped(endCon4, (match) => "-▤▤▤&&&");

        v = v.replaceAllMapped(endSpecialCon1, (match) => "\’▤▤▤&&&");
        v = v.replaceAllMapped(endSpecialCon2, (match) => "\”▤▤▤&&&");
        v = v.replaceAllMapped(endSpecialCon3, (match) => "\"▤▤▤&&&");
        v = v.replaceAllMapped(endSpecialCon4, (match) => "\\?▤▤▤&&&");
        v = v.replaceAllMapped(endSpecialCon5, (match) => "\\!▤▤▤&&&");
        v = v.replaceAllMapped(endSpecialCon6, (match) => "\]▤▤▤&&&");

        v = v.trim();

        v = v.replaceAll("▤▤▤&&&", "\n\n");
        v = v.replaceAll("&&&▒▒▒", "\n\n");

        rtnStr.add(v);
      });
    }
    // d.log(rtnStr.join(""));

    // File outputFile = File("$path/newline_$fileName(${DF(DateTime.now(), f: 'yyyy-MM-dd HH:mm:ss')}).txt");
    // outputFile.createSync();
    // outputFile.writeAsStringSync(rtnStr.join(""));
    // outputFile.setLastAccessedSync(DateTime.now());

    return rtnStr.join("");
  }

  static Future<String> newLineTheorem(File f, {useKss = false}) async {
    String tmpStr = await readFile(f);
    return newLineTheoremStr(tmpStr, useKss: useKss);
  }

  static Future<String> convEpub(File f, {Function(int total, int current)? onProcess, Function? onFont}) async {
    var pathList = f.path.split("/");
    var path = pathList.sublist(0, pathList.length - 2).join("/");
    List<String> hrefs = [];
    Map<String, String> listhtml = {};
    Map<String, String> cssMap = {};

    String strContents = "";
    final bytes = f.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    bool bFont = false;
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final intdatas = file.content as List<int>;
        if (file.name.contains(".opf")) {
          var data = String.fromCharCodes(intdatas);
          var htmlData = parse(data);
          var items = htmlData.querySelector("manifest")?.querySelectorAll("item[media-type*=xml]");
          if (items != null) {
            hrefs = items.map((e) {
              var rtn = e.attributes['href'] ?? "";
              // if (rtn.indexOf("/") < 0) {
              //   var filePath = file.name.split("/");
              //   rtn = filePath.getRange(0, filePath.length - 1).join("/") + "/" + rtn;
              // }
              return rtn;
            }).toList();
          }
        }
        if (file.name.contains(".css")) {
          var ctn = String.fromCharCodes(intdatas);
          var decodeData = await CharsetDetector.autoDecode(file.content);
          cssMap[file.name.split("/").skip(1).join("/")] = decodeData.string;
        }
        if (file.name.contains("html")) {
          var ctn = String.fromCharCodes(intdatas);
          var decodeData = await CharsetDetector.autoDecode(file.content);
          listhtml[file.name.split("/").skip(1).join("/")] = decodeData.string;
        }
        if (file.name.contains(".ttf") || file.name.contains(".otf")) {
          var font = file.content as Uint8List;
          if (file.size > 15000000) {
            bFont = true;
            await ui.loadFontFromList(font, fontFamily: "tmpfont");
          }
        }
      } else {
        // Directory('out/' + filename).create(recursive: true);
      }
    }
    if (bFont && (onFont != null && await onFont())) {
      var str = "";
      Map<int, String> codeMap = {};
      var bodytext = "";

      var htmllen = listhtml.keys.length;
      for (var i = 0; i < hrefs.length; i++) {
        if (onProcess != null) {
          onProcess(htmllen, i);
          await Future.delayed(10.milliseconds);
        }
        String href = hrefs.elementAt(i);
        if (listhtml[href] != null) {
          var htmlData = parse(listhtml[href]);
          bodytext = htmlData.body?.text ?? "";
          ui.PictureRecorder recorder = ui.PictureRecorder();
          Canvas canvas = Canvas(recorder);
          canvas.drawPaint(Paint()..color = Colors.white);

          var t = TextPainter(
            text: TextSpan(
              text: bodytext,
              style: TextStyle(
                fontFamily: "tmpfont",
                color: Colors.black,
                fontSize: 14,
                height: 1.2,
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: 1500);

          t.paint(canvas, Offset(50, 0));
          var img = await recorder.endRecording().toImage(1500, t.height.toInt());
          var pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
          var ff = File('${path}/epub_ocr.png')..writeAsBytesSync(pngBytes!.buffer.asInt8List());
          // final params = SaveFileDialogParams(sourceFilePath: ff.path);
          // await FlutterFileDialog.saveFile(params: params);
          var tmpstr = await ocrData(ff);
          str += tmpstr;
        }
      }
      var ex = RegExp(r"\| htt.+\n.{0,}\n.{0,}\n.{0,}\n.{0,}\n.{0,}\n.{0,}");
      var rtn = (await newLineTheoremStr(str)).replaceAll(ex, "");
      return rtn;
    }
    var htmllen = listhtml.keys.length;
    // for (var i = 0; i < 2; i++) {
    for (var i = 0; i < hrefs.length; i++) {
      String href = hrefs.elementAt(i);
      if (listhtml[href] != null) {
        listhtml[href] = listhtml[href]!.replaceAll('<title/>', "");
        var htmlData = parse(listhtml[href]);
        if (cssMap.keys.length > 10) {
          if (onProcess != null) {
            onProcess(htmllen, i);
            await Future.delayed(10.milliseconds);
          }
          try {
            removeFontSize0(htmlData, cssMap);
          } catch (e) {}
        }
        var bodytext = htmlData.body?.text ?? "";

        bodytext = bodytext.replaceAll("\u200B", "");
        bodytext = bodytext.replaceAll("\u200C", "");
        bodytext = bodytext.replaceAll("\u200D", "");
        bodytext = bodytext.replaceAll("\u200E", "");
        bodytext = bodytext.replaceAll("\uFEFF", "");

        bodytext = bodytext.split("\n").map((e) => e.trim()).join("\n\n");
        if (Get.locale?.languageCode.contains("ko") != null) {
          bodytext = bodytext.split("다. ").map((e) => e.trim()).join("다. \n\n");
          // bodytext = bodytext.split("\" ").map((e) => e.trim()).join("\" \n\n");
          // bodytext = bodytext.split("” ").map((e) => e.trim()).join("\”\n\n");
        }
        strContents += bodytext;
      }
    }

    return newLineTheoremStr(strContents);
  }

  static ocrData(File file) async {
    var langCode = TextRecognitionScript.korean;
    TextRecognizer textDetector = TextRecognizer(script: langCode);
    List<String> tmpList = [];

    var inputImage = InputImage.fromFile(file);
    final recognisedText = await textDetector.processImage(inputImage);

    recognisedText.blocks.forEach((e) {
      e.lines.forEach((element) {
        tmpList.add("${element.text} ");
      });
    });
    return tmpList.join("\n\n");
  }

  static removeFontSize0(dom.Document htmlData, Map<String, String> cssMap) {
    var links = htmlData.querySelectorAll("link[type=\"text/css\"]");
    links.forEach((e) {
      if (e.attributes['href']?.isNotEmpty != null) {
        var fontsizes = cssMap[e.attributes['href']]!.split(RegExp(r" {font-size:.{1,5}0}"));

        fontsizes.forEach((classname) {
          if (classname.trim().isNotEmpty) {
            var arr = htmlData.querySelectorAll(classname);
            arr.forEach((e) {
              if (e.children.isNotEmpty) return;
              e.remove();
            });
          }
        });
      }
    });
  }

  static Future<FilePickerResult?> selectFile() async {
    IsarCtl.bLoadingLib(true);

    FilePickerResult? selectedFiles;
    if (Platform.isIOS) {
      FilePicker.platform.clearTemporaryFiles();
      selectedFiles =
          await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt', 'epub', "zip", "pdf"]);
    } else {
      selectedFiles =
          await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt', 'epub', "zip", "pdf"]);
    }

    IsarCtl.bLoadingLib(false);
    if (selectedFiles == null) {
      return selectedFiles;
    }

    selectedFiles.files.forEach((f) {
      var tmpEx = f.path!.split(".").last.toLowerCase();
      if (tmpEx != "txt" && tmpEx != "epub" && tmpEx != "zip" && tmpEx != "pdf") {
        File(f.path!).deleteSync();
      }
    });

    var curPath = IsarCtl.libDir.value.path;
    var pathArr = curPath.split("/");
    if (pathArr.last != "file_picker") {
      selectedFiles.files.forEach((e) {
        var f = File(e.path!);
        f.renameSync("${curPath}/${f.path.split("/").last}");
      });
    }

    return selectedFiles;
  }

  static Future<String> readFile(File f) async {
    try {
      if (f.existsSync()) {
        Uint8List bytes = f.readAsBytesSync();
        String decodeContents = "";
        try {
          DecodingResult result = await CharsetDetector.autoDecode(bytes);
          decodeContents = result.string;
        } catch (e) {
          decodeContents = (await CharsetConverter.decode('EUC-KR', bytes));
        }
        return decodeContents;
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  static String getFileSize(File f) {
    int bytes = f.lengthSync();
    String size = "0 B";
    if (bytes > 0) {
      const suffixes = ['B', 'KB', 'MB', 'GB'];
      var i = (log(bytes) / log(1024)).floor();
      size = ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
    }
    return size;
  }

  static String DF(DateTime d, {String f: "yyyy-MM-dd", int add = 0}) {
    DateFormat dateFormat = DateFormat(f);
    d = d.add(Duration(days: add));
    return dateFormat.format(d);
  }

  static String rdgPos(HistoryIsar history, {bBooks = false, bnumber = false, bpercent = true}) {
    String rtn = "";
    if (history.cntntPstn <= 0 && history.pos > 0) {
      if (bpercent) {
        if (history.pos > 0 && history.length > 0) {
          rtn = "${(history.pos / history.length * 100).toStringAsFixed(2)}% ";
        } else {
          rtn = "0% ";
        }
      }
      if (bnumber) {
        rtn += "${history.pos}/${history.length}";
      }
    } else {
      if (bpercent) {
        if (history.cntntPstn > 0 && history.contentsLen > 0) {
          rtn = "${(history.cntntPstn / history.contentsLen * 100).toStringAsFixed(2)}% ";
        } else {
          rtn = "0% ";
        }
      }
      if (bnumber) {
        rtn += "${history.cntntPstn}/${history.contentsLen}";
      }
    }
    if (bBooks && history.contentsLen > 0) {
      rtn += " (${history.contentsLen ~/ 120000} ${"books".tr})";
    }
    return rtn;
  }
}
