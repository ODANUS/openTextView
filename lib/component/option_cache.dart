import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';

class OptionCacheCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;
  RxList<FileSystemEntity> list = RxList<FileSystemEntity>();
  @override
  void onInit() async {
    loadTmpList();

    super.onInit();
  }

  loadTmpList() async {
    isLoading(true);
    Directory d = await getTemporaryDirectory();
    var tmplist = await d.list().toList();
    list.assignAll(tmplist);
    isLoading(false);
  }
}

class OptionCache extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionCacheCtl());

    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {},
              title: Text("캐시 관리"),
              children: [
                ListTile(
                  onTap: () async {
                    controller.loadconfig();
                    // final LocalStorage storage =
                    //     new LocalStorage('opentextview');
                    // await storage.ready;

                    Directory d = await getTemporaryDirectory();
                    var list = await d.list().toList();
                    pageCtl.loadTmpList();
                    // // print(list);
                    // Directory d1 = await getApplicationDocumentsDirectory();
                    // var list1 = await d1.list().toList();
                    // print(d1.path);
                    // File f = File(d1.path + "/opentextview");
                    // print(f.readAsStringSync());
                    // var ss = await (list.first as Directory).list().toList();
                    // print(ss);
                    // await pageCtl.createBackupFile();
                  },
                  title: Text("aaaaaaa"),
                ),
                Divider(),
                ...pageCtl.list.map((e) {
                  Widget delIcon = IconSlideAction(
                    caption: '삭제',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {},
                  );
                  return Text("asdf");
                }).toList(),

                // ListTile(
                //   title: Text("백업 리스트"),
                // )
              ],
            ),
            if (pageCtl.isLoading.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ));
  }
}
