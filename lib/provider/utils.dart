import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:charset_converter/charset_converter.dart';
import 'package:epubx/epubx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
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
  // static Future<String?> selectLibrary() async {
  //   String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  //   if (selectedDirectory != null) {
  //     return selectedDirectory;
  //   }
  //   return null;
  // }

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

  // static Size calword(String s, style) {
  //   TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: s, style: style),
  //     textDirection: TextDirection.ltr,
  //     textWidthBasis: TextWidthBasis.longestLine,
  //   )..layout(maxWidth: 300);

  //   return textPainter;
  // }

  static Size calcTextSize(String text, TextStyle style, double width, double scheight) {
    final List<String> _pageTexts = [];
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout(maxWidth: width);
    List<LineMetrics> lines = textPainter.computeLineMetrics();
    double currentPageBottom = scheight;
    int currentPageStartIndex = 0;
    int currentPageEndIndex = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;

      // Current line overflow page
      if (currentPageBottom < bottom) {
        // https://stackoverflow.com/questions/56943994/how-to-get-the-raw-text-from-a-flutter-textbox/56943995#56943995
        currentPageEndIndex = textPainter.getPositionForOffset(Offset(left, top)).offset;
        final pageText = text.substring(currentPageStartIndex, currentPageEndIndex);
        _pageTexts.add(pageText);

        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + scheight;
      }
    }

    final lastPageText = text.substring(currentPageStartIndex);
    _pageTexts.add(lastPageText);
    // _pageTexts.forEach((e) {
    //   print("------------------------------------");
    //   print(e);
    // });

    return textPainter.size;
  }

  static double clContensSize(List<String> texts, TextStyle style, double width, double height) {
    Map<int, double> cache = {};
    List<ContentsIsar> rtnList = [];
    double totleHeight = 0;
    for (var i = 0; i < texts.length; i++) {
      String text = texts[i];
      if (cache[text.length] == null) {
        TextPainter textPainter = TextPainter(
          text: TextSpan(text: "${text}\n", style: style),
          textDirection: TextDirection.ltr,
          textWidthBasis: TextWidthBasis.longestLine,
        )..layout(maxWidth: width);
        // textPainter.text = TextSpan(text: text, style: style);
        cache[text.length] = textPainter.height.h;
      }
      totleHeight += cache[text.length]!;
    }

    // if (cache[text.length]! > height) {
    //   var tmplist = getTextList(text, style, width, height);
    //   rtnList.addAll(tmplist
    //       .asMap()
    //       .map((idx, t) {
    //         return MapEntry(
    //             idx,
    //             ContentsIsar(
    //               height: height,
    //               text: t,
    //               idx: rtnList.length + idx,
    //             ));
    //       })
    //       .values
    //       .toList());
    // } else {
    //   rtnList.add(ContentsIsar(
    //     height: cache[text.length]!,
    //     text: text,
    //     idx: rtnList.length,
    //   ));
    // }
    // }
    return totleHeight;
  }

  static List<String> getTextPages(List<String> texts, TextStyle style, double width, double scheight) {
    // var list = texts.map((e) => TextSpan(text: "$e\n", style: style)).toList();

    List<String> textList = [];
    for (var i = 0; i < texts.length; i++) {
      textList.add(texts[i]);
      TextPainter textPainter = TextPainter(
        text: TextSpan(children: textList.map((e) => TextSpan(text: "$e\n", style: style)).toList(), style: style),
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.longestLine,
      )..layout(maxWidth: width);

      List<LineMetrics> lines = textPainter.computeLineMetrics();
      if (lines.last.baseline > scheight) {
        if (textList.length == 1) {
          // print("$i > ${lines.last.baseline}");
          return getTextList(texts[i], style, width, scheight);
        }
        textList.remove(texts[i]);
        break;
      }
      // print(lines.last.baseline);
      // print(lines.last.descent);
    }
    return textList;
  }

  static List<String> getTextList(String text, TextStyle style, double width, double scheight) {
    // https://gist.github.com/ltvu93/36b249d1b5b5861a5ef58d958a50ad98
    final List<String> _pageTexts = [];
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      // textScaleFactor: 1.sp,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout(maxWidth: width);

    List<LineMetrics> lines = textPainter.computeLineMetrics();

    double currentPageBottom = scheight;
    int currentPageStartIndex = 0;
    int currentPageEndIndex = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;
      if (currentPageBottom < bottom) {
        currentPageEndIndex = textPainter.getPositionForOffset(Offset(left, top)).offset;

        final pageText = text.substring(currentPageStartIndex, currentPageEndIndex);
        _pageTexts.add(pageText);

        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + scheight;
      }
    }

    final lastPageText = text.substring(currentPageStartIndex);
    _pageTexts.add(lastPageText);

    return _pageTexts;
  }

  // static List<ContentsIsar> parseSizeList(
  //     List<String> contents,
  //     TextStyle textStyle,
  //     double maxWidth,
  //     double scheight,
  //     double fullscheight) {
  //   Map<int, double> cache = {};
  //   List<ContentsIsar> rtn = [];

  //   double tmpsch = 0;
  //   var idx = 0;
  //   contents.forEach((text) {
  //     double h = 0;
  //     if (cache[text.length] != null) {
  //       h = cache[text.length]!;
  //     } else {
  //       h = calcTextSize(text, textStyle, maxWidth).height;
  //       cache[text.length] = h;
  //     }

  //     // if(tmpsch + h)

  //     rtn.add(ContentsIsar(idx: idx, height: h.h, text: text));
  //   });

  //   // print(rtn);
  //   return rtn;
  // }

  // static clContensSize(List<String> contents, TextStyle textStyle,
  //     double maxWidth, double fullScreenheight, double height) {
  //   // var sizeList = parseSizeList(contents, textStyle, maxWidth, height);

  //   // var sizeMap = sizeList.getRange(0, 30).toList().asMap();
  //   // // print(sizeMap);
  //   // double sumHeight = 0;
  //   // double idx = 0;
  //   // List<num> idxList = [];
  //   // var fullScreenRtn = sizeMap.map((k, h) {
  //   //   if (h > fullScreenheight) {
  //   //     idx++;
  //   //     return MapEntry(idx, [h / fullScreenheight]);
  //   //   }
  //   //   if (sumHeight + h > fullScreenheight) {
  //   //     idx++;
  //   //     sumHeight = h;
  //   //     idxList.clear();
  //   //   } else {
  //   //     sumHeight += h;
  //   //   }
  //   //   idxList.add(k);
  //   //   return MapEntry(idx, idxList.toList());
  //   // });

  //   // print(fullScreenRtn);
  //   // print(1.sp);
  //   // print(height);
  //   // return
  //   // List<Map<int, List<int>>, Map<int, List<int>>>
  //   // var h = 690.h -
  //   //     kToolbarHeight.h -
  //   //     (setting.paddingTop.h + setting.paddingBottom.h);
  // }

  // static String bodyToText(Element e) {
  //   var rtn = e.text;
  //   rtn = rtn.trim();
  //   if (e.children.length > 0) {
  //     rtn += e.children
  //         .map((v) {
  //           if (v.localName?.toLowerCase() == "br") {
  //             return "\n";
  //           }
  //           if (v.localName?.toLowerCase() == "img") {
  //             return "";
  //           }
  //           return bodyToText(v);
  //         })
  //         .toList()
  //         .join("\n");
  //     // rtn += "\n";
  //   }
  //   if (rtn.isEmpty) {
  //     return "";
  //   }
  //   return rtn;
  // }

  // static Future<List<FileSystemEntity>> getLibraryList(String path) async {
  //   await Permission.storage.request();
  //   Directory dir = Directory(path);
  //   var listDir = await dir.list().toList();
  //   return listDir;
  // }

  // static Future<List<String>?> loadLibraryPrefs() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   return prefs.getStringList("libraryPaths");
  // }

  // static setLibraryPrefs(List<String> libraryPaths) async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   prefs.setStringList("libraryPaths", libraryPaths);
  // }

  // static Future<String?> loadprefs() async {
  //   var userData = await loadUserData();
  //   if (userData != null) {
  //     var ctl = Get.find<BoxCtl>();
  //     var jsonData = json.decode(userData);
  //     SettingBox settingData = SettingBox();
  //     if (jsonData["tts"] != null && jsonData["ui"] != null) {
  //       Map<String, dynamic> settingMap = {
  //         ...jsonData["tts"] as Map,
  //         ...jsonData["ui"] as Map,
  //         "theme": jsonData["theme"]
  //       };

  //       settingData = SettingBox.fromMap(settingMap);
  //       ctl.setSettingBox(settingData);

  //       if (jsonData["filter"] is List<dynamic>) {
  //         var jsonList = jsonData["filter"] as List<dynamic>;

  //         var list = jsonList.map((e) => FilterBox.fromMap(e)).toList();

  //         ctl.setFilterBox(list);
  //       }

  //       if (jsonData["history"] is List<dynamic>) {
  //         var jsonList = jsonData["history"] as List<dynamic>;
  //         var list = jsonList.map((e) {
  //           List<String> tmparr = e["date"].split(" ");
  //           var dateStr = "${tmparr[0]} ${tmparr[1].replaceAll("-", ":")}";
  //           e["date"] = DateTime.parse(dateStr).millisecondsSinceEpoch;
  //           return HistoryBox.fromMap(e);
  //         }).toList();
  //         ctl.setHistoryBox(list);
  //       }
  //     }
  //   }
  // }

  // static Future<String?> loadUserData() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   return prefs.getString("userdata");
  // }

  // static Future<void> setUserData(strjson) async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.setString("userdata", strjson);
  // }

  // static Future<void> clearUserData() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.remove("userdata");
  // }

  // static Future<String?> loadLastData() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   return prefs.getString("lastdata");
  // }

  // static Future<void> setLastData(strjson) async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.setString("lastdata", strjson);
  // }

  // static Future<void> clearLastData() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.remove("lastdata");
  // }

  // static Future<String?> loadCurrentData() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   return prefs.getString("currentdata");
  // }

  // static Future setCurrentData(strjson) async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   prefs.setString("currentdata", strjson);
  // }

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

  static getList() {}

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

  // 기존 데이터 마이그레이션을 위해 한동안 유지후 삭제 해야함.
  // static Future<bool> isLocalStorage() async {
  //   Directory appdir = await getApplicationDocumentsDirectory();
  //   File f = File(appdir.path + "/opentextview");
  //   return f.existsSync();
  // }

  // static Future<String> getLocalStorage() async {
  //   Directory appdir = await getApplicationDocumentsDirectory();
  //   File f = File(appdir.path + "/opentextview");
  //   return f.readAsStringSync();
  // }

  // static Future<void> delLocalStorage() async {
  //   Directory appdir = await getApplicationDocumentsDirectory();
  //   File f = File(appdir.path + "/opentextview");
  //   f.deleteSync();
  // }

  // static Future<UserData?> localStorageToUserData() async {
  //   if (await Utils.isLocalStorage()) {
  //     String strlocaljson = await Utils.getLocalStorage();
  //     dynamic localjson = json.decode(strlocaljson);
  //     UserData tmpuserData = UserData();
  //     if (localjson['config'] != null) {
  //       if (localjson['config']['tts'] != null) {
  //         tmpuserData.tts = Tts.fromMap(localjson['config']['tts']);
  //       }
  //       if (localjson['config']['filter'] != null) {
  //         tmpuserData.filter = (localjson['config']['filter'] as List)
  //             .map((e) => Filter.fromMap(e))
  //             .toList();
  //       }
  //       if (localjson['config']['ocr'] != null) {
  //         tmpuserData.ocr = Ocr.fromMap(localjson['config']['ocr']);
  //       }
  //     }
  //     if (localjson['history'] != null) {
  //       tmpuserData.history = (localjson['history'] as List)
  //           .map((e) => History.fromMap(e))
  //           .toList();
  //     }
  //     return tmpuserData;
  //   }
  //   return null;
  // }
}
