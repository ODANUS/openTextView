import 'package:get/state_manager.dart';
import 'package:open_textview/pages/library_page.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
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
