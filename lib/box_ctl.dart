import 'dart:io'; // for exit();
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/objectbox.g.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BoxCtl extends GetxController with WidgetsBindingObserver {
  final List<String> listFont = [
    'default',
    "NanumGothic",
    "OpenSans",
    "ReadexPro",
    "Roboto",
  ];

  static Store? store;
  static Box<FilterBox>? filterBox;
  static Box<SettingBox>? settingBox;
  static Box<HistoryBox>? historyBox;

  final itemScrollctl = ItemScrollController();
  final itemPosListener = ItemPositionsListener.create();

  Rx<HistoryBox> currentHistory = HistoryBox().obs;
  RxList<FilterBox> filters = RxList<FilterBox>();
  RxList<String> contents = RxList<String>();

  Rx<SettingBox> setting = SettingBox().obs;

  RxInt tabIndex = 0.obs;
  RxBool bFullScreen = false.obs;
  RxBool scrollstat = false.obs;
  RxBool bConvLoading = false.obs;
  RxBool bScreenHelp = false.obs;
  RxBool firstFullScreen = true.obs;
  RxBool bImageFullScreen = false.obs;

  Rx<bool> bTowDrage = false.obs;

  int min = 0;
  int max = 0;

  Rx<AppLifecycleState> appLifecycleState = AppLifecycleState.inactive.obs;

  static Future<Store?> createStore() async {
    if (store == null) {
      store = await openStore();
    }
    return store;
  }

  static _initBox() {
    filterBox = store!.box<FilterBox>();
    settingBox = store!.box<SettingBox>();
    historyBox = store!.box<HistoryBox>();
  }

  static init() async {
    await createStore();
    await _initBox();
  }

  @override
  void onInit() async {
    await init();
    await initLastHistoryBox();
    addListen();
    initValue();

    if (filterBox!.count() == 0 &&
        settingBox!.count() == 0 &&
        historyBox!.count() == 0) {
      await Utils.loadprefs();
    }

    debounce(filters, (List<FilterBox> v) {
      filterBox!.putMany(v);
      AudioPlay.setFilter(filter: v);
    }, time: 100.milliseconds);

    debounce(setting, (SettingBox v) {
      settingBox!.put(v);
      AudioPlay.setSetting(setting: v);
    }, time: 100.milliseconds);

    debounce(currentHistory, (HistoryBox v) {
      if (v.name.isNotEmpty) {
        historyBox!.put(currentHistory.value);
      }
    }, time: 1.seconds);

    debounce(scrollstat, (bool b) {
      scrollstat(false);
    }, time: 500.milliseconds);

    AudioPlay.lisen((e) {
      if (e.playing) {
        currentHistory.update((val) {
          val!.pos = e.updatePosition.inSeconds;
        });
        if (appLifecycleState.value == AppLifecycleState.inactive ||
            appLifecycleState.value == AppLifecycleState.resumed) {
          if (contents.length >= e.updatePosition.inSeconds &&
              !scrollstat.value) {
            itemScrollctl.jumpTo(index: e.updatePosition.inSeconds);
          }
        }
      }
    });

    HardwareKeyboard.instance.removeHandler(volumeControll);
    HardwareKeyboard.instance.addHandler(volumeControll);

    WidgetsBinding.instance!.addObserver(this);

    super.onInit();
  }

  bool volumeControll(KeyEvent event) {
    bool result = false;
    if (event is KeyDownEvent && tabIndex.value == 0 && bFullScreen.value) {
      if (event.logicalKey == LogicalKeyboardKey.audioVolumeUp &&
          !result &&
          !AudioPlay.audioHandler!.playbackState.stream.value.playing) {
        result = true;
        backPage();
      }
      if (event.logicalKey == LogicalKeyboardKey.audioVolumeDown &&
          bFullScreen.value) {
        result = true;
        nextPage();
      }
    }
    return result;
  }

  backPage() {
    if (min > 0 && contents.length > 0 && bFullScreen.value) {
      var minPos = itemPosListener.itemPositions.value.reduce((ItemPosition min,
              ItemPosition position) =>
          position.itemTrailingEdge < min.itemTrailingEdge ? position : min);
      var offset = (minPos.itemLeadingEdge + 1).toStringAsFixed(1);

      itemScrollctl.jumpTo(
          index: minPos.index, alignment: double.parse(offset));
      // , alignment: 1 + double.parse(offset));
    }
  }

  nextPage() {
    if (max > 0 && contents.length > 0 && bFullScreen.value) {
      // var minPos = itemPosListener.itemPositions.value.reduce((ItemPosition min,
      //         ItemPosition position) =>
      //     position.itemTrailingEdge < min.itemTrailingEdge ? position : min);
      // itemScrollctl.jumpTo(index: minPos.index, alignment: 0);
      var maxPos = itemPosListener.itemPositions.value
          .where((ItemPosition position) => position.itemLeadingEdge < 1)
          .reduce((ItemPosition max, ItemPosition position) =>
              position.itemLeadingEdge > max.itemLeadingEdge ? position : max);

      var offset = (maxPos.itemLeadingEdge - 1).toStringAsFixed(1);

      itemScrollctl.jumpTo(
          index: maxPos.index, alignment: double.parse(offset));
      // itemScrollctl.jumpTo(
      //     index: maxPos.index,
      //     alignment:
      //         double.parse((0 - double.parse(offset)).toStringAsFixed(1)));
    }
  }

  initValue() {
    var tmpSettings = settingBox?.getAll();
    if (tmpSettings != null && tmpSettings.isNotEmpty) {
      setting(tmpSettings.first);

      if (setting.value.theme == "dark") {
        Get.changeTheme(ThemeData.dark());
      }
      if (setting.value.theme == "light") {
        Get.changeTheme(ThemeData.light());
      }
    }

    var tmpfilters = filterBox?.getAll();
    if (tmpSettings != null) {
      filters(tmpfilters);
    }
  }

  initLastHistoryBox() async {
    var q = historyBox!.query()
      ..order(HistoryBox_.date, flags: Order.descending);
    var lastHistorybox = q.build().findFirst();
    if (lastHistorybox != null) {
      var tmp = await getTemporaryDirectory();
      var dir = Directory("${tmp.path}/file_picker");

      if (!dir.existsSync()) dir.createSync(recursive: true);

      File f = File("${dir.path}/${lastHistorybox.name}");
      if (f.existsSync()) {
        openFile(f);
      }
    }
  }

  addListen() {
    itemPosListener.itemPositions.addListener(scrollListener);
  }

  removeListen() {
    itemPosListener.itemPositions.removeListener(scrollListener);
  }

  scrollListener() {
    scrollstat(true);

    if (contents.isEmpty) return;
    min = itemPosListener.itemPositions.value
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;
    max = itemPosListener.itemPositions.value
        .where((ItemPosition position) => position.itemLeadingEdge < 1)
        .reduce((ItemPosition max, ItemPosition position) =>
            position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
        .index;

    if (currentHistory.value.pos != min) {
      currentHistory.update((val) {
        val!.pos = min;
      });
    }
  }

  openFile(File f) async {
    AudioPlay.stop();
    if (scrollstat.value) {
      await Future.delayed(300.milliseconds);
      return openFile(f);
    }
    removeListen();

    contents.clear();

    var name = f.path.split("/").last;
    var target =
        historyBox!.query(HistoryBox_.name.equals(name)).build().findFirst();
    String tmpStr = await Utils.readFile(f);
    f.setLastAccessedSync(DateTime.now());

    var tmpcontents = tmpStr.replaceAll(RegExp(r'\n{3,}'), "\n");
    contents.assignAll(tmpcontents.split("\n"));

    tabIndex(0);

    if (target != null) {
      currentHistory(target);
      target.date = DateTime.now();
      target.contentsLen = tmpStr.length;
      historyBox!.put(target);

      addListen();
      // WidgetsBinding.instance!.addPostFrameCallback((_) {
      //   if (this.contents.length >= target.pos) {
      //     itemScrollctl.jumpTo(index: target.pos);
      //   }
      // });

      return;
    }
    HistoryBox nowHistory = HistoryBox(
        date: DateTime.now(),
        name: name,
        length: contents.length,
        contentsLen: tmpStr.length);

    currentHistory(nowHistory);
    historyBox!.put(nowHistory);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      itemScrollctl.jumpTo(index: 0);
      addListen();
    });
  }

  List<HistoryBox> getHistorys() {
    return historyBox!.getAll();
  }

  List<FilterBox> getFilter() {
    return filterBox!.getAll();
  }

  SettingBox getSetting() {
    return settingBox!.getAll().first;
  }

  setSettingBox(SettingBox data) {
    settingBox!.removeAll();
    settingBox!.put(data);
  }

  setFilterBox(List<FilterBox> datas) {
    filterBox!.removeAll();
    filterBox!.putMany(datas);
  }

  setHistoryBox(List<HistoryBox> datas) {
    historyBox!.removeAll();
    historyBox!.putMany(datas);
  }

  removeHistory(HistoryBox v) {
    historyBox!.remove(v.id);
  }

  editHistory(HistoryBox v) {
    var idx = historyBox!.put(v);
  }

  Map<String, dynamic> data2Map() {
    return {
      "historys": getHistorys().map((e) => e.toMap()).toList(),
      "filters": getFilter().map((e) => e.toMap()).toList(),
      "setting": getSetting().toMap(),
    };
  }

  map2Data(Map<String, dynamic> jsonData) {
    var his = (jsonData["historys"] as List)
        .map((e) => HistoryBox.fromMap(e)..id = 0)
        .toList();
    var filters = (jsonData["filters"] as List)
        .map((e) => FilterBox.fromMap(e)..id = 0)
        .toList();
    var setting = SettingBox.fromMap(jsonData["setting"])..id = 0;

    setHistoryBox(his);
    setFilterBox(filters);
    setSettingBox(setting);
    initValue();
  }

  // addFilter(FilterBox v) {
  //   filterBox!.put(v);
  // }

  // editFilter(FilterBox v) {
  //   filterBox!.put(v);
  // }

  removeFilter(FilterBox v) {
    filterBox!.remove(v.id);
    filters(filterBox!.getAll());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState(state);

    if (appLifecycleState.value == AppLifecycleState.inactive ||
        appLifecycleState.value == AppLifecycleState.resumed) {
      if (itemScrollctl.isAttached) {
        itemScrollctl.jumpTo(index: currentHistory.value.pos);
      }
    }

    super.didChangeAppLifecycleState(state);
  }
}
