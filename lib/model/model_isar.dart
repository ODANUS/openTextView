import 'dart:convert';

import 'package:isar/isar.dart';

part 'model_isar.g.dart';

@Collection()
class FilterIsar {
  FilterIsar({
    this.name = "",
    this.filter = "",
    this.to = "",
    this.expr = false,
    this.enable = true,
  });
  int id = Isar.autoIncrement;
  String name;
  bool expr;
  String filter;
  String to;
  bool enable;
  factory FilterIsar.fromJson(String str) => FilterIsar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterIsar.fromMap(Map<String, dynamic> json) => FilterIsar(
        name: json["name"] ?? "",
        filter: json["filter"] ?? "",
        to: json["to"] ?? "",
        expr: json["expr"] ?? false,
        enable: json["enable"] ?? true,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "expr": expr,
        "filter": filter,
        "to": to,
        "enable": enable,
      };
}

// @Collection()
// class LocalSettingIsar {
//   int id = Isar.autoIncrement;
//   String fileName = "";
//   List<String> contents = [];
//   List<double> contentSizes = [];
//   int pos = 0;
//   bool bfullScreen = false;
//   int tabIndex = 1;
//   bool bConvLoading = false;
//   bool bScreenHelp = false;
//   bool firstFullScreen = false;
//   bool bImageFullScreen = false;
//   bool bTowDrage = false;
// }
@Collection()
class WordCache {
  WordCache({
    required this.id,
    required this.width,
    required this.height,
  });
  int id;
  double width;
  double height;
}

@Collection()
class ContentsIsar {
  ContentsIsar({
    this.idx = 0,
    this.height = 0,
    this.pageIdx = 0,
    this.fullPageIdx = 0,
    this.text = "",
  });
  int id = Isar.autoIncrement;
  int idx = 0;
  int pageIdx = 0;
  int fullPageIdx = 0;
  double height = 0;
  String text;
  factory ContentsIsar.fromJson(String str) => ContentsIsar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentsIsar.fromMap(Map<String, dynamic> json) {
    return ContentsIsar(
      idx: json["idx"] ?? 0,
      pageIdx: json["pageIdx"] ?? 0,
      fullPageIdx: json["fullPageIdx"] ?? 0,
      height: json["height"] ?? 0,
      text: json["text"] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
        "idx": idx,
        "pageIdx": pageIdx,
        "fullPageIdx": fullPageIdx,
        "height": height,
        "text": text,
      };
}

@Collection()
class SettingIsar {
  SettingIsar({
    this.fontSize = 14,
    this.fontWeight = 3,
    this.fontFamily = "",
    this.customFont,
    this.fontHeight = 1.4,
    this.letterSpacing = 0,
    this.speechRate = 1,
    this.volume = 1.0,
    this.pitch = 1.0,
    this.groupcnt = 5,
    this.headsetbutton = false,
    this.audiosession = true,
    this.audioduck = true,
    this.touchLayout = 0,
    this.useClipboard = true,
    this.enablescroll = false,
    this.theme = "light",
    this.lastDevVersion = "",
    this.backgroundColor = 0x00FFFFFF,
    this.fontColor = 0,
    this.paddingLeft = 10,
    this.paddingRight = 10,
    this.paddingTop = 10,
    this.paddingBottom = 10,
  });
  int id = Isar.autoIncrement;
  int fontWeight;
  double fontSize;
  String fontFamily;
  String? customFont;
  double fontHeight;
  double letterSpacing;
  double speechRate;
  double volume;
  double pitch;
  int groupcnt;
  int touchLayout;
  String theme;
  bool useClipboard;
  bool headsetbutton;
  bool enablescroll;
  bool audiosession;
  bool audioduck;
  String lastDevVersion;
  int backgroundColor = 0x00FFFFFF;
  int fontColor;
  double paddingLeft = 10;
  double paddingRight = 10;
  double paddingTop = 10;
  double paddingBottom = 10;

  factory SettingIsar.fromJson(String str) => SettingIsar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingIsar.fromMap(Map<String, dynamic> json) {
    return SettingIsar(
      fontSize: json["fontSize"].toDouble() ?? 14,
      fontWeight: json["fontWeight"] ?? 3,
      fontFamily: json["fontFamily"] ?? "",
      fontHeight: json["fontHeight"] ?? 1.4,
      letterSpacing: json["letterSpacing"] ?? 0,
      customFont: json["customFont"] ?? null,
      speechRate: json["speechRate"] == null ? 1 : json["speechRate"].toDouble(),
      volume: json["volume"] ?? 1,
      pitch: json["pitch"] ?? 1.0,
      groupcnt: json["groupcnt"] ?? 5,
      theme: json["theme"] ?? "light",
      headsetbutton: json["headsetbutton"] ?? false,
      enablescroll: json["enablescroll"] ?? false,
      audiosession: json["audiosession"] ?? true,
      audioduck: json["audioduck"] ?? true,
      touchLayout: json["touchLayout"] ?? 0,
      useClipboard: json["useClipboard"] ?? true,
      lastDevVersion: json["lastDevVersion"] ?? "",
      backgroundColor: json["backgroundColor"] ?? 0x00FFFFFF,
      fontColor: json["fontColor"] ?? 0,
      paddingLeft: json["paddingLeft"] ?? 10,
      paddingRight: json["paddingRight"] ?? 10,
      paddingTop: json["paddingTop"] ?? 10,
      paddingBottom: json["paddingBottom"] ?? 10,
    );
  }

  Map<String, dynamic> toMap() => {
        "customFont": customFont,
        "fontSize": fontSize,
        "fontWeight": fontWeight,
        "fontFamily": fontFamily,
        "fontHeight": fontHeight,
        "letterSpacing": letterSpacing,
        "speechRate": speechRate,
        "volume": volume,
        "pitch": pitch,
        "groupcnt": groupcnt,
        "headsetbutton": headsetbutton,
        "enablescroll": enablescroll,
        "audiosession": audiosession,
        "audioduck": audioduck,
        "touchLayout": touchLayout,
        "useClipboard": useClipboard,
        "lastDevVersion": lastDevVersion,
        "theme": theme,
        "backgroundColor": backgroundColor,
        "fontColor": fontColor,
        "paddingLeft": paddingLeft,
        "paddingRight": paddingRight,
        "paddingTop": paddingTop,
        "paddingBottom": paddingBottom,
      };
}

@Collection()
class HistoryIsar {
  HistoryIsar({
    required this.date,
    this.pos = 0,
    this.name = "",
    this.length = 0,
    this.customName = "",
    this.imageUri = "",
    this.searchKeyWord = "",
    this.contentsLen = 0,
    this.memo = "",
  });

  int id = Isar.autoIncrement;
  String name;

  DateTime date;

  int pos;
  int length;
  int contentsLen;
  String customName;
  String imageUri;
  String searchKeyWord;
  String memo;

  factory HistoryIsar.fromJson(String str) => HistoryIsar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryIsar.fromMap(Map<String, dynamic> json) => HistoryIsar(
        date: json["date"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["date"]),
        pos: json["pos"] ?? 0,
        length: json["length"] ?? 0,
        name: json["name"] ?? "",
        customName: json["customName"] ?? "",
        imageUri: json["imageUri"] ?? "",
        contentsLen: json["contentsLen"] ?? 0,
        memo: json["memo"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "date": date.millisecondsSinceEpoch,
        "pos": pos,
        "length": length,
        "name": name,
        "customName": customName,
        "imageUri": imageUri,
        "contentsLen": contentsLen,
        "memo": memo,
      };
}
