import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';

class OptionFilterCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  final idxeditTarget = (-1).obs;
  final tmpEditFilter = Filter().obs;
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
  addFilter(Filter f) {
    controller.userData.update((val) {
      if (val!.filter.isEmpty) {
        val.filter = [f];
      } else {
        val.filter.add(f);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionFilterCtl());

    return Obx(() {
      var filterList = controller.userData.value.filter;
      return Stack(
        children: [
          ExpansionTile(
            onExpansionChanged: (b) async {},
            title: Text("TTS 필터 설정"),
            children: [
              Container(
                  width: double.infinity,
                  height: 100,
                  // duration: const Duration(milliseconds: 300),
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    ...DFFILTER.map((e) {
                      return Card(
                          margin: EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () {
                                addFilter(Filter.fromMap(e)..enable = true);
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
              ...filterList.map((e) {
                var idx = filterList.indexOf(e);
                bool bedit = idx == pageCtl.idxeditTarget.value;
                var tmpFilter = pageCtl.tmpEditFilter.value;
                var rxFilter = pageCtl.tmpEditFilter;
                Widget delIcon = IconSlideAction(
                  caption: '삭제',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    controller.userData.update((v) {
                      filterList.remove(e);
                    });
                  },
                );
                Widget editIcon = IconSlideAction(
                  caption: '수정',
                  color: Colors.green,
                  icon: Icons.edit,
                  onTap: () async {
                    pageCtl.tmpEditFilter(Filter.fromMap(e.toMap()));
                    pageCtl.idxeditTarget(idx);
                  },
                );

                return Card(
                    child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(
                      // onTap: () {
                      //   print(e.toJson());
                      // },
                      title: bedit
                          ? TextFormField(
                              decoration: InputDecoration(
                                labelText: "이름",
                              ),
                              initialValue: tmpFilter.name,
                              onChanged: (v) => rxFilter.update((val) {
                                tmpFilter.name = v;
                              }),
                            )
                          : Text(e.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bedit
                                ? Column(children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "필터 규칙",
                                      ),
                                      initialValue: tmpFilter.filter,
                                      onChanged: (v) => rxFilter.update((val) {
                                        tmpFilter.filter = v;
                                      }),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "변경 문자",
                                      ),
                                      initialValue: tmpFilter.to,
                                      onChanged: (v) => rxFilter.update((val) {
                                        tmpFilter.to = v;
                                      }),
                                    )
                                  ])
                                : Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text("${e.filter}"),
                                      Text("   ->   "),
                                      Text("${e.to == "" ? "없음" : e.to}"),
                                    ],
                                  ),
                            Row(
                              children: [
                                Text("정규식 사용 : "),
                                bedit
                                    ? Checkbox(
                                        value: tmpFilter.expr,
                                        onChanged: (b) {
                                          pageCtl.tmpEditFilter.update((val) {
                                            tmpFilter.expr = b!;
                                          });
                                        },
                                      )
                                    : Checkbox(
                                        value: e.expr,
                                        onChanged: (b) {
                                          controller.userData.update((v) {
                                            e.expr = b!;
                                          });
                                        },
                                      )
                              ],
                            ),
                            if (bedit)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        pageCtl.idxeditTarget(-1);
                                      },
                                      child: Text("취소")),
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.userData.update((val) {
                                          filterList[idx] =
                                              Filter.fromMap(tmpFilter.toMap());
                                        });
                                        pageCtl.idxeditTarget(-1);
                                      },
                                      child: Text("확인")),
                                ],
                              )
                          ]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("사용"),
                          bedit
                              ? Checkbox(
                                  value: tmpFilter.enable,
                                  onChanged: (b) {
                                    pageCtl.tmpEditFilter.update((val) {
                                      tmpFilter.enable = b!;
                                    });
                                  },
                                )
                              : Checkbox(
                                  value: e.enable,
                                  onChanged: (b) {
                                    controller.userData.update((v) {
                                      e.enable = b!;
                                    });
                                  }),
                        ],
                      )),
                  actionExtentRatio: 0.2,
                  secondaryActions: [delIcon, editIcon],
                  actions: [delIcon, editIcon],
                ));
              }).toList(),
              ElevatedButton(
                  onPressed: () {
                    controller.userData.update((val) {
                      addFilter(Filter());
                    });
                  },
                  child: Icon(Ionicons.add)),
            ],
          ),
        ],
      );
    });
  }
}
