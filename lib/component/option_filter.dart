import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';

class OptionFilterCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;
}

const List<dynamic> DFFILTER = [
  {
    "name": "중국어(한자) 필터",
    "expr": true,
    "filter": "[一-龥]",
    "to": '',
    'enable': false
  },
  {
    "name": "일본어(일어) 필터",
    "expr": true,
    "filter": "[ぁ-ゔ]|[ァ-ヴー]|[々〆〤]",
    "to": '',
    'enable': false
  },
  {
    "name": "물음표 여러개 필터",
    "expr": true,
    "filter": "\\?{1,}",
    "to": '?',
    'enable': false
  },
  {
    "name": "느낌표 여러개 필터",
    "expr": true,
    "filter": "\\!{1,}",
    "to": '!',
    'enable': false
  },
  {
    "name": "다시다시다시(----)",
    "expr": true,
    "filter": "-{2,}",
    "to": '',
    'enable': false
  },
  {
    "name": "는는는(===)",
    "expr": true,
    "filter": "={2,}",
    "to": '',
    'enable': false
  },
  {
    "name": "점점점(......)",
    "expr": true,
    "filter": "\\.{2,}|\\…{1,}",
    "to": '',
    'enable': false
  },
  {
    "name": "물음표,느낌표제거(?!)",
    "expr": true,
    "filter": "\\?{1,}!{1,}",
    "to": '!',
    'enable': false
  },
  {
    "name": "느낌표,물음표제거(!?)",
    "expr": true,
    "filter": "!{1,}\\?{1,}",
    "to": '!',
    'enable': false
  },
  {
    "name": "여러 느낌표나 물음표 필터후 문장에 물음표만 있을경우 필터",
    "expr": true,
    "filter":
        """"!"|"\\."|"\\?"|'!'|'\\?'|“\\.”|“!”|“\\?”|‘!’|‘\\?|\\[!\\]|\\[\\?\\]|\\[\\.\\]""",
    "to": '',
    'enable': false
  },
  {
    "name": "아포스트로피(홀따음표) 필터",
    "expr": false,
    "filter": "'",
    "to": '',
    'enable': false
  },
  {
    "name": "특수문자 반복 된경우 필터",
    "expr": true,
    "filter":
        "\\&{2,}|\\#{2,}|\\@{2,}|\\\${2,}|~{1,}|\\*{2,}|\\[\\]|\\(\\)|\\{\\}",
    "to": '',
    'enable': true
  }
];

class OptionFilter extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionFilterCtl());
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
              title: Text("TTS 필터 설정"),
              children: [
                Container(
                    width: double.infinity,
                    height: 100,
                    // duration: const Duration(milliseconds: 300),
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      ...DFFILTER.map((e) {
                        return Card(
                            margin: EdgeInsets.all(10),
                            child: InkWell(
                                onTap: () {
                                  // RxList rxlist = controller.config['filter'];
                                  // rxlist.add(Map.from({...e, "enable": true}));
                                  // controller.update();
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(e['name']),
                                          Text(e['filter'])
                                        ]))));
                      }).toList()
                    ])),
                // map
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(onTap: () {}, title: Text("asdf")),
                  actionExtentRatio: 0.2,
                  secondaryActions: [delIcon, editIcon],
                  actions: [delIcon, editIcon],
                )
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
