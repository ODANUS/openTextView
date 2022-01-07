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

List<dynamic> DFFILTER = [
  {
    "name": "Chinese (Hanja) filter".tr,
    "expr": true,
    "filter": "[一-龥]",
    "to": '',
    'enable': false
  },
  {
    "name": "Japanese (Japanese) filter".tr,
    "expr": true,
    "filter": "[ぁ-ゔ]|[ァ-ヴー]|[々〆〤]",
    "to": '',
    'enable': false
  },
  {
    "name": "filter multiple question marks".tr,
    "expr": true,
    "filter": "\\?{1,}",
    "to": '?',
    'enable': false
  },
  {
    "name": "Filter multiple exclamation marks".tr,
    "expr": true,
    "filter": "\\!{1,}",
    "to": '!',
    'enable': false
  },
  {
    "name": "filter ----".tr,
    "expr": true,
    "filter": "-{2,}",
    "to": '',
    'enable': false
  },
  {
    "name": "filter ===".tr,
    "expr": true,
    "filter": "={2,}",
    "to": '',
    'enable': false
  },
  {
    "name": "filter .....".tr,
    "expr": true,
    "filter": "\\.{2,}|\\…{1,}",
    "to": '',
    'enable': false
  },
  {
    "name": "filter ?!".tr,
    "expr": true,
    "filter": "\\?{1,}!{1,}",
    "to": '!',
    'enable': false
  },
  {
    "name": "filter !?".tr,
    "expr": true,
    "filter": "!{1,}\\?{1,}",
    "to": '!',
    'enable': false
  },
  {
    "name": "filter ?,!".tr,
    "expr": true,
    "filter":
        """"!"|"\\."|"\\?"|'!'|'\\?'|“\\.”|“!”|“\\?”|‘!’|‘\\?|\\[!\\]|\\[\\?\\]|\\[\\.\\]""",
    "to": '',
    'enable': false
  },
  {
    "name": "apostrophe filter".tr,
    "expr": false,
    "filter": "'",
    "to": '',
    'enable': false
  },
  {
    "name": "special character repeat filter".tr,
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
            title: Text("TTS filter settings".tr),
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
                ActionPane actionPane = ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.4,
                    children: [
                      SlidableAction(
                        label: 'delete'.tr,
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        onPressed: (c) async {
                          controller.userData.update((v) {
                            filterList.remove(e);
                          });
                        },
                      ),
                      SlidableAction(
                        label: 'edit'.tr,
                        backgroundColor: Colors.green,
                        icon: Icons.edit,
                        onPressed: (c) async {
                          pageCtl.tmpEditFilter(Filter.fromMap(e.toMap()));
                          pageCtl.idxeditTarget(idx);
                        },
                      )
                    ]);
                // Widget delIcon = IconSlideAction(
                //   caption: 'delete'.tr,
                //   color: Colors.red,
                //   icon: Icons.delete,
                //   onTap: () async {
                //     controller.userData.update((v) {
                //       filterList.remove(e);
                //     });
                //   },
                // );
                // Widget editIcon = IconSlideAction(
                //   caption: 'edit'.tr,
                //   color: Colors.green,
                //   icon: Icons.edit,
                //   onTap: () async {
                //     pageCtl.tmpEditFilter(Filter.fromMap(e.toMap()));
                //     pageCtl.idxeditTarget(idx);
                //   },
                // );

                return Card(
                    child: Slidable(
                  startActionPane: actionPane,
                  endActionPane: actionPane,
                  child: ListTile(
                      title: bedit
                          ? TextFormField(
                              decoration: InputDecoration(
                                labelText: "name".tr,
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
                                        labelText: "filter rules".tr,
                                      ),
                                      initialValue: tmpFilter.filter,
                                      onChanged: (v) => rxFilter.update((val) {
                                        tmpFilter.filter = v;
                                      }),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "change text".tr,
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
                                      Text("${e.to == "" ? "none".tr : e.to}"),
                                    ],
                                  ),
                            Row(
                              children: [
                                Text("${"Use regular expressions".tr} : "),
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
                                      child: Text("cancel".tr)),
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.userData.update((val) {
                                          filterList[idx] =
                                              Filter.fromMap(tmpFilter.toMap());
                                        });
                                        pageCtl.idxeditTarget(-1);
                                      },
                                      child: Text("confirm".tr)),
                                ],
                              )
                          ]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("use".tr),
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
