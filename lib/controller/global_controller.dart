// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:audio_service/audio_service.dart';
// import 'package:epubx/epubx.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:html/dom.dart' as dom;
// import 'package:html/parser.dart';
// import 'package:open_textview/component/open_modal.dart';
// import 'package:open_textview/controller/audio_play.dart';
// import 'package:open_textview/model/user_data.dart';
// import 'package:open_textview/provider/utils.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class GlobalController extends GetxController with WidgetsBindingObserver {
//   final userData = UserData().obs;
//   RxList<String> libraryPaths = RxList<String>();
//   RxList<String> contents = RxList<String>();
//   final Rx<int> tabIndex = 0.obs;

//   Rx<bool> isVisible = true.obs;

//   Rx<History> lastData = History().obs;

//   // RxList<String> lastImageData = RxList<String>();

//   final itemScrollctl = ItemScrollController();
//   final itemPosListener = ItemPositionsListener.create();
//   Rx<AppLifecycleState> appLifecycleState = AppLifecycleState.inactive.obs;

//   final navBarController = ScrollController();

//   final Rx<bool> scrollstat = false.obs;

//   final List<String> listFont = [
//     'default',
//     "NanumGothic",
//     "OpenSans",
//     "ReadexPro",
//     "Roboto",
//   ];
//   final RxBool bFullScreen = false.obs;
//   final RxBool bScreenHelp = false.obs;
//   final RxBool firstFullScreen = true.obs;

//   int min = 0;
//   int max = 0;

//   final RxBool bConvLoading = false.obs;

//   // RxList

//   @override
//   void onInit() async {
//     return;
//     // var list = await Utils.loadLibraryPrefs();
//     // if (list != null && list.isNotEmpty) {
//     //   libraryPaths.assignAll(list);
//     // }

//     // ever(libraryPaths, (v) async {
//     //   Utils.setLibraryPrefs(v as List<String>);
//     // });
//     // await loadconfig();
//     // var tmplast = await Utils.loadLastData();
//     // if (tmplast != null) {
//     //   try {
//     //     lastData(History.fromJson(tmplast));
//     //     await openFile(File(lastData.value.path));
//     //   } catch (e) {
//     //     print(e);
//     //   }
//     // }

//     debounce(userData, (callback) {
//       Utils.setUserData(userData.toJson());
//     }, time: 5.seconds);

//     // debounce(userData, (UserData callback) {
//     //   AudioPlay.setConfig(
//     //       tts: callback.tts.toMap(), filter: callback.filter.toList());
//     // }, time: 300.milliseconds);

//     // save data
//     debounce(lastData, (callback) {
//       History history = (callback as History);
//       Utils.setLastData(history.toJson());
//       var idx = userData.value.history.indexWhere((e) {
//         return e.name == history.name;
//       });
//       if (idx < 0) {
//         userData.update((val) {
//           if (val!.history.isEmpty) {
//             val.history = [history];
//             return;
//           }

//           val.history.add(history);
//         });
//         return;
//       }
//       userData.update((val) {
//         val!.history[idx].pos = history.pos;
//         val.history[idx].length = history.length;
//         val.history[idx].path = history.path;
//         val.history[idx].date = history.date;
//       });
//     }, time: 1.seconds);

//     AudioPlay.lisen((e) {
//       if (e.playing) {
//         lastData.update((val) {
//           val!.pos = e.updatePosition.inSeconds;
//         });
//         if (appLifecycleState.value == AppLifecycleState.inactive) {
//           if (contents.length >= e.updatePosition.inSeconds &&
//               !scrollstat.value) {
//             itemScrollctl.jumpTo(index: e.updatePosition.inSeconds);
//           }
//         }
//       }
//     });

//     debounce(scrollstat, (bool b) {
//       scrollstat(false);
//     }, time: 500.milliseconds);
//     itemPosListener.itemPositions.addListener(() {
//       scrollstat(true);
//       min = itemPosListener.itemPositions.value
//           .where((ItemPosition position) => position.itemTrailingEdge > 0)
//           .reduce((ItemPosition min, ItemPosition position) =>
//               position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
//           .index;
//       max = itemPosListener.itemPositions.value
//           .where((ItemPosition position) => position.itemLeadingEdge < 1)
//           .reduce((ItemPosition max, ItemPosition position) =>
//               position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
//           .index;
//       // if (lastData.value.pos < min) {
//       //   isVisible(false);
//       // }
//       // if (lastData.value.pos > min) {
//       //   isVisible(true);
//       // }
//       lastData.update((val) {
//         val!.pos = min;
//       });
//     });

