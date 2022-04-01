import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

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
  static Future<FilePickerResult?> selectFile() async {
    var selectedFiles = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt', 'epub']);
    if (selectedFiles == null) {
      return selectedFiles;
    }

    await Future.forEach(selectedFiles.files, (PlatformFile e) async {
      if (e.extension != null && e.extension == "epub") {
        File f = File(e.path!);
        List<int> bytes = await f.readAsBytes();
        EpubBook epubBook = await EpubReader.readBook(bytes);
        if (epubBook.Content != null) {
          EpubContent bookContent = epubBook.Content!;
          var strContent = bookContent.Html!.values.map((EpubTextContentFile value) {
            var document = parse(value.Content!);

            var saveData = document.body!.text; //bodyToText(document.body!);
            saveData = saveData.split("\n").map((e) => e.trim()).join("\n");
            saveData = saveData.replaceAll(RegExp(r"\n{3,}"), "\n\n");
            return saveData;
          }).join();

          File saveFile = File(e.path!.replaceAll(RegExp("epub\$"), "txt"));
          saveFile.writeAsStringSync(strContent);
          f.delete();
        }
      }
    });

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
