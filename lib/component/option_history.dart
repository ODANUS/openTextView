import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:ionicons/ionicons.dart';
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
    Widget delIcon = IconSlideAction(
      caption: '삭제',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () async {},
    );
    Widget editIcon = IconSlideAction(
      caption: '수정',
      color: Colors.green,
      icon: Icons.edit,
      onTap: () async {},
    );
    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {},
              title: Text("히스토리"),
              children: [
                ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "검색할 단어 / 문장을 입력해 주세요.",
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: new Icon(Ionicons.search),
                      color: Colors.black26,
                      onPressed: () {},
                    )),
                // map
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(onTap: () {}, title: Text("대한민국 헌법.txt")),
                  actionExtentRatio: 0.2,
                  secondaryActions: [delIcon, editIcon],
                  actions: [delIcon, editIcon],
                ),
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
