class UserData {
  Config? config;
  List<History>? history;

  UserData({this.config, this.history});

  UserData.fromJson(Map<String, dynamic> json) {
    this.config =
        json["config"] == null ? null : Config.fromJson(json["config"]);
    this.history = json["history"] == null
        ? null
        : (json["history"] as List).map((e) => History.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) data["config"] = this.config?.toJson();
    if (this.history != null)
      data["history"] = this.history?.map((e) => e.toJson()).toList();
    return data;
  }
}

class History {
  String? date;
  int? pos;
  String? name;

  History({this.date, this.pos, this.name});

  History.fromJson(Map<String, dynamic> json) {
    this.date = json["date"];
    this.pos = json["pos"];
    this.name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["date"] = this.date;
    data["pos"] = this.pos;
    data["name"] = this.name;
    return data;
  }
}

class Config {
  List<int>? theme;
  Tts? tts;
  List<Filter>? filter;
  List<String>? nav;
  Picker? picker;
  Ocr? ocr;

  Config({this.theme, this.tts, this.filter, this.nav, this.picker, this.ocr});

  Config.fromJson(Map<String, dynamic> json) {
    this.theme = json["theme"] == null ? null : List<int>.from(json["theme"]);
    this.tts = json["tts"] == null ? null : Tts.fromJson(json["tts"]);
    this.filter = json["filter"] == null
        ? null
        : (json["filter"] as List).map((e) => Filter.fromJson(e)).toList();
    this.nav = json["nav"] == null ? null : List<String>.from(json["nav"]);
    this.picker =
        json["picker"] == null ? null : Picker.fromJson(json["picker"]);
    this.ocr = json["ocr"] == null ? null : Ocr.fromJson(json["ocr"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.theme != null) data["theme"] = this.theme;
    if (this.tts != null) data["tts"] = this.tts?.toJson();
    if (this.filter != null)
      data["filter"] = this.filter?.map((e) => e.toJson()).toList();
    if (this.nav != null) data["nav"] = this.nav;
    if (this.picker != null) data["picker"] = this.picker?.toJson();
    if (this.ocr != null) data["ocr"] = this.ocr?.toJson();
    return data;
  }
}

class Ocr {
  String? path;
  List<String>? lang;

  Ocr({this.path, this.lang});

  Ocr.fromJson(Map<String, dynamic> json) {
    this.path = json["path"];
    this.lang = json["lang"] == null ? null : List<String>.from(json["lang"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["path"] = this.path;
    if (this.lang != null) data["lang"] = this.lang;
    return data;
  }
}

class Picker {
  String? name;
  dynamic? bytes;
  int? size;
  String? extension;
  String? path;

  Picker({this.name, this.bytes, this.size, this.extension, this.path});

  Picker.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.bytes = json["bytes"];
    this.size = json["size"];
    this.extension = json["extension"];
    this.path = json["path"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["bytes"] = this.bytes;
    data["size"] = this.size;
    data["extension"] = this.extension;
    data["path"] = this.path;
    return data;
  }
}

class Filter {
  String? name;
  bool? expr;
  String? filter;
  String? to;
  bool? enable;

  Filter({this.name, this.expr, this.filter, this.to, this.enable});

  Filter.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.expr = json["expr"];
    this.filter = json["filter"];
    this.to = json["to"];
    this.enable = json["enable"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["expr"] = this.expr;
    data["filter"] = this.filter;
    data["to"] = this.to;
    data["enable"] = this.enable;
    return data;
  }
}

class Tts {
  double? speechRate;
  int? volume;
  int? pitch;
  int? groupcnt;
  bool? headsetbutton;
  bool? audiosession;

  Tts(
      {this.speechRate,
      this.volume,
      this.pitch,
      this.groupcnt,
      this.headsetbutton,
      this.audiosession});

  Tts.fromJson(Map<String, dynamic> json) {
    this.speechRate = json["speechRate"];
    this.volume = json["volume"];
    this.pitch = json["pitch"];
    this.groupcnt = json["groupcnt"];
    this.headsetbutton = json["headsetbutton"];
    this.audiosession = json["audiosession"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["speechRate"] = this.speechRate;
    data["volume"] = this.volume;
    data["pitch"] = this.pitch;
    data["groupcnt"] = this.groupcnt;
    data["headsetbutton"] = this.headsetbutton;
    data["audiosession"] = this.audiosession;
    return data;
  }
}
