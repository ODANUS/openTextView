import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:open_textview/component/comp_text_reader.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:open_textview/objectbox.g.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';

// Isar? isarIsolate;
// String dbPath = "";
// void isolateFunction(int idx) async {
//   if (isarIsolate == null) {
//     isarIsolate = Isar.openSync(schemas: [FilterIsarSchema, ContentsIsarSchema, WordCacheSchema, SettingIsarSchema, HistoryIsarSchema], directory: dbPath);
//   }
//   isarIsolate?.writeTxn((isar) async {
//     var curHistory = await isar.historyIsars.where().sortByDateDesc().findFirst();
//     if (curHistory != null) {
//       curHistory.cntntPstn = idx;
//       curHistory.date = DateTime.now();
//       isar.historyIsars.put(curHistory);
//     }
//   });
// }

class IsarCtl {
  static final List<String> listFont = [
    'default',
    "NanumGothic",
    "OpenSans",
    "ReadexPro",
    "Roboto",
    "NanumMyeongjo",
  ];
  // IsarCtl._privateConstructor();
  // static final IsarCtl _instance = IsarCtl._privateConstructor();
  // static IsarCtl get instance => _instance;
  // static ScrollController scrollctl = ScrollController();
  static TextViewerController tctl = TextViewerController();

  static Rx<String> fileName = "".obs;
  static Rx<double> scrollOffset = 1.0.obs;
  // static RxList<String> contents = RxList<String>();
  // static RxList<double> contentSizes = RxList<double>();

  static RxBool bhideFloatingScreen = false.obs;
  static RxBool bSetting = false.obs;
  static RxInt tabIndex = 0.obs;
  static RxBool bfullScreen = false.obs;

  // static RxDouble maxHeight = RxDouble(0);

  static RxBool bConvLoading = false.obs;
  static RxBool enableVolumeButton = false.obs;
  // static RxBool bImageFullScreen = false.obs;
  // static RxBool bTowDrage = false.obs;

  static late Isar isar;
  static final Map<int, GlobalKey> keys = {};
  // static final scrollController = ScrollController();
  // static final carouselController = CarouselController();

  // static RxBool bOpen = false.obs;

  static Future<void> init() async {
    await initData();
  }

  static Future<void> initData() async {
    var dir = await getApplicationSupportDirectory();
    // dbPath = dir.path;
    isar = Isar.openSync(schemas: [FilterIsarSchema, ContentsIsarSchema, WordCacheSchema, SettingIsarSchema, HistoryIsarSchema], directory: dir.path);

    // isar.writeTxnSync((isar) => isar.contentsIsars.clearSync());
    // isar.writeTxnSync((isar) => isar.filterIsars.clearSync());
    // isar.writeTxnSync((isar) => isar.historyIsars.clearSync());
    // isar.writeTxnSync((isar) => isar.settingIsars.clearSync());

    // LocalSettingIsar? localSettingIsar =
    //     isar.localSettingIsars.where().findFirstSync();
    // if (localSettingIsar == null) {
    //   isar.writeTxnSync((isar) {
    //     isar.localSettingIsars.putSync(LocalSettingIsar());
    //   });
    // }
    SettingIsar? settingIsar = isar.settingIsars.where().findFirstSync();
    List<HistoryIsar> historys = isar.historyIsars.where().findAllSync();
    if (settingIsar == null || historys.isEmpty) {
      var store = await openStore();
      var settingbox = store.box<SettingBox>();
      var filterbox = store.box<FilterBox>();
      var historyBox = store.box<HistoryBox>();

      var tmps = settingbox.getAll().map((e) => SettingIsar.fromMap(e.toMap())).toList();
      var tmpf = filterbox.getAll().map((e) => FilterIsar.fromMap(e.toMap())).toList();
      var tmph = historyBox.getAll().map((e) => HistoryIsar.fromMap(e.toMap())).toList();
      if (tmps.isNotEmpty) {
        try {
          isar.writeTxnSync((isar) {
            isar.settingIsars.putAllSync(tmps);
            isar.filterIsars.putAllSync(tmpf);
            isar.historyIsars.putAllSync(tmph);
          });
        } catch (e) {}
      } else {
        isar.writeTxnSync((isar) {
          isar.settingIsars.putSync(SettingIsar());
        });
      }
      store.close();
      settingIsar = isar.settingIsars.where().findFirstSync();
    }
    if (settingIsar != null) {
      if (settingIsar.theme == "light") {
        Get.changeTheme(ThemeData.light());
      }
      if (settingIsar.theme == "dark") {
        Get.changeTheme(ThemeData.dark());
      }
    }
    // var historyst = isar.historyIsars.where().findAllSync();
    // print(historyst.length);
    // historys.forEach((e) {
    //   if (e.cntntPstn < 0) {
    //     if (e.contentsLen <= 0) {
    //       e.cntntPstn = 0;
    //     } else {
    //       print(e.toJson());
    //     }
    //   }
    // });

    // Worker? w;
    // Future.delayed(Duration(milliseconds: 400), () async {
    //   Get.dialog(AlertDialog(
    //       content: TextField(
    //     keyboardType: TextInputType.number,
    //     autofocus: true,
    //   )));
    //   await Future.delayed(50.milliseconds);
    //   Get.back();
    // });
    // w = ever(bfullScreen, (bool b) async {});
    HardwareKeyboard.instance.removeHandler(volumeControll);
    HardwareKeyboard.instance.addHandler(volumeControll);

    // WidgetsBinding.instance!.addObserver(IsarCtl());
  }

