import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:isar/isar.dart';

import 'package:open_textview/component/option_theme.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';

class CompUiSetting extends GetView {
  CompUiSetting({
    required this.setting,
  }) {}
  SettingIsar setting;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0,
          toolbarHeight: 0,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(height: 51.h, iconMargin: EdgeInsets.zero, icon: Icon(Icons.find_in_page_outlined), text: "page_search".tr),
              Tab(height: 51.h, iconMargin: EdgeInsets.zero, icon: Icon(Icons.low_priority), text: "move_location".tr),
              Tab(height: 51.h, iconMargin: EdgeInsets.zero, icon: Icon(Icons.aspect_ratio), text: "UI Settings".tr),
              // Tab(
              //     height: 51.h,
              //     iconMargin: EdgeInsets.zero,
              //     icon: Icon(Icons.sort_by_alpha),
              //     text: "Font settings".tr),
              Tab(height: 51.h, iconMargin: EdgeInsets.zero, icon: Icon(Icons.space_dashboard), text: "layout Setting".tr),
              Tab(height: 51.h, iconMargin: EdgeInsets.zero, icon: Icon(Icons.content_copy_outlined), text: "Copy content".tr),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PageSearch(),
            MoveLocation(),
            UiSetting(setting: setting),
            // Tab(icon: Icon(Icons.directions_bike)),
            // Tab(icon: Icon(Icons.directions_bike)),
            LayoutSetting(setting: setting),
            CopyText(
              history: IsarCtl.lastHistory,
              contents: IsarCtl.contents,
            ),
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  IsarCtl.bSetting(false);
                },
                child: Text("close".tr)),
          ],
        ),
      ),
    );
  }
}

class CopyText extends GetView {
  CopyText({
    this.history,
    this.contents,
  });
  HistoryIsar? history;
  ContentsIsar? contents;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (history == null || contents == null) {
      return SizedBox();
    }
    int startPos = history!.cntntPstn;
    return Container(
        padding: EdgeInsets.all(10.w),
        color: Colors.black26,
        child: ObxValue((RxString keyword) {
          List<ContentsIsar> findDatas = [];
          if (keyword.isNotEmpty) {
            findDatas = IsarCtl.isar.contentsIsars.where().filter().textContains(keyword.value).findAllSync();
          }
          return Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    child: Text("for adding filters".tr, softWrap: true, maxLines: 3),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: Card(
                    child: ListView(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 100),
                  children: [
                    SelectableText(contents!.text.substring(startPos, min(contents!.text.length, startPos + 1000))),
                    // ...findDatas.map((e) {
                    //   return Card(
                    //     child: ListTile(
                    //         onTap: () {
                    //           IsarCtl.tctl.cntntPstn = e.idx;
                    //         },
                    //         leading: Text("${e.idx}"),
                    //         title: Text(e.text)),
                    //   );
                    // }).toList(),
                  ],
                )),
              )
            ],
          );
        }, "".obs));
  }
}

