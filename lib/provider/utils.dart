import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:epubx/epubx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:open_textview/model/model_isar.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(<K, List<E>>{}, (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

class Utils {
  static String newLineTheoremStr(String tmpStr) {
    var strList = tmpStr.split("\n");
    // strList = strList.getRange(0, 100).toList();

    List<String> rtnStr = [];

    var dotSpace = RegExp("( {1,}\\.)");
    // var colonSpace = RegExp("( {1,}\\,)");
    var questionSpace = RegExp("( {1,}\\?)");
    var exclamationSpace = RegExp("( {1,}\\!)");
    var endLine = RegExp("(다\\.)|(다\\. )");
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
    // d.log(rtnStr.join(""));

    // File outputFile = File("$path/newline_$fileName(${DF(DateTime.now(), f: 'yyyy-MM-dd HH:mm:ss')}).txt");
    // outputFile.createSync();
    // outputFile.writeAsStringSync(rtnStr.join(""));
    // outputFile.setLastAccessedSync(DateTime.now());

    return rtnStr.join("");
  }

  static Future<String> newLineTheorem(File f) async {
    String tmpStr = await readFile(f);
    return newLineTheoremStr(tmpStr);
  }

  static Future<String> convEpub(File f) async {
    List<String?> hrefs = [];
    Map<String, String> listXhtml = {};
    String cssString = "";

    String strContents = "";
    final bytes = f.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final intdatas = file.content as List<int>;
        if (file.name.contains("content.opf")) {
          var data = String.fromCharCodes(intdatas);
          var htmlData = parse(data);
          var items = htmlData.querySelector("manifest")?.querySelectorAll("item[media-type*=xml]");
          if (items != null) {
            hrefs = items.map((e) => e.attributes['href']).toList();
          }
        }
        if (file.name.contains(".css")) {
          var data = String.fromCharCodes(intdatas);
          cssString += data;
        }
        if (file.name.contains("html")) {
          var ctn = String.fromCharCodes(intdatas);
          var decodeData = await CharsetDetector.autoDecode(file.content);
          listXhtml[file.name.split("/").skip(1).join("/")] = decodeData.string;
        }
      } else {
        // Directory('out/' + filename).create(recursive: true);
      }
    }

    hrefs.forEach((href) {
      if (listXhtml[href] != null) {
        var htmlData = parse(listXhtml[href]);
        var bodytext = htmlData.body?.text ?? "";
        if (Get.locale?.languageCode.contains("ko") != null) {
          // bodytext = bodytext.split("\n").join();
          bodytext = bodytext.split("\n").map((e) => e.trim()).join("\n");
          bodytext = bodytext.split("다. ").map((e) => e.trim()).join("다. \n\n");
          bodytext = bodytext.split("\" ").map((e) => e.trim()).join("\" \n");
          bodytext = bodytext.split("” ").map((e) => e.trim()).join("\”\n");
        }
        strContents += bodytext;
      }
    });

    // }
    // File saveFile = File(e.path!.replaceAll(RegExp("epub\$"), "txt"));
    // saveFile.writeAsStringSync(strContents);
    // f.delete();

    return newLineTheoremStr(strContents);
  }

  static Future<FilePickerResult?> selectFile() async {
    var selectedFiles = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt', 'epub', "zip"]);
    if (selectedFiles == null) {
      return selectedFiles;
    }

    // await Future.forEach(selectedFiles.files, (PlatformFile e) async {
    //   if (e.extension != null && e.extension == "epub") {
    //     File f = File(e.path!);
    //     List<String?> hrefs = [];
    //     Map<String, String> listXhtml = {};
    //     String cssString = "";

    //     String strContents = "";
    //     final bytes = f.readAsBytesSync();
    //     final archive = ZipDecoder().decodeBytes(bytes);
    //     for (final file in archive) {
    //       final filename = file.name;
    //       if (file.isFile) {
    //         final intdatas = file.content as List<int>;
    //         if (file.name.contains("content.opf")) {
    //           var data = String.fromCharCodes(intdatas);
    //           var htmlData = parse(data);
    //           var items = htmlData.querySelector("manifest")?.querySelectorAll("item[media-type*=xml]");
    //           if (items != null) {
    //             hrefs = items.map((e) => e.attributes['href']).toList();
    //           }
    //         }
    //         if (file.name.contains(".css")) {
    //           var data = String.fromCharCodes(intdatas);
    //           cssString += data;
    //         }
    //         if (file.name.contains("html")) {
    //           var ctn = String.fromCharCodes(intdatas);
    //           var decodeData = await CharsetDetector.autoDecode(file.content);
    //           listXhtml[file.name.split("/").skip(1).join("/")] = decodeData.string;
    //         }
    //       } else {
    //         // Directory('out/' + filename).create(recursive: true);
    //       }
    //     }

    //     hrefs.forEach((href) {
    //       if (listXhtml[href] != null) {
    //         var htmlData = parse(listXhtml[href]);
    //         var bodytext = htmlData.body?.text ?? "";
    //         if (Get.locale?.languageCode.contains("ko") != null) {
    //           // bodytext = bodytext.split("\n").join();
    //           bodytext = bodytext.split("\n").map((e) => e.trim()).join("\n");
    //           bodytext = bodytext.split("다. ").map((e) => e.trim()).join("다. \n\n");
    //           bodytext = bodytext.split("\" ").map((e) => e.trim()).join("\" \n");
    //           bodytext = bodytext.split("” ").map((e) => e.trim()).join("\”\n");
    //         }
    //         strContents += bodytext;
    //       }
    //     });
    //     // List<int> bytes = await f.readAsBytes();
    //     // EpubBook epubBook = await EpubReader.readBook(bytes);
    //     // if (epubBook.Content != null) {
    //     //   EpubContent bookContent = epubBook.Content!;
    //     //   var strContent = bookContent.Html!.values.map((EpubTextContentFile value) {
    //     //     var document = parse(value.Content!);

    //     //     var saveData = document.body!.text; //bodyToText(document.body!);
    //     //     saveData = saveData.split("\n").map((e) => e.trim()).join("\n");

    //     //     saveData = saveData.replaceAll(RegExp(r"\n{3,}"), "\n\n");
    //     //     return saveData;
    //     //   }).join();

    //     // }
    //     File saveFile = File(e.path!.replaceAll(RegExp("epub\$"), "txt"));
    //     saveFile.writeAsStringSync(strContents);
    //     f.delete();
    //   }
    // });

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
          decodeContents = (await CharsetConverter.decode('EUC-KR', bytes))!;
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
        rtn = "${(history.pos / history.length * 100).toStringAsFixed(2)}% ";
      }
      if (bnumber) {
        rtn += "${history.pos}/${history.length}";
      }
    } else {
      if (bpercent) {
        rtn = "${(history.cntntPstn / history.contentsLen * 100).toStringAsFixed(2)}% ";
      }
      if (bnumber) {
        rtn += "${history.cntntPstn}/${history.contentsLen}";
      }
    }
    if (bBooks && history.contentsLen > 0) {
      rtn += " (${history.contentsLen ~/ 160000} ${"books".tr})";
    }
    return rtn;
  }
}
