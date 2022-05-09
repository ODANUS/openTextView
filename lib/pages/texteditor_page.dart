import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TextEditorPage extends GetView {
  TextEditorPage() {
    if (Get.arguments is String) {
      f = File(Get.arguments);
      content(f.readAsStringSync().split("\n"));
    }
  }
  late File f;
  RxList<String> content = [""].obs;
  RxInt perLineNum = 0.obs;
  RxInt nextLineNum = 0.obs;
  RxString keyWord = "".obs;
  RxString endkeyWord = "".obs;
  RxString tokeyWord = "".obs;
  RxInt editorType = 0.obs;

  List<String> editorTypeStr = ["글자 바꾸기", "패턴 바꾸기", "라인 바꾸기"];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("편집")),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Obx(() {
                    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      ...editorTypeStr
                          .asMap()
                          .map((k, str) {
                            return MapEntry(
                                k,
                                Row(children: [
                                  Radio<int>(value: k, groupValue: editorType.value, onChanged: (v) => editorType(v)),
                                  Text(str),
                                ]));
                          })
                          .values
                          .toList(),
                    ]);
                  }),
                  Obx(() {
                    if (editorType.value == 0) {
                      return Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "검색할 단어".tr,
                            ),
                            onFieldSubmitted: (s) {
                              keyWord(s);
                            },
                          )),
                          Icon(Icons.arrow_right),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "변경 할 단어".tr,
                            ),
                            onFieldSubmitted: (s) {
                              tokeyWord(s);
                            },
                          )),
                          // ElevatedButton(onPressed: () {}, child: Text("찾기")),
                        ],
                      );
                    }
                    if (editorType.value == 1) {
                      return Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "시작 단어".tr,
                            ),
                            onFieldSubmitted: (s) {
                              keyWord(s);
                            },
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 1, right: 5),
                            child: Text("~"),
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "끝 단어".tr,
                            ),
                            onFieldSubmitted: (s) {
                              endkeyWord(s);
                            },
                          )),
                          Icon(Icons.arrow_right),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "변경할 단어".tr,
                            ),
                            onFieldSubmitted: (s) {
                              tokeyWord(s);
                            },
                          )),
                          // ElevatedButton(onPressed: () {}, child: Text("찾기")),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  perLineNum(max(--perLineNum.value, 0));
                                },
                                icon: Icon(Icons.remove)),
                            Text("$perLineNum"),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  perLineNum(min(++perLineNum.value, 20));
                                },
                                icon: Icon(Icons.add)),
                            //
                            Expanded(
                                child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "검색 단어".tr,
                              ),
                              onFieldSubmitted: (s) {
                                keyWord(s);
                              },
                            )),
                            //
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  nextLineNum(max(--nextLineNum.value, 0));
                                },
                                icon: Icon(Icons.remove)),
                            Text("$nextLineNum"),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  nextLineNum(min(++nextLineNum.value, 20));
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "변경할 단어".tr,
                          ),
                          onFieldSubmitted: (s) {
                            tokeyWord(s);
                          },
                        )
                      ],
                    );
                  }),
                  SizedBox(height: 5.h),
                  Flexible(
                      flex: 2,
                      child: Obx(() {
                        var listIdx = [];
                        for (var i = 0; i < content.length; i++) {
                          var c = content[i];
                          if (c.contains(keyWord) && keyWord.isNotEmpty) {
                            listIdx.add(i);
                          }
                        }
                        return ListView.builder(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                            itemCount: listIdx.length,
                            itemBuilder: (ctx, idx) {
                              var v = listIdx[idx];
                              return Card(
                                  child: InkWell(
                                onTap: () {
                                  itemScrollController.jumpTo(index: v);
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(content[v]),
                                            Center(child: Icon(Icons.arrow_drop_down)),
                                            Obx(() => Text(content[v].replaceAll(keyWord.value, tokeyWord.value))),
                                          ],
                                        )),
                                        ElevatedButton(
                                            onPressed: () {
                                              content[v] = content[v].replaceAll(keyWord.value, tokeyWord.value);
                                              content.refresh();
                                            },
                                            child: Text("변환")),
                                      ],
                                    )),
                              ));
                            });
                      })),
                  Divider(),
                  Flexible(
                      flex: 3,
                      child: Obx(() {
                        return ScrollablePositionedList.builder(
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            padding: EdgeInsets.only(left: 5, right: 5, top: 50, bottom: 100),
                            itemCount: content.length,
                            itemBuilder: (ctx, idx) {
                              return SelectableText(content[idx]);
                            });
                      })),
                ],
              ))),
      bottomNavigationBar: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              Get.back();
            },
            child: Text("cancel".tr)),
        ElevatedButton(
          onPressed: () {
            f.writeAsStringSync(content.join("\n"));
            Get.back();
          },
          child: Text("confirm".tr),
        ),
      ]),
    );
  }
}