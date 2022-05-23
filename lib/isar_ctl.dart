import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:open_textview/component/comp_text_reader.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/model/model_isar.dart';
// import 'package:open_textview/objectbox.g.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class IsarCtl {
  static final List<String> listFont = [
    'default',
    "NanumGothic",
    "OpenSans",
    "ReadexPro",
    "Roboto",
    "NanumMyeongjo",
    "BMDOHYEON",
    "BMEULJIRO",
    "KoPubBatang",
    'KoPubDotum',
    "MaruBuri",
    "NanumPen",
    "RIDIBatang",
  ];

  static final List<String> listBg = [
    "",
    "bg1.png",
    "bg2.png",
    "bg3.png",
    "bg4.png",
    "bg5.png",
    "bg6.png",
    "bg7.png",
    "bg8.png",
    "bg9.png",
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
  static RxBool btitleFullScreen = false.obs;

  // static RxDouble maxHeight = RxDouble(0);
  static RxInt unzipTotal = 0.obs;
  static RxInt unzipCurrent = 0.obs;
  static RxInt epubTotal = 0.obs;
  static RxInt epubCurrent = 0.obs;

  static RxBool bConvLoading = false.obs;
  static RxBool enableVolumeButton = false.obs;

  static Rx<Directory> libDir = Directory("").obs;
  static Rxn<Directory> libPDir = Rxn<Directory>();
  static RxString libSearchText = "".obs;
  static RxBool bLoadingLib = false.obs;
  static RxDouble lastVolume = 0.1.obs;

  static RxString curDragEx = "".obs;

  // static RxBool bImageFullScreen = false.obs;
  // static RxBool bTowDrage = false.obs;

  static late Isar isar;
  static final Map<int, GlobalKey> keys = {};

  // static RxInt asyncPos = 0.obs;
  static RxBool basyncOffset = false.obs;

  static const int MAXOCRCNT = 1000;

  static StreamSubscription? iosVolumeSub;

  static RxBool bScreenHelp = true.obs;

  static RxBool bRemoveAd = false.obs;

  static RxBool bLoadingSetting = false.obs;

  // static RxBool bOpen = false.obs;

  static Future<void> init() async {
    await initData();
  }

  static Future<void> initData() async {
    var dir = await getApplicationSupportDirectory();

    Directory tmpdir = await getTemporaryDirectory();
    String filePickerPath = "${tmpdir.path}/file_picker";
    if (Platform.isIOS) {
      filePickerPath = "${tmpdir.path}/com.khjde.openTextview-Inbox";
    }
    var tmpLibDir = Directory(filePickerPath);
    if (!tmpLibDir.existsSync()) {
      tmpLibDir.createSync();
    }
    libDir(tmpLibDir);
    // dbPath = dir.path;
    isar = Isar.openSync(schemas: [FilterIsarSchema, ContentsIsarSchema, WordCacheSchema, SettingIsarSchema, HistoryIsarSchema], directory: dir.path);

    SettingIsar? settingIsar = isar.settingIsars.where().findFirstSync();
    List<HistoryIsar> historys = isar.historyIsars.where().findAllSync();
    if (settingIsar == null || historys.isEmpty) {
      isar.writeTxnSync((isar) {
        isar.settingIsars.putSync(SettingIsar(speechRate: Platform.isAndroid ? 1 : 0.4, groupcnt: Platform.isAndroid ? 5 : 1));
      });
      settingIsar = isar.settingIsars.where().findFirstSync();
    }
    if (settingIsar != null) {
      var bInitValue = false;
      if (settingIsar.bgIdx < -999) {
        bInitValue = true;
        settingIsar.bgIdx = 0;
      }
      if (settingIsar.bgFilter < -999) {
        bInitValue = true;
        settingIsar.bgFilter = 0x00FFFFFF;
      }
      if (settingIsar.fullScreenType < -999) {
        bInitValue = true;
        settingIsar.fullScreenType = 0;
      }
      if (settingIsar.adPosition < -999) {
        bInitValue = true;
        settingIsar.adPosition = 0;
      }
      if (bInitValue) {
        putSetting(settingIsar);
      }

      var df = DateTime.now().difference(settingIsar.last24Ad);
      print(":::::::::::${df}");
      if (df.inHours < 24) {
        bRemoveAd(true);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (settingIsar != null) {
        if (settingIsar.theme == "light") {
          Get.changeTheme(ThemeData.light());
        }
        if (settingIsar.theme == "dark") {
          Get.changeTheme(ThemeData.dark());
        }
      }
    });
    // var historyst = isar.historyIsars.where().findAllSync();

    // historys.forEach((e) {
    //   if (e.cntntPstn < 0) {
    //     if (e.contentsLen <= 0) {
    //       e.cntntPstn = 0;
    //     } else {
    //
    //     }
    //   }
    // });
    debounce(basyncOffset, (bool b) {
      if (!b) {
        IsarCtl.lastHistory = IsarCtl.lastHistory!
          ..cntntPstn = tctl.cntntPstn
          ..date = DateTime.now();
      }
    }, time: 200.milliseconds);

    // debounce(asyncPos, (int v) {
    //   if (v >= 0) {
    //     IsarCtl.lastHistory = IsarCtl.lastHistory!
    //       ..cntntPstn = v
    //       ..date = DateTime.now();
    //   }
    // }, time: 400.milliseconds);
    if (Platform.isAndroid) {
      HardwareKeyboard.instance.removeHandler(volumeControll);
      HardwareKeyboard.instance.addHandler(volumeControll);
    }
    if (Platform.isIOS) {
      ever(bfullScreen, (bool v) async {
        if (v) {
          if (await PerfectVolumeControl.getVolume() == 0.0) {
            await PerfectVolumeControl.setVolume(0.3);
          }
          if (await PerfectVolumeControl.getVolume() == 1.0) {
            await PerfectVolumeControl.setVolume(0.7);
          }
          lastVolume(await PerfectVolumeControl.getVolume());
          PerfectVolumeControl.hideUI = true;
          iosVolumeSub = PerfectVolumeControl.stream.listen(volumeControllIOS);
        } else {
          PerfectVolumeControl.hideUI = false;
          iosVolumeSub?.cancel();
        }
      });
    }

    // libraryInit();
    // WidgetsBinding.instance!.addObserver(IsarCtl());
  }

  static void volumeControllIOS(double volume) async {
    if (volume < lastVolume.value) {
      tctl.next();
    }
    if (volume > lastVolume.value) {
      tctl.back();
    }
    await PerfectVolumeControl.setVolume(lastVolume.value);
  }

  static bool volumeControll(KeyEvent event) {
    bool result = false;
    if (event is KeyDownEvent && tabIndex.value == 0 && bfullScreen.value) {
      if (event.logicalKey == LogicalKeyboardKey.audioVolumeUp && !result && !AudioPlay.audioHandler!.playbackState.value.playing) {
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

  // static libraryInit() async {
  //   var dir = await getTemporaryDirectory();
  //   var library_root = Directory("${dir.path}/file_picker");

  //   var library_base = Directory("${dir.path}/file_picker/_base_");

  //   if (!library_base.existsSync()) {
  //     library_base.createSync();
  //   }
  //   var list = library_base.listSync();
  //   list.forEach((e) {
  //     if (e is File) {
  //       var fileName = e.path.split("/").last;
  //       e.renameSync('${library_root.path}/$fileName');
  //     }
  //   });
  // }

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

  static int? get cntntPstnNil {
    var last = lastHistory;
    return last?.cntntPstn;
  }

  static set cntntPstn(int idx) {
    HistoryIsar? tmp = lastHistory;
    tmp?.cntntPstn = idx;
    tmp?.date = DateTime.now();
    lastHistory = tmp;
  }

  // static bool debounce = false;
  // static cntntPstnAsync(int idx) async {
  //   asyncPos(idx);
  // }

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

  static TextStyle? get textStyle {
    SettingIsar? s = isar.settingIsars.where().findFirstSync();
    if (s == null) {
      return null;
    }
    int c = s.fontColor;
    if (c == 0) {
      c = Get.isDarkMode ? 0xFFFFFFFF : 0xFF000000;
    }
    return TextStyle(
      fontFamily: s.fontFamily,
      fontSize: s.fontSize,
      fontWeight: FontWeight.values[s.fontWeight],
      height: s.fontHeight,
      letterSpacing: s.letterSpacing,
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

  static Stream<List<HistoryIsar>> streamFilterHistory(DateTime startDate, DateTime endDate, String name) {
    return isar.historyIsars.where().filter().nameContains(name).and().dateBetween(startDate, endDate).watch(initialReturn: true);
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

  static StreamBuilder<List<HistoryIsar>> rxHistoryFilterDate(
      Widget Function(BuildContext, List<HistoryIsar>) builder, DateTime startDate, DateTime endDate, String name) {
    return StreamBuilder<List<HistoryIsar>>(
        stream: streamFilterHistory(startDate, endDate, name),
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

  // static map2Box(Map<String, dynamic> jsonData) async {
  //   var store = await openStore();
  //   var settingbox = store.box<SettingBox>();
  //   var filterbox = store.box<FilterBox>();
  //   var historybox = store.box<HistoryBox>();
  //   var his = (jsonData["historys"] as List).map((e) => HistoryBox.fromMap(e)..id = 0).toList();
  //   var filters = (jsonData["filters"] as List).map((e) => FilterBox.fromMap(e)..id = 0).toList();
  //   var setting = SettingBox.fromMap(jsonData["setting"])..id = 0;

  //   historybox.removeAll();
  //   historybox.putMany(his);
  //   filterbox.removeAll();
  //   filterbox.putMany(filters);
  //   settingbox.removeAll();
  //   settingbox.put(setting);
  //   store.close();
  // }

  static openFile(File f) async {
    AudioPlay.stop();

    // f.setLastAccessedSync(DateTime.now());
    var tmpName = f.path.split("/").last;

    String tmpcontents = await Utils.readFile(f);
    tmpcontents = tmpcontents.replaceAll("\r\n", "\n");
    tmpcontents = tmpcontents.replaceAll(RegExp(r'\n{3,}'), "\n\n");

    ContentsIsar contentsisar = ContentsIsar(text: tmpcontents);

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