  // [*] ----- GET SET ----- [*]
  static double get screenContensHeight {
    var s = isar.settingIsars.where().findFirstSync();
    if (s == null) return (650 - kToolbarHeight);
    return (650 - kToolbarHeight - s.paddingTop - s.paddingBottom).h;
  }

  static double get screenContensWidth {
    var s = isar.settingIsars.where().findFirstSync();
    if (s == null) return (360);
    return (360 - s.paddingLeft - s.paddingRight).w;
  }

  static ContentsIsar get contents {
    return IsarCtl.isar.contentsIsars.where().findFirstSync() ?? ContentsIsar(text: "");
  }

  static set contents(ContentsIsar contents) {
    isar.writeTxnSync((isar) {
      isar.contentsIsars.clearSync();
      isar.contentsIsars.putSync(contents);
    });
  }

  // static Map<int, WordCache> get getWordCache {
  static List<WordCache> get wordCache {
    return isar.wordCaches.where().findAllSync();
  }

  static HistoryIsar? get lastHistory {
    return isar.historyIsars.where().sortByDateDesc().findFirstSync();
  }

  static HistoryIsar? historyByName(String name) {
    return isar.historyIsars.filter().nameEqualTo(name).findFirstSync();
  }

  static List<HistoryIsar> historyListByName(String name) {
    if (name.isEmpty) {
      return isar.historyIsars.where().findAllSync();
    }
    return isar.historyIsars.filter().nameContains(name).findAllSync();
  }

  static set lastHistory(HistoryIsar? history) {
    if (history != null) {
      isar.writeTxnSync((isar) => isar.historyIsars.putSync(history));
    }
  }

  static List<HistoryIsar> get historys {
    return isar.historyIsars.where().findAllSync();
  }

  static set historys(List<HistoryIsar> list) {
    isar.writeTxnSync((isar) => isar.historyIsars.putAllSync(list));
  }

  static List<FilterIsar> get filters {
    return isar.filterIsars.where().findAllSync();
  }

  static SettingIsar? get setting {
    return isar.settingIsars.where().findFirstSync();
  }

  static int get cntntPstn {
    return lastHistory?.cntntPstn ?? 0;
  }

  static set cntntPstn(int idx) {
    HistoryIsar? tmp = lastHistory;
    print(tmp);
    tmp?.cntntPstn = idx;
    tmp?.date = DateTime.now();
    lastHistory = tmp;
  }

