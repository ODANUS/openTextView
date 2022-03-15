import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/storagetransfer/v1.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class FilterBox {
  FilterBox({
    this.id = 0,
    this.name = "",
    this.filter = "",
    this.to = "",
    this.expr = false,
    this.enable = true,
  });
  int id;
  String name;
  bool expr;
  String filter;
  String to;
  bool enable;
  factory FilterBox.fromJson(String str) => FilterBox.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterBox.fromMap(Map<String, dynamic> json) => FilterBox(
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

@Entity()
class SettingBox {
  SettingBox({
    this.id = 0,
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
  int id;
  int fontSize;
  int fontWeight;
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

  factory SettingBox.fromJson(String str) =>
      SettingBox.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingBox.fromMap(Map<String, dynamic> json) {
    return SettingBox(
      fontSize: json["fontSize"] ?? 14,
      fontWeight: json["fontWeight"] ?? 3,
      fontFamily: json["fontFamily"] ?? "",
      fontHeight: json["fontHeight"] ?? 1.4,
      letterSpacing: json["letterSpacing"] ?? 0,
      customFont: json["customFont"] ?? null,
      speechRate:
          json["speechRate"] == null ? 1 : json["speechRate"].toDouble(),
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

@Entity()
class HistoryBox {
  HistoryBox({
    this.id = 0,
    DateTime? date,
    this.pos = 0,
    this.name = "",
    this.length = 0,
    this.customName = "",
    this.imageUri = "",
    this.searchKeyWord = "",
    this.contentsLen = 0,
    this.memo = "",
  }) : this.date = date ?? DateTime.now();

  int id;
  @Unique()
  String name;

  DateTime date;

  int pos;
  int length;
  int contentsLen;
  String customName;
  String imageUri;
  String searchKeyWord;
  String memo;

  factory HistoryBox.fromJson(String str) =>
      HistoryBox.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryBox.fromMap(Map<String, dynamic> json) => HistoryBox(
        id: json["id"] ?? 0,
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(json["date"]),
        pos: json["pos"] ?? 0,
        length: json["length"] ?? 0,
        name: json["name"] ?? "",
        customName: json["customName"] ?? "",
        imageUri: json["imageUri"] ?? "",
        contentsLen: json["contentsLen"] ?? 0,
        memo: json["memo"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
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
