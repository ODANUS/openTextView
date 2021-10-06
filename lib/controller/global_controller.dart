import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/pages/library_page.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  Rx<UserData> userData = UserData().obs;
  RxList<String> libraryPaths = RxList<String>();
  RxList<String> contents = RxList<String>();
  final Rx<int> tabIndex = 0.obs;
  // RxList

  @override
  void onInit() async {
    var list = await Utils.loadLibraryPrefs();
    if (list != null && list.isNotEmpty) {
      libraryPaths.assignAll(list);
    }

    ever(libraryPaths, (v) {
      Utils.setLibraryPrefs(v as List<String>);
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
  }

  setContents(String str) {
    var tmpcontents = str.replaceAll(RegExp(r'\n{3,}'), "\n");
    contents.assignAll(tmpcontents.split("\n"));
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

  // selectLibrary() {}

  // loadLibrary() {}
}