  static cntntPstnAsync(int idx) async {
    isar.historyIsars.where().sortByDateDesc().findFirst().then((curHistory) {
      if (curHistory != null) {
        curHistory.cntntPstn = idx;
        curHistory.date = DateTime.now();
        isar.writeTxn((isar) async {
          isar.historyIsars.put(curHistory);
        });
      }
    });
    // Isolate.spawn(isolateFunction, idx);

    // HistoryIsar? tmp = lastHistory;
    // tmp?.cntntPstn = idx;
    // tmp?.date = DateTime.now();
    // lastHistory = tmp;
  }

  // static void isolateFunction(int idx) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   var dir = await getApplicationSupportDirectory();
  //   var isar = Isar.openSync(schemas: [FilterIsarSchema, ContentsIsarSchema, WordCacheSchema, SettingIsarSchema, HistoryIsarSchema], directory: dir.path);
  //   isar.writeTxn((isar) async {
  //     var curHistory = await isar.historyIsars.where().sortByDateDesc().findFirst();
  //     // if (curHistory != null) {
  //     //   curHistory.cntntPstn = idx;
  //     //   curHistory.date = DateTime.now();
  //     //   isar.historyIsars.put(curHistory);
  //     // }
  //   });
  // }

  // static int get pos {
  //   return lastHistory?.pos ?? 0;
  // }

  // static set pos(int idx) {
  //   HistoryIsar? tmp = lastHistory;
  //   tmp?.pos = idx;
  //   tmp?.date = DateTime.now();
  //   lastHistory = tmp;
  // }

  static TextStyle get textStyle {
    SettingIsar? s = isar.settingIsars.where().findFirstSync();
    int? c = s?.fontColor;
    if (c == null || c == 0) {
      c = Get.isDarkMode ? 0xFFFFFFFF : 0xFF000000;
    }
    return TextStyle(
      fontFamily: s?.fontFamily,
      fontSize: s?.fontSize ?? 14,
      fontWeight: FontWeight.values[s?.fontWeight ?? 3],
      height: s?.fontHeight ?? 1.4,
      letterSpacing: s?.letterSpacing ?? 0,
      color: Color(c),
    );
  }

  static TextPainter getPainter(String c, TextStyle style, double width) {
    return TextPainter(
      text: TextSpan(text: c, style: style),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout(maxWidth: screenContensWidth);
  }

  // [*] ----- GET SET ----- [*]

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   // appLifecycleState(state);
  //   // if (appLifecycleState.value == AppLifecycleState.inactive ||
  //   //     appLifecycleState.value == AppLifecycleState.resumed) {
  //   //   if (itemScrollctl.isAttached) {
  //   //     // itemScrollctl.jumpTo(index: currentHistory.value.pos);
  //   //   }
  //   // }
  // }

  static bool volumeControll(KeyEvent event) {
    bool result = false;
    if (event is KeyDownEvent && tabIndex.value == 0 && bfullScreen.value) {
      if (event.logicalKey == LogicalKeyboardKey.audioVolumeUp && !result && !AudioPlay.audioHandler!.playbackState.stream.value.playing) {
        result = true;
        tctl.back();
      }
      if (event.logicalKey == LogicalKeyboardKey.audioVolumeDown && bfullScreen.value) {
        result = true;
        tctl.next();
      }
    }
    return result;
  }
  // rxSetting {

  // }
  // static Widget rxSetting(Widget Function(BuildContext, SettingIsar) builder) =>
  //     RxSetting(builder: builder);

  // static Widget rxLocalSetting(
  //         Widget Function(BuildContext, LocalSettingIsar) builder) =>
  //     RxLocalSetting(builder: builder);

  static Stream<List<SettingIsar>> get streamSetting {
    return isar.settingIsars.where().build().watch(initialReturn: true);
  }

  static Stream<List<ContentsIsar>> get streamContents {
    return isar.contentsIsars.where().build().watch(initialReturn: true);
  }

  static Stream<List<HistoryIsar>> get streamHistory {
    return isar.historyIsars.where().build().watch(initialReturn: true);
  }

  static Stream<List<HistoryIsar>> get streamLastHistory {
    return isar.historyIsars.where().sortByDateDesc().build().watch(initialReturn: true);
  }

  static Stream<List<FilterIsar>> get streamFilter {
    return isar.filterIsars.where().build().watch(initialReturn: true);
  }

  // static Stream<List<LocalSettingIsar>> get streamLocalSetting {
  //   return isar.localSettingIsars.where().build().watch(initialReturn: true);
  //   // var f = isar.localSettingIsars.where().findFirstSync();
  //   // return isar.localSettingIsars.watchObject(f!.id,
  //   //     initialReturn: true); //.build().watch(initialReturn: true);
  // }
  static StreamBuilder<List<HistoryIsar>> rxLastHistory(Widget Function(BuildContext, HistoryIsar) builder) {
    return StreamBuilder<List<HistoryIsar>>(
        stream: streamLastHistory,
        builder: ((context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return builder(context, snapshot.data!.first);
          }
          return SizedBox();
        }));
  }

