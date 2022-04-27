import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_textview/component/hero_dialog_route.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/provider/utils.dart';

class LibraryFileViewer extends GetView {
  LibraryFileViewer();

  // Directory dir;
  // Directory? parentDir;

  RxBool bDrag = false.obs;
  RxString dragEx = "".obs;
  RxBool reload = false.obs;
  RxList<File> mergeList = RxList<File>();

  // bool bScreenHelp;
  // int touchLayout;
  // BoxDecoration? decoration;
  // Function? onBackpage;
  // Function? onFullScreen;
  // Function? onNextpage;
  Widget cardBox({required Widget child, required FileSystemEntity f, bool? bcolor, String? tag, bool? bIcon}) {
    if (f is File) {
      var ex = f.path.split(".").last;
      Color bgColor = Color(0xFF2e9bdf);
      if (ex == "zip") {
        bgColor = Color(0xFF68c99e);
        var bg = SvgPicture.string(
          """<svg width="19" height="24" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24">
            <g class="layer">
              <title>Layer 1</title>
              <g id="svg_1">
              <rect fill="none" height="20" id="svg_2" width="16.1" x="-0.1" y="0"/>
              </g>
              <g id="svg_3" transform="rotate(90, 9.56, 11.95)">
              <path d="m19.12,4.78l-9.56,0l-2.39,-2.39l-7.17,0c-1.31,0 -2.38,1.08 -2.38,2.39l-0.01,14.34c0,1.31 1.08,2.39 2.39,2.39l19.12,0c1.31,0 2.39,-1.08 2.39,-2.39l0,-11.95c0,-1.31 -1.08,-2.39 -2.39,-2.39zm-2.39,7.17l-2.39,0l0,2.39l2.39,0l0,2.39l-2.39,0l0,2.39l-2.39,0l0,-2.39l2.39,0l0,-2.39l-2.39,0l0,-2.39l2.39,0l0,-2.39l-2.39,0l0,-2.39l2.39,0l0,2.39l2.39,0l0,2.39z" id="svg_4"/>
              </g>
            </g>
            </svg>""",
          width: 100.w,
          height: 130.h,
          color: bgColor.withOpacity(0.5),
        );
        return Material(
            type: MaterialType.transparency, // likely needed
            child: Container(
              width: 100.w,
              height: 130.h,
              child: Stack(alignment: Alignment.topCenter, children: [
                bg,
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 90.w,
                      margin: EdgeInsets.only(bottom: 30.h, right: 11.w),
                      // alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: BoxDecoration(color: Colors.purple),
                      child: Text(
                        "ZIP",
                        textAlign: TextAlign.center,
                      )),
                ),
                if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
                if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
              ]),
            ));
      }
      if (ex == "epub") {
        bgColor = Color(0xFF81bb0e);
        var bg = SvgPicture.string(
          """<svg width="19" height="24" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path d="m0,0l24,0l0,24l-24,0l0,-24z" fill="none" id="svg_1" transform="matrix(1, 0, 0, 1, 0, 0)"/>
  <path d="m16.71,0l-14.33,0c-1.31,0 -2.39,1.07 -2.39,2.39l0,19.1c0,1.31 1.07,2.39 2.39,2.39l14.33,0c1.31,0 2.39,-1.07 2.39,-2.39l0,-19.1c0,-1.31 -1.07,-2.39 -2.39,-2.39zm-14.33,2.39l5.97,0l0,9.55l-2.98,-1.79l-2.98,1.79l0,-9.55l-0.01,0z" id="svg_2"/>
 </g>

</svg>""",
          width: 100.w,
          height: 130.h,
          color: bgColor.withOpacity(0.5),
        );
        double lrPadding = ex.toLowerCase() == "epub" ? 7 : 10;
        return Material(
            type: MaterialType.transparency, // likely needed
            child: Container(
              width: 100.w,
              height: 130.h,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                bg,
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 8, top: 20),
                      padding: EdgeInsets.only(left: lrPadding, right: lrPadding, top: 5, bottom: 5),
                      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15)),
                      child: Text(ex.toUpperCase())),
                ),
                if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
                if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
              ]),
            ));
      }
      if (ex == "pdf") bgColor = Color(0xFFc10103);

      var bg = SvgPicture.string(
        """<svg width="19" height="24" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
          <g class="layer">
            <title>Layer 1</title>
            <path d="m0,0l24,0l0,24l-24,0l0,-24z" fill="none" id="svg_1"/>
            <path d="m2.38,0c-1.31,0 -2.36,1.07 -2.36,2.38l-0.01,19c0,1.31 1.06,2.38 2.36,2.38l14.26,0c1.31,0 2.38,-1.07 2.38,-2.38l0,-14.25l-7.13,-7.13l-9.5,0zm8.31,8.31l0,-6.53l6.53,6.53l-6.53,0z" id="svg_2"/>
            <path d="m10.54,8.54l-0.14,-7.64l7.6,7.3c0,0 -1.66,0.94 -1.66,0.94c0,0 -5.8,-0.6 -5.8,-0.6z" id="svg_5" >
          </g>
          </svg>""",
        width: 100.w,
        height: 130.h,
        color: bgColor.withOpacity(0.5),
      );
      double lrPadding = ex.toLowerCase() == "epub" ? 7 : 10;
      return Material(
          type: MaterialType.transparency, // likely needed
          child: Container(
            width: 100.w,
            height: 130.h,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              bg,
              Container(
                alignment: Alignment.topLeft,
                transformAlignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 8, top: 20),
                    padding: EdgeInsets.only(left: lrPadding, right: lrPadding, top: 5, bottom: 5),
                    decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15)),
                    child: Text(ex.toUpperCase())),
              ),
              if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
              if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
            ]),
          ));
    }
    if (f is Directory) {
      Color bgColor = Color(0xFF2e9bdf);
      var list = f.listSync();
//  fill-opacity="50%"
      var bg = SvgPicture.string(
        """<svg width="16" height="20" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
              <path d="m2.12,0.5c-1.06,0 -1.92,0.84 -1.92,1.87l-0.01,14.99c0,1.03 0.86,1.87 1.92,1.87l11.59,0c1.06,0 1.93,-0.84 1.93,-1.87l0,-11.24l-5.79,-5.62l-7.72,0zm6.75,6.56l0,-5.15l5.31,5.15l-5.31,0z" id="svg_3" fill="#FFF" fill-opacity="0.6"/>
              <path d="m16.06,8.06l0,-6c0,-1.1 -0.9,-1.99 -2,-1.99l-12,-0.01c-1.1,0 -2,0.9 -2,2l0,16c0,1.1 0.9,2 2,2l10,0c1.1,0 2,-0.9 2,-2l0,-8l2,-2z" id="svg_2" fill="#e2bb70" fill-opacity="0.9"/>
            </svg>""",
        width: 100.w,
        height: 130.h,
        // color: bgColor.withOpacity(0.3),
      );
      return Material(
          type: MaterialType.transparency, // likely needed
          child: Container(
            width: 100.w,
            height: 130.h,
            child: Stack(alignment: Alignment.topCenter, children: [
              bg,
              Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 10, bottom: 20),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(10)),
                    child: Text("${list.length}")),
              ),
              if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
              if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
            ]),
          ));
    }
    return SizedBox();
    // return Card(
    //     margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
    //     color: bcolor == null || !bcolor ? null : Theme.of(Get.context!).cardColor.withOpacity(0.5),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(15.0),
    //     ),
    //     child: tag != null ? Hero(tag: tag, child: child) : child);
  }

  Widget _directoryWidget(Directory f) {
    var name = f.path.split("/").last;
    if (IsarCtl.libPDir.value == f) {
      name = "../";
    }
    return Material(
        type: MaterialType.transparency, // likely needed
        child: Container(
          width: 90.w,
          height: 80.h,
          // color: Colors.red,
          padding: EdgeInsets.only(top: 20),
          // transformAlignment: Alignment.bottomCenter,
          alignment: Alignment.topCenter,
          child: Text(name, overflow: TextOverflow.fade, textWidthBasis: TextWidthBasis.longestLine),
        ));
  }

  Widget directoryFeedbackWidget(Directory f) {
    var name = f.path.split("/").last;
    return cardBox(child: _directoryWidget(f), f: f, bcolor: true, tag: name);
  }

  Widget directoryWidget(Directory f) {
    var name = f.path.split("/").last;
    return cardBox(child: _directoryWidget(f), f: f);
  }

  Widget _fileWidget(File f) {
    var name = f.path.split("/").last;
    String ex = name.split(".").last;
    var history = IsarCtl.historyByName(name);

    return Material(
        type: MaterialType.transparency, // likely needed
        child: Container(
            width: 90.w,
            height: 80.h,
            padding: EdgeInsets.only(bottom: 10),
            transformAlignment: Alignment.bottomCenter,
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 1),
                if (history != null) Text("${Utils.rdgPos(history)}"),
                SizedBox(height: 1),
                Expanded(
                  child: Center(
                    child: Text(name, overflow: TextOverflow.fade, textWidthBasis: TextWidthBasis.longestLine),
                  ),
                )
              ],
            )));
  }

  Widget fileFeedbackWidget(File f) {
    return cardBox(child: _fileWidget(f), f: f, bcolor: true);
  }

  Widget fileWidget(File f) {
    return InkWell(onTap: () => openMenu(f), child: cardBox(child: _fileWidget(f), f: f, tag: f.path));
  }

  Widget changeNameWidget(File f) {
    var ex = f.path.split(".").last;
    var fileName = f.path.split("/").last;
    var name = f.path.split("/").last.split(".").first;
    return ObxValue<RxBool>((bedit) {
      return Container(
          padding: EdgeInsets.only(bottom: 15),
          child: bedit.value
              ? TextFormField(
                  initialValue: name,
                  onFieldSubmitted: (v) {
                    bedit(false);
                    fileName = "$v.$ex";
                    name = v;
                    var pathArr = f.path.split("/");
                    var fullpath = pathArr.getRange(0, pathArr.length - 1).join("/");
                    f.renameSync("$fullpath/$fileName");
                    reload(!reload.value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () => bedit(false),
                      child: Icon(Icons.close),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        fileName,
                        style: TextStyle(fontSize: 16.sp),
                        softWrap: true,
                      ),
                    ),
                    SizedBox(width: 3),
                    InkWell(
                        onTap: () => bedit(!bedit.value),
                        child: Icon(
                          Icons.edit_outlined,
                          // size: 10,
                        )),
                  ],
                ));
    }, false.obs);
  }

  openMenu(File f) {
    var ex = f.path.split(".").last;
    var fileName = f.path.split("/").last;
    var name = f.path.split("/").last.split(".").first;
    var history = IsarCtl.historyByName(fileName);

    if (ex == "txt") {
      HeroPopup.open(
          tag: f.path,
          child: Container(
            width: Get.width * 0.7,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        changeNameWidget(f),
                        Card(
                            child: ListTile(
                                onTap: () async {
                                  if (await Utils.newLineTheoremFile(f)) {
                                    reload(!reload.value);
                                  }
                                },
                                title: Text("newline theorem".tr))),
                        if (history != null)
                          ObxValue<RxBool>((bedit) {
                            return Wrap(
                              children: [
                                bedit.value
                                    ? TextFormField(
                                        initialValue: history.memo,
                                        onFieldSubmitted: (v) {
                                          history.memo = v;
                                          IsarCtl.putHistory(history);
                                          bedit(false);
                                          reload(!reload.value);
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                            onTap: () => bedit(false),
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        child: ListTile(
                                        onTap: () => bedit(!bedit.value),
                                        title: Text("${"memo".tr}: ${history.memo}"),
                                        trailing: Icon(Icons.edit_outlined),
                                      )),
                              ],
                            );
                          }, false.obs),
                        Card(
                            child: ListTile(
                                tileColor: Colors.blue.withOpacity(0.5),
                                // tileColor:
                                onTap: () {
                                  IsarCtl.openFile(f);
                                  Get.back();
                                },
                                title: Text("open".tr))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    }
    if (ex == "zip") {
      HeroPopup.open(
          tag: f.path,
          child: Container(
            width: Get.width * 0.7,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        changeNameWidget(f),
                        Card(
                            child: ListTile(
                                tileColor: Colors.blue.withOpacity(0.5),
                                onTap: () async {
                                  Get.back();
                                  if (await Utils.ocrZipFile(f)) {
                                    reload(!reload.value);
                                  }
                                },
                                title: Text("OCR".tr))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    }
    if (ex == "epub") {
      HeroPopup.open(
          tag: f.path,
          child: Container(
            width: Get.width * 0.7,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        changeNameWidget(f),
                        Card(
                            child: ListTile(
                                tileColor: Colors.blue.withOpacity(0.5),
                                onTap: () async {
                                  Get.back();
                                  if (await Utils.epubConv(f)) {
                                    reload(!reload.value);
                                  }
                                },
                                title: Text("text conv".tr))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    }
    if (ex == "pdf") {
      HeroPopup.open(
          tag: f.path,
          child: Container(
            width: Get.width * 0.7,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        changeNameWidget(f),
                        Card(
                            child: ListTile(
                                tileColor: Colors.blue.withOpacity(0.5),
                                onTap: () async {
                                  Get.back();
                                  if (await Utils.pdfConv(f)) {
                                    reload(!reload.value);
                                  }
                                },
                                title: Text("text conv".tr))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    }
    // ------if
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      reload.value;
      List<FileSystemEntity> list = [];
      List<FileSystemEntity> dirList = [];
      List<FileSystemEntity> fileList = [];
      List<FileSystemEntity> totalList = [];

      if (IsarCtl.libSearchText.value.isNotEmpty) {
        list = IsarCtl.libDir.value.listSync(recursive: true);
        fileList = list.where((e) {
          if (e is File) {
            return e.path.split("/").last.contains(IsarCtl.libSearchText.value);
          }
          return false;
        }).toList();
        fileList.sort((v1, v2) => (v2 as File).lastAccessedSync().compareTo((v1 as File).lastAccessedSync()));
        totalList.addAll(fileList);
      } else {
        list = IsarCtl.libDir.value.listSync();
        dirList = list.where((e) => e is Directory).toList();
        fileList = list.where((e) => e is File).toList();
        fileList.sort((v1, v2) => (v2 as File).lastAccessedSync().compareTo((v1 as File).lastAccessedSync()));
        totalList = IsarCtl.libPDir.value == null ? [] : [IsarCtl.libPDir.value!];
        totalList.addAll(dirList);
        totalList.addAll(fileList);
      }
      if (totalList.isEmpty) {
        return Center(child: Text("Click the +".tr));
      }
      return Stack(alignment: AlignmentDirectional.topCenter, children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 60.h, bottom: 190.h, left: 0, right: 0),
            child: Wrap(
              runSpacing: 0,
              children: totalList.map((e) {
                if (e is Directory) {
                  Directory d = e;
                  // var list = d.listSync();
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 16.w, height: 110.h),
                      InkWell(
                        onTap: () {
                          IsarCtl.libPDir.value = null;
                          if (d.path.split("/").last != 'file_picker') {
                            IsarCtl.libPDir(d.parent);
                          }
                          IsarCtl.libPDir.refresh();
                          IsarCtl.libDir(d);
                          reload(!reload.value);
                        },
                        child: DragTarget<FileSystemEntity>(onAccept: (v) {
                          if (e.path != v.path) {
                            var name = v.path.split("/").last;
                            var reName = "${e.path}/$name";
                            if (File(reName).existsSync()) {
                              Get.snackbar("duplicate file name".tr, "There are files".tr, snackPosition: SnackPosition.BOTTOM);
                              reName = "${reName}";
                            } else {
                              v.renameSync(reName);
                            }
                            reload(!reload.value);
                            bDrag(false);
                          }
                        }, builder: (ctx, listItem, lstitem2) {
                          if (listItem.isNotEmpty && IsarCtl.libPDir.value == e) {
                            return cardBox(child: Icon(Icons.upload_file), f: e, bIcon: true);
                          }
                          if (listItem.isNotEmpty && listItem.first is File) {
                            return cardBox(child: Icon(Icons.note_add), f: e, bIcon: true);
                          }
                          if (IsarCtl.libPDir.value == e) {
                            return directoryWidget(e);
                          }
                          // return directoryWidget(d);
                          return LongPressDraggable(
                              onDragStarted: () {
                                bDrag(true);
                                dragEx("dir");
                              },
                              onDragEnd: (d) {
                                bDrag(false);
                                dragEx("");
                              },
                              data: d,
                              child: directoryWidget(d),
                              feedback: directoryFeedbackWidget(d));
                        }),
                      )
                    ],
                  );
                }
                var f = (e as File);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DragTarget(onAccept: (v) {
                      try {
                        if (v is File) {
                          var fromIdx = fileList.indexOf(v);
                          var toIdx = fileList.indexOf(e);
                          DateTime startDate = DateTime.now();
                          DateTime endDate;
                          if (toIdx > 0) {
                            startDate = (fileList[toIdx - 1] as File).lastAccessedSync();
                          }
                          endDate = (e as File).lastAccessedSync();
                          int df = startDate.difference(endDate).inMicroseconds ~/ 2;
                          v.setLastAccessedSync(endDate.add(Duration(microseconds: df)));
                          reload(!reload.value);
                        }
                      } catch (e) {}
                    }, builder: (ctx, listItem, lstitem2) {
                      Color? color = null;

                      if (listItem.isNotEmpty && listItem.first is File) {
                        color = Colors.green;
                      }

                      return Obx(() {
                        if (bDrag.value && color == null) {
                          color = Colors.green.withOpacity(0.1);
                        }
                        if (!bDrag.value || dragEx.value == "dir") {
                          color = null;
                        }

                        return Container(
                          width: 16.w,
                          height: 110.h,
                          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
                          child: bDrag.value && dragEx.value != "dir" ? Icon(Icons.horizontal_distribute, size: 8.sp) : null,
                        );
                      });
                    }),
                    DragTarget<FileSystemEntity>(onAccept: (v) {
                      try {
                        if (v is File && v.path != e.path) {
                          var pathList = e.path.split("/");
                          var path = pathList.sublist(0, pathList.length - 1).join("/");
                          var fileName = pathList.last.split(".").first;
                          var f1name = e.path.split("/").last;
                          var f2name = v.path.split("/").last;
                          var dir = Directory("${path}/${fileName}");
                          if (!dir.existsSync()) {
                            dir.createSync();
                          }
                          e.renameSync("${dir.path}/$f1name");
                          v.renameSync("${dir.path}/$f2name");
                          reload(!reload.value);
                        }
                      } catch (e) {}
                      bDrag(false);
                    }, builder: (ctx, listItem, lstitem2) {
                      if (listItem.isNotEmpty && listItem.first!.path != f.path && listItem.first is File) {
                        return cardBox(child: Icon(Icons.folder), f: e, bIcon: true);
                      }

                      return LongPressDraggable(
                          data: e,
                          onDragStarted: () {
                            var ex = e.path.split(".").last;
                            bDrag(true);
                            dragEx(ex);
                          },
                          onDragEnd: (d) {
                            bDrag(false);
                            dragEx("");
                          },
                          onDraggableCanceled: (v, o) {
                            bDrag(false);
                            dragEx("");
                          },
                          child: fileWidget(f),
                          feedback: fileFeedbackWidget(f));
                    }),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        // if (!bDrag.value)
        //   Card(
        //     child: Text("Long press on".tr),
        //   ),
        if (IsarCtl.libPDir.value != null && !bDrag.value)
          ObxValue<RxBool>((bedit) {
            var pathArr = IsarCtl.libDir.value.path.split("/");
            var name = pathArr.last;
            var rootIdx = pathArr.indexOf("file_picker");
            var curPath = pathArr.getRange(rootIdx + 1, pathArr.length).join("/");
            return Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                child: bedit.value
                    ? Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          initialValue: name,
                          onFieldSubmitted: (v) {
                            name = v;
                            var fullpath = pathArr.getRange(0, pathArr.length - 1).join("/");
                            IsarCtl.libDir(IsarCtl.libDir.value.renameSync("$fullpath/$name"));
                            IsarCtl.libDir.refresh();
                            bedit(false);
                            reload(!reload.value);
                          },
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => bedit(false),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ))
                    : Wrap(
                        children: [
                          Text(
                            curPath,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          // Text(curPath),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              bedit(!bedit.value);
                            },
                            child: Icon(Icons.edit_outlined),
                          ),
                        ],
                      ));
          }, false.obs),
        Obx(() {
          if (bDrag.value) {
            return Container(
                width: Get.width - 15,
                child: DragTarget<FileSystemEntity>(onAccept: (v) {
                  if (v is File || v is Directory) {
                    v.deleteSync(recursive: true);
                    bDrag(false);
                    reload(!reload.value);
                  }
                }, builder: (ctx, listItem, lstitem2) {
                  var c = Colors.red.withOpacity(0.2);
                  if (listItem.isNotEmpty) {
                    c = Colors.red.withOpacity(0.8);
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          color: c,
                          child: Icon(Icons.delete_forever_outlined),
                        ),
                      ),
                      // Flexible(child: Icon(Icons.)),
                    ],
                  );
                }));
          }
          return SizedBox();
        }),
        Obx(() {
          if (bDrag.value && dragEx.value == "txt" && mergeList.isEmpty) {
            return Container(
                width: Get.width - 15,
                alignment: Alignment.bottomLeft,
                child: Container(
                    width: Get.width / 2,
                    alignment: Alignment.bottomLeft,
                    child: DragTarget<FileSystemEntity>(onAccept: (v) {
                      if (v is File) {
                        mergeList.add(v);
                      }
                    }, builder: (ctx, listItem, lstitem2) {
                      var c = Colors.green.withOpacity(0.5);
                      if (listItem.isNotEmpty) {
                        c = Colors.green;
                      }
                      return Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: c,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.join_full),
                              Text("Merge files".tr),
                            ],
                          ));
                    })));
          }
          return SizedBox();
        }),
        Obx(() {
          if (mergeList.length > 0) {
            return Container(
                width: Get.width - 15,
                alignment: Alignment.bottomLeft,
                child: Container(
                    width: Get.width / 2,
                    alignment: Alignment.bottomLeft,
                    child: DragTarget<FileSystemEntity>(onAccept: (v) {
                      if (v is File) {
                        mergeList.add(v);
                      }
                    }, builder: (ctx, listItem, lstitem2) {
                      var c = Colors.green.withOpacity(0.8);
                      if (listItem.isNotEmpty) {
                        c = Colors.green;
                      }
                      return Container(
                          constraints: new BoxConstraints(
                            minHeight: 60,
                            maxHeight: 200,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: c,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(children: [
                            Text("${"total".tr}: ${mergeList.length}"),
                            Expanded(
                                child: ListView(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              children: mergeList.map((e) {
                                return Text(e.path.split("/").last);
                              }).toList(),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.red),
                                    onPressed: () {
                                      mergeList.clear();
                                    },
                                    child: Text("cancel".tr)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.green),
                                  onPressed: () async {
                                    await Get.toNamed("/merge", arguments: mergeList);
                                    reload(!reload.value);
                                  },
                                  child: Text("merge".tr),
                                )
                              ],
                            ),
                          ]));
                    })));
          }
          return SizedBox();
        }),
      ]);
    });
  }
}