class UiSetting extends GetView {
  UiSetting({
    required this.setting,
  });
  SettingIsar setting;
  openColorPicker(int colorData, Function(Color) fn, {bool balpha = true}) {
    Get.dialog(
      AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: MediaQuery.of(Get.context!).orientation == Orientation.portrait
              ? const BorderRadius.vertical(
                  top: Radius.circular(500),
                  bottom: Radius.circular(100),
                )
              : const BorderRadius.horizontal(right: Radius.circular(500)),
        ),
        content: SingleChildScrollView(
          child: HueRingPicker(
            portraitOnly: false,
            pickerColor: Color(colorData),
            onColorChanged: (c) {
              fn(c);
            },
            enableAlpha: balpha,
            displayThumbColor: true,
          ),
        ),
      ),
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 40.w, right: 40.w),
        color: Colors.black26,
        child: Column(
          children: [
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  //  테마
                  Card(
                      child: OptionTheme(
                    value: setting.theme,
                    onChanged: (v) {
                      if (v == "light") {
                        Get.changeTheme(ThemeData.light());
                      } else {
                        Get.changeTheme(ThemeData.dark());
                      }
                      IsarCtl.putSetting(setting..theme = v);
                    },
                  )),
                  // 클립보드
                  // Card(
                  //     child: OptionClipboard(
                  //   value: setting.useClipboard,
                  //   onChanged: (v) {
                  //     IsarCtl.putSetting(setting..useClipboard = v);
                  //   },
                  // )),
                  // 여백
                  Card(
                      child: ListTile(
                    title: Text("padding".tr),
                    subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Row(children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              double p = min(50, setting.paddingLeft + 1).round().toDouble();
                              IsarCtl.putSetting(setting..paddingLeft = p);
                            },
                            icon: Text("+")),
                        Text("${setting.paddingLeft.toInt()}"),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              double p = max(0, setting.paddingLeft - 1).round().toDouble();

                              IsarCtl.putSetting(setting..paddingLeft = p);
                            },
                            icon: Text("-")),
                      ]),
                      Column(
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                double p = min(50, setting.paddingTop + 1);
                                IsarCtl.putSetting(setting..paddingTop = p);
                              },
                              icon: Text("+")),
                          Text("${setting.paddingTop.toInt()}"),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                double p = max(0, setting.paddingTop - 1);
                                IsarCtl.putSetting(setting..paddingTop = p);
                              },
                              icon: Text("-")),
                          Divider(),
                          Icon(Icons.phone_android_outlined),
                          Divider(),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                double p = max(0, setting.paddingBottom - 1).round().toDouble();

                                IsarCtl.putSetting(setting..paddingBottom = p);
                              },
                              icon: Text("-")),
                          Text("${setting.paddingBottom.toInt()}"),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                double p = min(50, setting.paddingBottom + 1).round().toDouble();

                                IsarCtl.putSetting(setting..paddingBottom = p);
                              },
                              icon: Text("+")),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                double p = max(0, setting.paddingRight - 1).round().toDouble();
                                IsarCtl.putSetting(setting..paddingRight = p);
                              },
                              icon: Text("-")),
                          Text("${setting.paddingRight.toInt()}"),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                double p = min(50, setting.paddingRight + 1).round().toDouble();

                                IsarCtl.putSetting(setting..paddingRight = p);
                              },
                              icon: Text("+")),
                        ],
                      )
                    ]),
                  )),
                  // 색상 설정 부분
                  Card(
                    child: ListTile(
                      leading: Container(width: 30, height: 30, color: Color(setting.backgroundColor)),
                      title: Text("Background Color".tr),
                      trailing: ElevatedButton(
                          onPressed: () {
                            IsarCtl.putSetting(setting..backgroundColor = 0x00FFFFFF);
                          },
                          child: Text("delete".tr)),
                      onTap: () {
                        var c = setting.backgroundColor;

                        openColorPicker(c, (c) {
                          IsarCtl.putSetting(setting..backgroundColor = c.value);
                        }, balpha: true);
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Container(width: 30, height: 30, color: Color(setting.fontColor)),
                      title: Text("Font Color".tr),
                      trailing: ElevatedButton(
                          onPressed: () {
                            IsarCtl.putSetting(setting..fontColor = 0);
                          },
                          child: Text("delete".tr)),
                      onTap: () {
                        var themeTextColor = Theme.of(context).textTheme.bodyText1!.color!.value;
                        var c = setting.fontColor == 0 ? themeTextColor : setting.fontColor;

                        openColorPicker(c, (c) {
                          IsarCtl.putSetting(setting..fontColor = c.value);
                        }, balpha: false);
                      },
                    ),
                  ),
                  Card(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("bg image settings".tr, style: TextStyle(fontSize: 16.sp)),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ListView(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: IsarCtl.listBg
                                .asMap()
                                .map((k, e) {
                                  if (k == 0) {
                                    return MapEntry(
                                        k,
                                        InkWell(
                                            onTap: () {
                                              IsarCtl.putSetting(setting..bgIdx = k);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                width: 100,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: Colors.black38,
                                                  child: Text("none".tr),
                                                ))));
                                  }
                                  return MapEntry(
                                      k,
                                      InkWell(
                                          onTap: () {
                                            if (setting.theme == "light") {
                                              IsarCtl.putSetting(setting
                                                ..bgIdx = k
                                                ..bgFilter = 0xD0000000);
                                            } else {
                                              IsarCtl.putSetting(setting
                                                ..bgIdx = k
                                                ..bgFilter = 0x45000000);
                                            }
                                            // IsarCtl.putSetting(setting..bgFilter = c.value);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              width: 100,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage('assets/images/${IsarCtl.listBg[k]}'),
                                                  ),
                                                ),
                                              ))));
                                })
                                .values
                                .toList(),
                          )),
                      ListTile(
                        leading: Container(width: 30, height: 30, color: Color(setting.bgFilter)),
                        title: Text("bg image filter settings".tr, style: TextStyle(fontSize: 12.sp)),
                        trailing: ElevatedButton(
                            onPressed: () {
                              IsarCtl.putSetting(setting..bgFilter = 0x00FFFFFF);
                            },
                            child: Text("delete".tr)),
                        onTap: () {
                          var themeTextColor = Theme.of(context).textTheme.bodyText1!.color!.value;
                          var c = setting.bgFilter == 0 ? themeTextColor : setting.bgFilter;

                          openColorPicker(c, (c) {
                            IsarCtl.putSetting(setting..bgFilter = c.value);
                          }, balpha: true);
                        },
                      ),
                    ]),
                  ),
                  // 글꼴 설정 부분
                  Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: ListTile(
                          title: Text("font size setting".tr),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    IsarCtl.putSetting(setting..fontSize = max(setting.fontSize - 1, 18));
                                  },
                                  icon: Icon(Ionicons.remove_outline)),
                              Text("${setting.fontSize}"),
                              IconButton(
                                  onPressed: () {
                                    IsarCtl.putSetting(setting..fontSize = min(setting.fontSize + 1, 40));
                                  },
                                  icon: Icon(Ionicons.add_outline)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("font weight setting".tr),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    IsarCtl.putSetting(setting..fontWeight = max(setting.fontWeight - 1, 0));
                                  },
                                  icon: Icon(Ionicons.remove_outline)),
                              Text("${setting.fontWeight}"),
                              IconButton(
                                  onPressed: () {
                                    IsarCtl.putSetting(setting..fontWeight = min(setting.fontWeight + 1, 8));
                                  },
                                  icon: Icon(Ionicons.add_outline)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("font height setting".tr),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    var t = double.parse((setting.fontHeight - 0.1).toStringAsFixed(1));
                                    IsarCtl.putSetting(setting..fontHeight = t);
                                  },
                                  icon: Icon(Ionicons.remove_outline)),
                              Text("${setting.fontHeight}"),
                              IconButton(
                                  onPressed: () {
                                    var t = double.parse((setting.fontHeight + 0.1).toStringAsFixed(1));
                                    IsarCtl.putSetting(setting..fontHeight = t);
                                  },
                                  icon: Icon(Ionicons.add_outline)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("letter_spacing".tr),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    var t = double.parse((setting.letterSpacing - 0.1).toStringAsFixed(1));
                                    IsarCtl.putSetting(setting..letterSpacing = t);
                                  },
                                  icon: Icon(Ionicons.remove_outline)),
                              Text("${setting.letterSpacing}"),
                              IconButton(
                                  onPressed: () {
                                    var t = double.parse((setting.letterSpacing + 0.1).toStringAsFixed(1));
                                    IsarCtl.putSetting(setting..letterSpacing = t);
                                  },
                                  icon: Icon(Ionicons.add_outline)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Font settings".tr),
                          subtitle: Column(
                            children: [
                              ...IsarCtl.listFont.map((e) {
                                var ff = setting.fontFamily;
                                if (ff.isEmpty) {
                                  ff = "default";
                                }
                                return RadioListTile(
                                    title: Text(e),
                                    value: e,
                                    groupValue: ff,
                                    onChanged: (String? f) {
                                      if (f == 'default') {
                                        IsarCtl.putSetting(setting..fontFamily = "");
                                      } else {
                                        IsarCtl.putSetting(setting..fontFamily = f!);
                                      }
                                    });
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            )
          ],
        ));
  }
}

