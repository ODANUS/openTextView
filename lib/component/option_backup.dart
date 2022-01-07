import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';

class OptionBackupCtl extends GetxController {
  RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;

  Future<void> createBackupFile(str) async {
    isLoading(true);
    DateTime now = DateTime.now();
    await Gdrive.createFile(
        name: "opentextView_${Utils.DF(now, f: "yyyy-MM-dd hh:mm")}.json",
        data: str);
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

  Future<String> loadBackupFile(String id) async {
    isLoading(true);
    String str = await Gdrive.readAppData(id);

    isLoading(false);
    return str;
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
              title: Text("Backup / Recovery".tr),
              children: [
                ListTile(
                  onTap: () async {
                    await pageCtl
                        .createBackupFile(controller.userData.toJson());
                  },
                  title: Text("google drive backup".tr),
                ),
                Divider(),
                ...pageCtl.backupFiles.map((element) {
                  ActionPane delIcon = ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.3,
                      children: [
                        SlidableAction(
                          label: 'delete'.tr,
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (c) async {
                            pageCtl.removeBackupFile(element.id!);
                          },
                        )
                      ]);
                  return Slidable(
                    child: ListTile(
                        onTap: () async {
                          String str =
                              await pageCtl.loadBackupFile(element.id!);
                          controller.userData(UserData.fromJson(str));
                        },
                        title: Text(element.name!)),
                    startActionPane: delIcon,
                    endActionPane: delIcon,
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
