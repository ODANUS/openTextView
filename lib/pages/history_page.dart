import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/option_backup.dart';
import 'package:open_textview/component/option_filter.dart';
import 'package:open_textview/component/option_history.dart';
import 'package:open_textview/component/option_osslicense.dart';
import 'package:open_textview/component/option_popup_ads.dart';
import 'package:open_textview/component/option_review.dart';
import 'package:open_textview/component/option_theme.dart';
import 'package:open_textview/component/option_tts.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPageCtl extends GetxController {
  RxString searchText = "".obs;
}

class HistoryPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(HistoryPageCtl());
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("history".tr),
        // actions: [
        //   IconButton(onPressed: () async {}, icon: Icon(Icons.download))
        // ],
      ),
      body: Obx(() {
        var historyList = controller.userData.value.history;
        var copyHistoryList = List<History>.from(historyList);
        copyHistoryList.sort((a, b) {
          return b.date.compareTo(a.date);
        });
        copyHistoryList = copyHistoryList
            .where((el) => el.name.indexOf(ctl.searchText.value) >= 0)
            .toList();
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: AdsComp(),
            ),
            ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText:
                              "Please enter a word/sentence to search for".tr,
                        ),
                        onChanged: (v) {
                          ctl.searchText(v);
                        },
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: new Icon(
                    Ionicons.search,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  color: Colors.black26,
                  onPressed: () {},
                )),
            Expanded(
              child: ListView(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
                children: copyHistoryList.map((e) {
                  Widget delwidget = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      Text(
                        "Drag to delete".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                  return Card(
                    child: Dismissible(
                      key: Key(e.name),
                      onDismissed: (direction) {
                        controller.userData.update((UserData? val) {
                          if (val != null) {
                            val.history.remove(e);
                          }
                        });
                      },
                      background: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [delwidget, delwidget],
                        ),
                      ),
                      child: ListTile(
                        onTap: () {},
                        title: Text(e.name),
                        subtitle: Row(
                          children: [
                            Text("${"last position".tr} : "),
                            Text("${e.pos}")
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        );
      }),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {}, label: OptionReview()),
    );
  }
}
