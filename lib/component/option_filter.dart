import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/objectbox.g.dart';

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

class OptionFilterCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  final idxeditTarget = (-1).obs;
  final tmpEditFilter = FilterBox().obs;
}

class OptionFilter extends GetView<BoxCtl> {
  addFilter(FilterBox f) {
    controller.filters.add(f);
    // controller.userData.update((val) {
    //   if (val!.filter.isEmpty) {
    //     val.filter = [f];
    //   } else {
    //     val.filter.add(f);
    //   }
    // });
  }

  Future<String> getClipboard() async {
    Map<String, dynamic>? result =
        await SystemChannels.platform.invokeMethod('Clipboard.getData');
    return result != null ? result["text"] : "";
  }

  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionFilterCtl());

    return Obx(() {
      // List<FilterBox> filterList = controller.filters();
      return Stack(
        children: [
          ExpansionTile(
            onExpansionChanged: (b) async {},
            title: Text("TTS filter settings".tr),
            children: [
              Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    ...DFFILTER.map((e) {
                      return Card(
                          margin: EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () {
                                addFilter(FilterBox.fromMap(e)..enable = true);
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
              ...controller.filters.map((e) {
                var idx = controller.filters.indexOf(e);
                bool bedit = idx == pageCtl.idxeditTarget.value;
                var tmpFilter = pageCtl.tmpEditFilter.value;
                var rxFilter = pageCtl.tmpEditFilter;
                TextEditingController filterRulesCtl =
                    TextEditingController(text: tmpFilter.filter);

                ActionPane actionPane = ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.4,
                    children: [
                      SlidableAction(
                        label: 'delete'.tr,
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        onPressed: (c) async {
                          controller.removeFilter(e);
                        },
                      ),
                      SlidableAction(
                        label: 'edit'.tr,
                        backgroundColor: Colors.green,
                        icon: Icons.edit,
                        onPressed: (c) async {
                          pageCtl.tmpEditFilter(FilterBox.fromMap(e.toMap()));
                          pageCtl.idxeditTarget(idx);
                        },
                      )
                    ]);

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
                                    SizedBox(height: 10),
                                    TextFormField(
                                        // key: Key("${idx}"),
                                        controller: filterRulesCtl
                                          ..text = tmpFilter.filter,
                                        // ..text = tmpFilter.filter,
                                        // controller: filterRulesCtl,
                                        decoration: InputDecoration(
                                            labelText: "filter rules".tr,
                                            suffixIcon: IconButton(
                                                onPressed: () async {
                                                  String d =
                                                      await getClipboard();
                                                  filterRulesCtl..text = d;

                                                  tmpFilter.filter = d;
                                                },
                                                icon: Icon(Icons.paste))),
                                        // initialValue: tmpFilter.filter,
                                        onEditingComplete: () {
                                          rxFilter.refresh();
                                        },
                                        // onFieldSubmitted: (v) {},
                                        onChanged: (v) {
                                          tmpFilter.filter = v;
                                        }
                                        // => rxFilter.update((val) {
                                        //   tmpFilter.filter = v;
                                        //   filterRulesCtl.text = v;
                                        // }
                                        // ),
                                        ),
                                    SizedBox(height: 10),
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
                            SizedBox(height: 10),
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
                                          controller.filters[idx].expr = b!;
                                          controller.filters.refresh();
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
                                        var tmp = FilterBox.fromMap(
                                            tmpFilter.toMap());
                                        tmp.id = e.id;
                                        controller.filters[idx] = tmp;
                                        controller.filters.refresh();
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
                                    controller.filters[idx].enable = b!;
                                    controller.filters.refresh();
                                  }),
                        ],
                      )),
                ));
              }).toList(),
              ElevatedButton(
                  onPressed: () {
                    controller.filters.add(FilterBox());
                    // controller.filters.refresh();
                    // controller.addFilter(FilterBox());
                    // controller.userData.update((val) {
                    //   addFilter(Filter());
                    // });
                  },
                  child: Icon(Ionicons.add)),
            ],
          ),
        ],
      );
    });
  }
}
