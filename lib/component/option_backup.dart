import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/model/box_model.dart';
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

class OptionBackup extends GetView<BoxCtl> {
  final ctl = Get.put(OptionBackupCtl());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {
                if (b) {
                  await Gdrive.gdriveSignIn();
                  await ctl.loadBackupFileList();
                }
              },
              title: Text("Backup / Recovery".tr),
              children: [
                ListTile(
                  onTap: () async {
                    var backUpData = controller.data2Map();
                    var backUpDatastr = json.encode(backUpData);
                    await ctl.createBackupFile(backUpDatastr);
                  },
                  title: Text("google drive backup".tr),
                ),
                Divider(),
                ...ctl.backupFiles.map((element) {
                  ActionPane delIcon = ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.3,
                      children: [
                        SlidableAction(
                          label: 'delete'.tr,
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (c) async {
                            ctl.removeBackupFile(element.id!);
                          },
                        )
                      ]);
                  return Slidable(
                    child: ListTile(
                        onTap: () async {
                          String str = await ctl.loadBackupFile(element.id!);
                          SettingBox settingData = SettingBox();
                          var jsonData = json.decode(str);
                          if (jsonData["tts"] != null &&
                              jsonData["ui"] != null) {
                            Map<String, dynamic> settingMap = {
                              ...jsonData["tts"] as Map,
                              ...jsonData["ui"] as Map,
                              "theme": jsonData["theme"]
                            };

                            settingData = SettingBox.fromMap(settingMap);
                            controller.setSettingBox(settingData);

                            if (jsonData["filter"] is List<dynamic>) {
                              var jsonList =
                                  jsonData["filter"] as List<dynamic>;

                              var list = jsonList
                                  .map((e) => FilterBox.fromMap(e))
                                  .toList();

                              controller.setFilterBox(list);
                            }

                            if (jsonData["history"] is List<dynamic>) {
                              var jsonList =
                                  jsonData["history"] as List<dynamic>;
                              var list = jsonList.map((e) {
                                List<String> tmparr = e["date"].split(" ");
                                var dateStr =
                                    "${tmparr[0]} ${tmparr[1].replaceAll("-", ":")}";
                                e["date"] = DateTime.parse(dateStr)
                                    .millisecondsSinceEpoch;
                                return HistoryBox.fromMap(e);
                              }).toList();
                              controller.setHistoryBox(list);
                            }
                            // FilterBox()
                            return;
                          }
                          controller.map2Data(jsonData);

                          // controller.userData(UserData.fromJson(str));
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
            if (ctl.isLoading.value)
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
