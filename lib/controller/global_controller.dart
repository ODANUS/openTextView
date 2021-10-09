import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/pages/library_page.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController with WidgetsBindingObserver {
  final userData = UserData().obs;
  RxList<String> libraryPaths = RxList<String>();
  RxList<String> contents = RxList<String>();
  final Rx<int> tabIndex = 0.obs;

  Rx<bool> isVisible = true.obs;

  Rx<History> lastData = History().obs;

  final itemScrollctl = ItemScrollController();
  final itemPosListener = ItemPositionsListener.create();
  Rx<AppLifecycleState> appLifecycleState = AppLifecycleState.inactive.obs;

  final navBarController = ScrollController();
  // RxList

  @override
  void onInit() async {
    var list = await Utils.loadLibraryPrefs();
    if (list != null && list.isNotEmpty) {
      libraryPaths.assignAll(list);
    }

    ever(libraryPaths, (v) async {
      Utils.setLibraryPrefs(v as List<String>);
    });
    await loadconfig();
    var tmplast = await Utils.loadLastData();
    if (tmplast != null) {
      lastData(History.fromJson(tmplast));
      await openFile(File(lastData.value.path));
    }

    debounce(userData, (callback) {
      Utils.setUserData(userData.toJson());
    }, time: 3.seconds);

    debounce(userData, (UserData callback) {
      AudioPlay.setConfig(
          tts: callback.tts.toMap(), filter: callback.filter.toList());
    }, time: 300.milliseconds);

    // save data
    debounce(lastData, (callback) {
      History history = (callback as History);
      Utils.setLastData(history.toJson());
      var idx = userData.value.history.indexWhere((e) {
        return e.name == history.name;
      });
      if (idx < 0) {
        userData.update((val) {
          if (val!.history.isEmpty) {
            val.history = [history];
            return;
          }

          val.history.add(history);
        });
        return;
      }
      userData.update((val) {
        val!.history[idx].pos = history.pos;
      });
    }, time: 200.milliseconds);

    AudioPlay.lisen((e) {
      if (e.playing) {
        lastData.update((val) {
          val!.pos = e.updatePosition.inSeconds;
        });
        if (appLifecycleState == AppLifecycleState.inactive) {
          itemScrollctl.jumpTo(index: e.updatePosition.inSeconds);
        }
      }
    });

    itemPosListener.itemPositions.addListener(() {
      var min = itemPosListener.itemPositions.value
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .reduce((ItemPosition min, ItemPosition position) =>
              position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
          .index;
      // if (lastData.value.pos < min) {
      //   isVisible(false);
      // }
      // if (lastData.value.pos > min) {
      //   isVisible(true);
      // }
      lastData.update((val) {
        val!.pos = min;
      });
      // print(ss.last.index);
    });

    super.onInit();
  }

  loadconfig() async {
    // Utils.clearUserData();
    String? strUserData = await Utils.loadUserData();
    if (strUserData == null && await Utils.isLocalStorage()) {
      UserData? tmpUserData = await Utils.localStorageToUserData();
      if (tmpUserData != null) {
        await Utils.setUserData(tmpUserData.toJson());
        return await loadconfig();
      }
    }
    if (strUserData != null) {
      userData(UserData.fromJson(strUserData));
    }
    changeTheme(userData.value.theme);
  }

  changeTheme(String str) {
    if (str == "dark") {
      Get.changeTheme(ThemeData.dark());
    }
    if (str == "light") {
      Get.changeTheme(ThemeData.light());
    }
  }

  setContents(String str) {
    var tmpcontents = str.replaceAll(RegExp(r'\n{3,}'), "\n");
    contents.assignAll(tmpcontents.split("\n"));
  }

  Future<void> openFile(File f) async {
    String contents = await Utils.readFile(f);
    String name = f.path.split("/").last;
    var arrs = userData.value.history.where((e) {
      return name == e.name || f.path == e.path;
    }).toList();
    lastData(History(
      date: Utils.DF(DateTime.now(), f: "yyyy-MM-dd HH:mm:ss"),
      name: f.path.split("/").last,
      pos: arrs.isEmpty ? 0 : arrs.first.pos,
      path: f.path,
    ));

    setContents(contents);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      itemScrollctl.jumpTo(index: lastData.value.pos);
    });
    // if (arrs.isNotEmpty) {
    //   print("=========================== ${arrs.first.pos}");
    // }else{
    //   itemScrollctl.jumpTo(0);
    // }
    tabIndex(0);
  }

  // loadLibrary() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   prefs.setStringList("libraryPaths", libraryPaths);
  // }

  // setLibrary() async {
  //   SharedPreferences prefs = await _prefs;
  //   prefs.reload();
  //   prefs.setStringList("libraryPaths", libraryPaths);
  // }

  addLibrary(String path) {
    libraryPaths.add(path);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState(state);

    super.didChangeAppLifecycleState(state);
    // bforeground
    // switch (state) {
    //   case AppLifecycleState.resumed:
    //     bforeground.update((val) {
    //       bforeground.value = true;
    //     });
    //     // widget is resumed
    //     break;
    //   case AppLifecycleState.inactive:

    //     // widget is inactive
    //     break;
    //   case AppLifecycleState.paused:
    //     bforeground.update((val) {
    //       bforeground.value = true;
    //     });
    //     // widget is paused
    //     break;
    //   case AppLifecycleState.detached:
    //     // widget is detached
    //     break;
    // }
  }
  // selectLibrary() {}

  // loadLibrary() {}
}
