import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static Future<String?> selectLibrary() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      return selectedDirectory;
      // var d = Directory(selectedDirectory);
      // var flist = await d.list().toList();
      // var f = File("/storage/emulated/0/미디어/대한민국헌법(헌법제9호).txt");
      // String contents = await f.readAsString();

      // print(contents);

      // var wf = File(selectedDirectory + "/test1111.txt");
      // var ss = await wf.writeAsString("adsdsdsds");
      // print(await ss.readAsString());
    }
    return null;
  }

  static Future<List<FileSystemEntity>> getLibraryList(String path) async {
    Directory dir = Directory(path);
    var listDir = await dir.list().toList();
    return listDir;
  }

  static Future<List<String>?> loadLibraryPrefs() async {
    SharedPreferences prefs = await _prefs;
    prefs.reload();
    return prefs.getStringList("libraryPaths");
  }

  static setLibraryPrefs(List<String> libraryPaths) async {
    SharedPreferences prefs = await _prefs;
    prefs.reload();
    prefs.setStringList("libraryPaths", libraryPaths);
  }

  static Future<String> readFile(File f) async {
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
}
