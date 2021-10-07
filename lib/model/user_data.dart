import 'dart:convert';

import 'package:flutter/material.dart';

class UserData {
  UserData({
    this.theme = "light",
    this.filter = const [],
    this.history = const [],
  })  : tts = Tts(),
        ocr = Ocr(),
        ui = Ui();

  Tts tts;
  List<Filter> filter;
  Ocr ocr;
  List<History> history;
  String theme;
  Ui ui;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        filter: json["filter"] == null
            ? List<Filter>.from([])
            : List<Filter>.from(json["filter"].map((x) => Filter.fromMap(x))),
        history: json["history"] == null
            ? List<History>.from([History.fromMap({})])
            : List<History>.from(
                json["history"].map((x) => History.fromMap(x))),
        theme: json["theme"] == null ? "" : json["theme"],
      )
        ..tts = json["tts"] == null ? Tts() : Tts.fromMap(json["tts"])
        ..ocr = json["ocr"] == null ? Ocr() : Ocr.fromMap(json["ocr"])
        ..ui = json["ui"] == null ? Ui() : Ui.fromMap(json["ui"]);

  Map<String, dynamic> toMap() => {
        "tts": tts.toMap(),
        "filter": List<dynamic>.from(filter.map((x) => x.toMap())),
        "ocr": ocr.toMap(),
        "history": List<dynamic>.from(history.map((x) => x.toMap())),
        "theme": theme,
        "ui": ui.toMap(),
      };
}

class Filter {
  Filter({
    this.name = "",
    this.filter = "",
    this.to = "",
    this.expr = false,
    this.enable = true,
  });

  String name;
  bool expr;
  String filter;
  String to;
  bool enable;

  factory Filter.fromJson(String str) => Filter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic> json) => Filter(
        name: json["name"] == null ? null : json["name"],
        expr: json["expr"] == null ? null : json["expr"],
        filter: json["filter"] == null ? null : json["filter"],
        to: json["to"] == null ? null : json["to"],
        enable: json["enable"] == null ? null : json["enable"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "expr": expr,
        "filter": filter,
        "to": to,
        "enable": enable,
      };
}

class History {
  History({
    this.date = "",
    this.pos = 0,
    this.name = "",
    this.path = "",
  });

  String date;
  int pos;
  String name;
  String path;

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(
        date: json["date"] == null ? "" : json["date"],
        pos: json["pos"] == null ? 0 : json["pos"],
        name: json["name"] == null ? "" : json["name"],
        path: json["path"] == null ? "" : json["path"],
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "pos": pos,
        "name": name,
        "path": path,
      };
}

class Ocr {
  Ocr({
    this.lang = const [],
  });

  List<String> lang;

  factory Ocr.fromJson(String str) => Ocr.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ocr.fromMap(Map<String, dynamic> json) {
    return Ocr(
      lang: json["lang"] == null
          ? List<String>.from([])
          : List<String>.from(json["lang"].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() => {
        "lang": List<dynamic>.from(lang.map((x) => x)),
      };
}

class Tts {
  Tts({
    this.speechRate = 1,
    this.volume = 1.0,
    this.pitch = 1.0,
    this.groupcnt = 5,
    this.headsetbutton = false,
    this.audiosession = true,
  });

  double speechRate;
  double volume;
  double pitch;
  int groupcnt;
  bool headsetbutton;
  bool audiosession;

  factory Tts.fromJson(String str) => Tts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tts.fromMap(Map<String, dynamic> json) => Tts(
        speechRate:
            json["speechRate"] == null ? null : json["speechRate"].toDouble(),
        volume: json["volume"] == null ? null : json["volume"],
        pitch: json["pitch"] == null ? null : json["pitch"],
        groupcnt: json["groupcnt"] == null ? null : json["groupcnt"],
        headsetbutton:
            json["headsetbutton"] == null ? null : json["headsetbutton"],
        audiosession:
            json["audiosession"] == null ? null : json["audiosession"],
      );

  Map<String, dynamic> toMap() => {
        "speechRate": speechRate,
        "volume": volume,
        "pitch": pitch,
        "groupcnt": groupcnt,
        "headsetbutton": headsetbutton,
        "audiosession": audiosession,
      };
}

class Ui {
  Ui({
    this.fontSize = 12,
  });

  int fontSize;

  factory Ui.fromJson(String str) => Ui.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ui.fromMap(Map<String, dynamic> json) => Ui(
        fontSize: json["fontSize"] == null ? null : json["fontSize"],
      );

  Map<String, dynamic> toMap() => {
        "fontSize": fontSize == null ? null : fontSize,
      };
}
