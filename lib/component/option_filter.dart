import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';

List<dynamic> DFFILTER = [
  {"name": "Chinese (Hanja) filter".tr, "expr": true, "filter": "[一-龥]", "to": '', 'enable': false},
  {"name": "Japanese (Japanese) filter".tr, "expr": true, "filter": "[ぁ-ゔ]|[ァ-ヴー]|[々〆〤]", "to": '', 'enable': false},
  {"name": "filter multiple question marks".tr, "expr": true, "filter": "\\?{1,}", "to": '?', 'enable': false},
  {"name": "Filter multiple exclamation marks".tr, "expr": true, "filter": "\\!{1,}", "to": '!', 'enable': false},
  {"name": "filter ----".tr, "expr": true, "filter": "-{2,}", "to": '', 'enable': false},
  {"name": "filter ===".tr, "expr": true, "filter": "={2,}", "to": '', 'enable': false},
  {"name": "filter .....".tr, "expr": true, "filter": "\\.{2,}|\\…{1,}", "to": '', 'enable': false},
  {"name": "filter ?!".tr, "expr": true, "filter": "\\?{1,}!{1,}", "to": '!', 'enable': false},
  {"name": "filter !?".tr, "expr": true, "filter": "!{1,}\\?{1,}", "to": '!', 'enable': false},
  {
    "name": "filter ?,!".tr,
    "expr": true,
    "filter": """"!"|"\\."|"\\?"|'!'|'\\?'|“\\.”|“!”|“\\?”|‘!’|‘\\?|\\[!\\]|\\[\\?\\]|\\[\\.\\]""",
    "to": '',
    'enable': false
  },
  {"name": "apostrophe filter".tr, "expr": false, "filter": "'", "to": '', 'enable': false},
  {
    "name": "special character repeat filter".tr,
    "expr": true,
    "filter": "\\&{2,}|\\#{2,}|\\@{2,}|\\\${2,}|~{1,}|\\*{2,}|\\[\\]|\\(\\)|\\{\\}",
    "to": '',
    'enable': true
  },
  {"name": "http...", "expr": true, "filter": "h.{0,3}t.{0,3}t.{0,3}p.+", "to": '', 'enable': true}
];

class OptionFilter extends GetView {
  Future<String> getClipboard() async {
    Map<String, dynamic>? result = await SystemChannels.platform.invokeMethod('Clipboard.getData');
    return result != null ? result["text"] : "";
  }

  @override
  Widget build(BuildContext context) {
    // final pageCtl = Get.put(OptionFilterCtl());

    return IsarCtl.rxFilter((ctx, filters) {
      return ExpansionTile(
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
                            IsarCtl.putFilter(FilterIsar.fromMap(e)..enable = true);
                          },
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(e['name']), Text(e['filter'])]))));
                }).toList()
              ])),
          ...filters.map((e) {
            // var idx = controller.filters.indexOf(e);
            // bool bedit = idx == pageCtl.idxeditTarget.value;
            // var tmpFilter = pageCtl.tmpEditFilter.value;
            // var rxFilter = pageCtl.tmpEditFilter;
            // TextEditingController filterRulesCtl = TextEditingController(text: tmpFilter.filter);

            return Card(
              child: ExpansionTile(
                childrenPadding: EdgeInsets.all(10),
                leading: Column(children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: e.enable,
                    onChanged: (b) => IsarCtl.putFilter(e..enable = !e.enable),
                  ),
                ]),
                title: Text(e.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("${e.filter}"),
                        Text("   ->   "),
                        Text("${e.to == "" ? "none".tr : e.to}"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${"Use regular expressions".tr} : "),
                        Checkbox(
                          value: e.expr,
                          onChanged: (b) {
                            IsarCtl.putFilter(e..expr = !e.expr);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                children: [
                  TextFormField(
                    initialValue: e.name,
                    decoration: InputDecoration(
                      labelText: "name".tr,
                    ),
                    onFieldSubmitted: (v) {
                      IsarCtl.putFilter(e..name = v);
                    },
                  ),
                  TextFormField(
                    initialValue: e.filter,
                    decoration: InputDecoration(
                      labelText: "filter rules".tr,
                    ),
                    onFieldSubmitted: (v) {
                      IsarCtl.putFilter(e..filter = v);
                    },
                  ),
                  TextFormField(
                    initialValue: e.to,
                    decoration: InputDecoration(
                      labelText: "change text".tr,
                    ),
                    onFieldSubmitted: (v) {
                      IsarCtl.putFilter(e..to = v);
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          IsarCtl.deleteFilter(e);
                        },
                        child: Text("delete".tr),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>? result = await SystemChannels.platform.invokeMethod('Clipboard.getData');
                var str = result != null ? result["text"] : "";
                IsarCtl.putFilter(FilterIsar(filter: str));
              },
              child: Icon(Ionicons.add)),
        ],
      );
    });
  }
}
