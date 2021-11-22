import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/oss_licenses.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionOsslicenseCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;
}

class OptionOsslicense extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionOsslicenseCtl());

    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {},
              title: Text("open source license".tr),
              children: [
                ...ossLicenses
                    .map((key, value) {
                      return MapEntry(
                          key,
                          Card(
                            child: ListTile(
                              title: Text(value["name"]),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${"license".tr} : ${value["license"]}',
                                      maxLines: 5,
                                    ),
                                    Divider(),
                                    if (value['homepage'] != null)
                                      InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            child: new Text(
                                              'home page'.tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          onTap: () {
                                            launch(value['homepage']);
                                          }),
                                    // Text('${value["description"]}'),
                                  ]),
                            ),
                          ));
                    })
                    .values
                    .toList()

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
