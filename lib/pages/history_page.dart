import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';

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