//     super.onInit();

//     // await Future.delayed(500.milliseconds);
//     // OpenModal.openFocusModal();
//     HardwareKeyboard.instance.removeHandler(volumeControll);
//     HardwareKeyboard.instance.addHandler(volumeControll);
//   }

//   @override
//   void onClose() {
//     HardwareKeyboard.instance.removeHandler(volumeControll);
//     super.onClose();
//   }

//   bool volumeControll(KeyEvent event) {
//     bool result = false;
//     if (event is KeyDownEvent && tabIndex.value == 0 && bFullScreen.value) {
//       if (event.logicalKey == LogicalKeyboardKey.audioVolumeUp &&
//           !result &&
//           !AudioPlay.audioHandler!.playbackState.stream.value.playing) {
//         result = true;
//         backPage();
//       }
//       if (event.logicalKey == LogicalKeyboardKey.audioVolumeDown &&
//           bFullScreen.value) {
//         result = true;
//         nextPage();
//       }
//     }
//     return result;
//   }

//   backPage() {
//     if (min > 0 && contents.length > 0 && bFullScreen.value) {
//       itemScrollctl.scrollTo(
//           index: min + 4, duration: 150.milliseconds, alignment: 1.0);
//     }
//   }

//   nextPage() {
//     if (max > 0 && contents.length > 0 && bFullScreen.value) {
//       itemScrollctl.scrollTo(index: max - 3, duration: 150.milliseconds);
//     }
//   }

//   loadconfig() async {
//     // Utils.clearUserData();
//     String? strUserData = await Utils.loadUserData();
//     if (strUserData == null && await Utils.isLocalStorage()) {
//       UserData? tmpUserData = await Utils.localStorageToUserData();
//       if (tmpUserData != null) {
//         await Utils.setUserData(tmpUserData.toJson());
//         return await loadconfig();
//       }
//     }
//     if (strUserData != null) {
//       userData(UserData.fromJson(strUserData));
//     }
//     changeTheme(userData.value.theme);
//   }

//   changeTheme(String str) {
//     if (str == "dark") {
//       Get.changeTheme(ThemeData.dark());
//     }
//     if (str == "light") {
//       Get.changeTheme(ThemeData.light());
//     }
//   }

//   setContents(String str) {
//     var tmpcontents = str.replaceAll(RegExp(r'\n{3,}'), "\n");
//     contents.assignAll(tmpcontents.split("\n"));
//   }

//   Future<void> openFile(File f) async {
//     if (scrollstat.value) {
//       await Future.delayed(300.milliseconds);
//       return openFile(f);
//     }

//     if (f.path.split(".").last == "txt") {
//       f.setLastAccessedSync(DateTime.now());
//       String contents = await Utils.readFile(f);
//       String name = f.path.split("/").last;
//       AudioPlay.stop();
//       var arrs = userData.value.history.where((e) {
//         return name == e.name || f.path == e.path;
//       }).toList();

//       setContents(contents);
//       // setContents("test");
//       lastData(History(
//           date: Utils.DF(DateTime.now(), f: "yyyy-MM-dd HH:mm:ss"),
//           name: f.path.split("/").last,
//           pos: arrs.isEmpty ? 0 : arrs.first.pos,
//           path: f.path,
//           length: this.contents.length));
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         if (this.contents.length >= lastData.value.pos) {
//           itemScrollctl.jumpTo(index: lastData.value.pos);
//         }
//       });

//       tabIndex(0);
//       return;
//     }
//     // Directory d = f.parent;
//     // var files = await d.list().toList();

//     // var tmpList = files.map((e) {
//     //   return e.path;
//     // }).toList();
//     // lastImageData.assignAll(tmpList);
//     // print(await d.list().toList());
//     // lastImageData
//   }

//   // loadLibrary() async {
//   //   SharedPreferences prefs = await _prefs;
//   //   prefs.reload();
//   //   prefs.setStringList("libraryPaths", libraryPaths);
//   // }

//   // setLibrary() async {
//   //   SharedPreferences prefs = await _prefs;
//   //   prefs.reload();
//   //   prefs.setStringList("libraryPaths", libraryPaths);
//   // }

//   addLibrary(String path) {
//     libraryPaths.add(path);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     appLifecycleState(state);

//     super.didChangeAppLifecycleState(state);
//   }

//   // selectLibrary() {}

//   // loadLibrary() {}
// }
