import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';

class OptionBackupCtl extends GetxController {
  RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;

  Future<void> createBackupFile() async {
    isLoading(true);
    DateTime now = DateTime.now();
    await Gdrive.createFile(
        name: "opentextView_${Utils.DF(now, f: "yyyy-MM-dd hh:mm")}.json",
        data: "{}");
    await loadBackupFileList();
    isLoading(false);
  }

  Future<void> loadBackupFileList() async {
    isLoading(true);
    backupFiles.assignAll(await Gdrive.getAppDataList());
    isLoading(false);
  }

  Future<void> removeBackupFile(String id) async {
    isLoading(true);
    await Gdrive.removeAppdata(id);
    await loadBackupFileList();
    isLoading(false);
  }

  Future<void> loadBackupFile(String id) async {
    isLoading(true);
    String str = await Gdrive.readAppData(id);
    print(str);
    isLoading(false);
  }
}

class OptionBackup extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionBackupCtl());

    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {
                if (b) {
                  await Gdrive.gdriveSignIn();
                  await pageCtl.loadBackupFileList();
                }
              },
              title: Text("백업 / 복구"),
              children: [
                ListTile(
                  onTap: () async {
                    await pageCtl.createBackupFile();
                  },
                  title: Text("구글 드라이브 백업"),
                ),
                Divider(),
                ...pageCtl.backupFiles.map((element) {
                  Widget delIcon = IconSlideAction(
                    caption: '삭제',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      pageCtl.removeBackupFile(element.id!);
                    },
                  );
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                        onTap: () {
                          pageCtl.loadBackupFile(element.id!);
                        },
                        title: Text(element.name!)),
                    actionExtentRatio: 0.2,
                    secondaryActions: [
                      delIcon,
                    ],
                    actions: [
                      delIcon,
                    ],
                  );
                }).toList()
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
