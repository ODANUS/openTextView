import 'dart:convert';
import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:intl/intl.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static Future<String?> selectLibrary() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      return selectedDirectory;
    }
    return null;
  }

  static Future<FilePickerResult?> selectFile() async {
    var selectedFiles = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt']);

    // if (selectedDirectory != null) {
    //   return selectedDirectory;
    // }
    // return null;
    return selectedFiles;
  }

  static Future<List<FileSystemEntity>> getLibraryList(String path) async {
    await Permission.storage.request();
    Directory dir = Directory(path);
    print(path);
    var listDir = await dir.list().toList();
    print(listDir);
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

  static Future<String?> loadUserData() async {
    SharedPreferences prefs = await _prefs;
    prefs.reload();
    return prefs.getString("userdata");
  }

  static Future<void> setUserData(strjson) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString("userdata", strjson);
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove("userdata");
  }

  static Future<String?> loadLastData() async {
    SharedPreferences prefs = await _prefs;
    prefs.reload();
    return prefs.getString("lastdata");
  }

  static Future<void> setLastData(strjson) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString("lastdata", strjson);
  }

  static Future<void> clearLastData() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove("lastdata");
  }

  static Future<String?> loadCurrentData() async {
    SharedPreferences prefs = await _prefs;
    prefs.reload();
    return prefs.getString("currentdata");
  }

  static Future setCurrentData(strjson) async {
    SharedPreferences prefs = await _prefs;
    prefs.reload();
    prefs.setString("currentdata", strjson);
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

  // 기존 데이터 마이그레이션을 위해 한동안 유지후 삭제 해야함.
  static Future<bool> isLocalStorage() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    File f = File(appdir.path + "/opentextview");
    return f.existsSync();
  }

  static Future<String> getLocalStorage() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    File f = File(appdir.path + "/opentextview");
    return f.readAsStringSync();
  }

  static Future<void> delLocalStorage() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    File f = File(appdir.path + "/opentextview");
    f.deleteSync();
  }

  static Future<UserData?> localStorageToUserData() async {
    if (await Utils.isLocalStorage()) {
      String strlocaljson = await Utils.getLocalStorage();
      dynamic localjson = json.decode(strlocaljson);
      UserData tmpuserData = UserData();
      if (localjson['config'] != null) {
        if (localjson['config']['tts'] != null) {
          tmpuserData.tts = Tts.fromMap(localjson['config']['tts']);
        }
        if (localjson['config']['filter'] != null) {
          tmpuserData.filter = (localjson['config']['filter'] as List)
              .map((e) => Filter.fromMap(e))
              .toList();
        }
        if (localjson['config']['ocr'] != null) {
          tmpuserData.ocr = Ocr.fromMap(localjson['config']['ocr']);
        }
      }
      if (localjson['history'] != null) {
        tmpuserData.history = (localjson['history'] as List)
            .map((e) => History.fromMap(e))
            .toList();
      }
      return tmpuserData;
    }
    return null;
  }
}
