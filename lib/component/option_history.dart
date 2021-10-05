import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';

class OptionHistoryCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;
}

class OptionHistory extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionHistoryCtl());

    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {},
              title: Text("히스토리"),
              children: [
                ListTile(
                  onTap: () async {
                    // await pageCtl.createBackupFile();
                  },
                  title: Text("aaaaaaa"),
                ),
                Divider(),

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