class LayoutSetting extends GetView {
  LayoutSetting({
    required this.setting,
  });
  SettingIsar setting;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(10.w),
        color: Colors.black26,
        child: Column(
          children: [
            Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1.1, //item 의 가로 1, 세로 2 의 비율
                  mainAxisSpacing: 2, //수평 Padding
                  crossAxisSpacing: 2, //수직 Padding
                ),
                itemCount: 6,
                itemBuilder: (ctx, idx) {
                  return Card(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          InkWell(
                            onTap: () {
                              IsarCtl.putSetting(setting..touchLayout = idx);
                            },
                            child: Container(
                                height: 100,
                                child: ReadpageOverlay(
                                  bScreenHelp: true,
                                  touchLayout: idx,
                                )),
                          ),
                          Radio(
                              value: idx,
                              groupValue: setting.touchLayout,
                              onChanged: (_) {
                                IsarCtl.putSetting(setting..touchLayout = idx);
                              })
                        ])),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class MoveLocation extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(10.w),
        alignment: Alignment.center,
        // color: Colors.black26,
        child: ObxValue((RxInt position) {
          TextEditingController c = TextEditingController()..text = position.toString();
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "${"Current_location".tr} : $position / ${IsarCtl.contents.text.length}  (${(position / IsarCtl.contents.text.length * 100).toStringAsFixed(2)}%)"),
                  Slider(
                      value: position.toDouble(),
                      min: 0,
                      max: IsarCtl.contents.text.length.toDouble(),
                      divisions: IsarCtl.contents.text.length,
                      label: "${position.toInt()}",
                      onChanged: (v) {
                        position(v.toInt());
                      },
                      onChangeEnd: (double v) {
                        IsarCtl.tctl.setCntntPstn(v.toInt(), offsetY: 0.0);
                        IsarCtl.tctl.notifyListeners();
                        // IsarCtl.tctl.cntntPstn = v.toInt();
                        // IsarCtl.tctl.offsetY = 0;
                      }),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "move_location".tr,
                    ),
                    controller: c,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (v) {
                      if (v.isEmpty) return;
                      int tidx = int.parse(v);
                      if (tidx < IsarCtl.contents.text.length) {
                        IsarCtl.tctl.setCntntPstn(tidx, offsetY: 0.0);
                        IsarCtl.tctl.notifyListeners();
                        position(tidx);
                        // IsarCtl.cntntPstn = tidx;
                        // IsarCtl.tctl.cntntPstn = tidx;
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }, IsarCtl.cntntPstn.obs));
  }
}

