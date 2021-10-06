import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';

class OptionHistoryCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  final searchText = "".obs;
}

class OptionHistory extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionHistoryCtl());

    return Obx(() {
      var historyList = controller.userData.value.history;
      var copyHistoryList = List<History>.from(historyList);
      copyHistoryList.sort((a, b) {
        return b.date.compareTo(a.date);
      });
      copyHistoryList = copyHistoryList
          .where((el) => el.name.indexOf(pageCtl.searchText.value) >= 0)
          .toList();
      return Stack(
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
                          onChanged: (v) {
                            pageCtl.searchText(v);
                          },
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: new Icon(Ionicons.search),
                    color: Colors.black26,
                    onPressed: () {},
                  )),
              ...copyHistoryList.map((e) {
                Widget delIcon = IconSlideAction(
                  caption: '삭제',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    controller.userData.update((val) {
                      historyList.remove(e);
                    });
                  },
                );
                Widget editIcon = IconSlideAction(
                  caption: '수정',
                  color: Colors.green,
                  icon: Icons.edit,
                  onTap: () async {},
                );
                print(e.path);
                return Card(
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      onTap: () {},
                      title: Text(e.name),
                      subtitle: Row(
                        children: [Text("마지막 위치 : "), Text("${e.pos}")],
                      ),
                    ),
                    actionExtentRatio: 0.2,
                    secondaryActions: [delIcon],
                    actions: [delIcon],
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      );
    });
  }
}
