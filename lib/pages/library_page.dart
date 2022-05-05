import 'dart:developer' as d;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:marquee/marquee.dart';
import 'package:open_textview/component/library_file_viewer.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';

import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collection/collection.dart' show compareNatural;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryPage extends GetView {
  List<String> sortList = ["name", "size", "date", "access"];
  List<String> filterList = ["ALL", "txt", "zip", "epub"];
  RxString sortStr = "access".obs;
  // RxString searchText = "".obs;
  RxString filterText = "ALL".obs;
  TextEditingController searchTextCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
        initialValue: true,
        builder: (reloadValue, reloadFn) {
          return Scaffold(
            appBar: AppBar(
              // toolbarHeight: 40,
              centerTitle: false,
              title: Container(
                child: Text("my_library".tr),
              ),

              actions: [
                Container(
                  width: Get.width * 0.7,
                  child: Marquee(
                    text: "Long press on".tr,
                    blankSpace: 50.0,
                  ),
                ),
              ],
              bottom: PreferredSize(
                  preferredSize: Size(
                    Get.width,
                    50,
                  ),
                  child: AdBanner(key: Key("library"))),
            ),
            body: Stack(
              children: [
                IsarCtl.rxSetting((_, setting) {
                  return Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      image: setting.bgIdx <= 0
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(Color(setting.bgFilter), BlendMode.dstATop),
                              image: AssetImage('assets/images/${IsarCtl.listBg[setting.bgIdx]}'),
                            ),
                    ),
                  );
                }),
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                      padding: EdgeInsets.only(top: 2, bottom: 2, left: 20, right: 20),
                      child: TextFormField(
                        controller: searchTextCtl,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              IsarCtl.libSearchText("");
                              searchTextCtl.text = "";
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: Icon(Icons.close),
                          ),
                          labelText: "Please enter word".tr,
                        ),
                        onChanged: (v) => IsarCtl.libSearchText(v),
                      )),
                  Expanded(child: LibraryFileViewer()),
                ]),
                Obx(() {
                  if (IsarCtl.epubTotal.value > 0) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("${IsarCtl.epubCurrent.value}/${IsarCtl.epubTotal.value}"),
                          ],
                        ));
                  }
                  return SizedBox();
                }),
                Obx(() {
                  if (IsarCtl.unzipTotal.value > 0 && IsarCtl.unzipTotal.value > IsarCtl.MAXOCRCNT) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Creating split compressed file".tr + " (${IsarCtl.MAXOCRCNT})"),
                            Text("${IsarCtl.unzipCurrent.value}/${IsarCtl.unzipTotal.value}"),
                          ],
                        ));
                  }
                  if (IsarCtl.unzipTotal.value > 0 && IsarCtl.unzipTotal.value <= IsarCtl.MAXOCRCNT + 10) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("${IsarCtl.unzipCurrent.value}/${IsarCtl.unzipTotal.value}"),
                          ],
                        ));
                  }
                  if (IsarCtl.bLoadingLib.value) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ));
                  }

                  return SizedBox();
                })
              ],
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              heroTag: "library",
              onPressed: () async {
                await Utils.selectFile();
                reloadFn(!reloadValue!);
              },
              label: Text('Add_file'.tr),
              icon: Icon(Ionicons.add),
            ),
          );
        });
  }
}