class PageSearch extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(10.w),
        color: Colors.black26,
        child: ObxValue((RxString keyword) {
          Map<int, String> findDatas = {};
          if (keyword.isNotEmpty && keyword.value.length >= 2) {
            var contents = IsarCtl.contents.text;

            int lastIdx = 0;
            for (var i = 0; i < 30; i++) {
              int idx = contents.indexOf(keyword);
              if (idx < 0) {
                break;
              }
              findDatas[lastIdx + idx] = contents.substring(max(idx - 5, 0), min(idx + 20, contents.length - 1));
              contents = contents.substring(min(idx + 20, contents.length - 1));
              lastIdx += idx;
            }
            // var textList = IsarCtl.contents.text.split("\n");
            // textList.asMap().forEach((k, e) {
            //   if (e.contains(keyword)) {
            //     var idx = textList.getRange(0, k).join("\n").length;
            //     findDatas[idx] = e;
            //   }
            // });
            // findDatas = ;
          }
          return Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Please enter word".tr,
                    ),
                    // onChanged: (v) {
                    //   keyword(v);
                    // },
                    onSubmitted: (v) {
                      keyword(v);
                    },
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView(
                  children: [
                    ...findDatas
                        .map((k, e) {
                          return MapEntry(
                              k,
                              Card(
                                child: ListTile(
                                    onTap: () {
                                      IsarCtl.tctl.setCntntPstn(k, offsetY: 0.0);
                                      IsarCtl.tctl.notifyListeners();
                                    },
                                    // leading: Text("${e}"),
                                    title: Text(e)),
                              ));
                        })
                        .values
                        .toList(),
                  ],
                ),
              )
            ],
          );
        }, "".obs));
  }
}