  static StreamBuilder<List<HistoryIsar>> rxHistory(Widget Function(BuildContext, List<HistoryIsar>) builder) {
    return StreamBuilder<List<HistoryIsar>>(
        stream: streamHistory,
        builder: ((context, snapshot) {
          if (snapshot.data != null) {
            return builder(context, snapshot.data!);
          }
          return SizedBox();
        }));
  }

  static StreamBuilder<List<SettingIsar>> rxSetting(Widget Function(BuildContext, SettingIsar) builder) {
    return StreamBuilder<List<SettingIsar>>(
        stream: streamSetting,
        builder: ((context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return builder(context, snapshot.data!.first);
          }
          return SizedBox();
        }));
  }

  static StreamBuilder<List<ContentsIsar>> rxContents(Widget Function(BuildContext, ContentsIsar) builder) {
    return StreamBuilder<List<ContentsIsar>>(
        stream: streamContents,
        builder: ((context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return builder(context, snapshot.data!.first);
          }
          return SizedBox();
        }));
  }

  static StreamBuilder<List<FilterIsar>> rxFilter(Widget Function(BuildContext, List<FilterIsar>) builder) {
    return StreamBuilder<List<FilterIsar>>(
        stream: streamFilter,
        builder: ((context, snapshot) {
          if (snapshot.data != null) {
            return builder(context, snapshot.data!);
          }
          return SizedBox();
        }));
  }

  // static StreamBuilder<List<LocalSettingIsar>> rxLocalSetting(
  //     Widget Function(BuildContext, LocalSettingIsar) builder) {
  //   return StreamBuilder<List<LocalSettingIsar>>(
  //       stream: streamLocalSetting,
  //       builder: ((context, snapshot) {
  //         print("------------");
  //         if (snapshot.data != null && snapshot.data!.isNotEmpty) {
  //           return builder(context, snapshot.data!.first);
  //         }
  //         return SizedBox();
  //       }));
  // }

  // static putLocalSetting(LocalSettingIsar v) {
  //   print(DateTime.now());
  //   isar.writeTxnSync((isar) {
  //     isar.localSettingIsars.putSync(v);
  //   });
  //   print(DateTime.now());
  // }
  static setHistory(List<HistoryIsar> v) {
    isar.writeTxnSync((isar) {
      isar.historyIsars.clearSync();
      isar.historyIsars.putAllSync(v);
    });
  }

  static putHistory(HistoryIsar v) {
    isar.writeTxnSync((isar) {
      isar.historyIsars.putSync(v);
    });
  }

  static deleteHistory(HistoryIsar v) {
    isar.writeTxnSync((isar) {
      isar.historyIsars.deleteSync(v.id);
    });
  }

  static setSetting(SettingIsar v) {
    isar.writeTxnSync((isar) {
      isar.settingIsars.clearSync();
      isar.settingIsars.putSync(v);
    });
    if (setting != null) {
      if (setting!.theme == "dark") {
        Get.changeTheme(ThemeData.dark());
      }
      if (setting!.theme == "light") {
        Get.changeTheme(ThemeData.light());
      }
    }
  }

  static putSetting(SettingIsar v) {
    isar.writeTxnSync((isar) {
      isar.settingIsars.putSync(v);
    });
  }

  static setFilter(List<FilterIsar> v) {
    isar.writeTxnSync((isar) {
      isar.filterIsars.clearSync();
      isar.filterIsars.putAllSync(v);
    });
  }

  static void putFilter(FilterIsar v) {
    isar.writeTxnSync((isar) {
      isar.filterIsars.putSync(v);
    });
  }

  static deleteFilter(FilterIsar v) {
    isar.writeTxnSync((isar) {
      isar.filterIsars.deleteSync(v.id);
    });
  }

  static void resetHistory() {
    isar.writeTxnSync((isar) {
      isar.historyIsars.clearSync();
      isar.contentsIsars.clearSync();
    });
  }

  static void resetSetting() {
    isar.writeTxnSync((isar) {
      isar.settingIsars.clearSync();
      isar.settingIsars.putSync(SettingIsar());
    });
  }

  static void resetFilter() {
    isar.writeTxnSync((isar) {
      isar.filterIsars.clearSync();
    });
  }

  static Map<String, dynamic> data2Map() {
    return {
      "historys": historys.map((e) => e.toMap()).toList(),
      "filters": filters.map((e) => e.toMap()).toList(),
      "setting": setting!.toMap(),
    };
  }

  static map2Data(Map<String, dynamic> jsonData) {
    var his = (jsonData["historys"] as List).map((e) => HistoryIsar.fromMap(e)).toList();
    var filters = (jsonData["filters"] as List).map((e) => FilterIsar.fromMap(e)).toList();
    var setting = SettingIsar.fromMap(jsonData["setting"]);

    setHistory(his);
    setFilter(filters);
    setSetting(setting);
  }

  static map2Box(Map<String, dynamic> jsonData) async {
    var store = await openStore();
    var settingbox = store.box<SettingBox>();
    var filterbox = store.box<FilterBox>();
    var historybox = store.box<HistoryBox>();
    var his = (jsonData["historys"] as List).map((e) => HistoryBox.fromMap(e)..id = 0).toList();
    var filters = (jsonData["filters"] as List).map((e) => FilterBox.fromMap(e)..id = 0).toList();
    var setting = SettingBox.fromMap(jsonData["setting"])..id = 0;

    historybox.removeAll();
    historybox.putMany(his);
    filterbox.removeAll();
    filterbox.putMany(filters);
    settingbox.removeAll();
    settingbox.put(setting);
    store.close();
  }

  static openFile(File f) async {
    AudioPlay.stop();
    f.setLastAccessedSync(DateTime.now());
    var tmpName = f.path.split("/").last;

    String tmpStr = await Utils.readFile(f);
    var tmpcontents = tmpStr.replaceAll(RegExp(r'\n{3,}'), "\n");
    tmpcontents = tmpcontents.replaceAll("\r\n", "\n");

    ContentsIsar contentsisar = ContentsIsar(text: tmpcontents);

    // List<ContentsIsar> contentsList = targetList.asMap().map((k, e) => MapEntry(k, ContentsIsar(idx: k, text: e))).values.toList();

    var history = isar.historyIsars.filter().nameEqualTo(tmpName).findFirstSync();

    if (history == null) {
      lastHistory = HistoryIsar(
        name: tmpName,
        date: DateTime.now(),
        contentsLen: tmpcontents.length,
        pos: 0,
        cntntPstn: 0,
      );
    } else {
      if (history.cntntPstn <= 0 && history.pos > 0) {
        var targetList = tmpcontents.split("\n");
        if (targetList.length > history.pos) {
          var range = targetList.getRange(0, history.pos + 1);
          history.cntntPstn = range.join("\n").length;
        }
      }

      history.date = DateTime.now();
      history.contentsLen = tmpcontents.length;
      lastHistory = history;
    }

    contents = contentsisar;

    tabIndex(0);
    // bOpen(false);
  }
}
