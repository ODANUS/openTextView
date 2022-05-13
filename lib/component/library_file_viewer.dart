import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_textview/component/hero_dialog_route.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:open_textview/provider/svg_data.dart';
import 'package:open_textview/provider/utils.dart';

class LibraryFileViewer extends GetView {
  LibraryFileViewer();

  // Directory dir;
  // Directory? parentDir;

  RxBool bDrag = false.obs;
  RxString dragEx = "".obs;
  RxBool reload = false.obs;
  RxList<File> mergeList = RxList<File>();
  final _listViewKey = GlobalKey();

  final ScrollController _scroller = ScrollController();

  var rootName = Platform.isAndroid ? "file_picker" : "com.khjde.openTextview-Inbox";
  // bool bScreenHelp;
  // int touchLayout;
  // BoxDecoration? decoration;
  // Function? onBackpage;
  // Function? onFullScreen;
  // Function? onNextpage;
  Widget cardBox({required Widget child, required FileSystemEntity f, bool? bcolor, String? tag, bool? bIcon}) {
    var cardW = 100.sp;
    var cardH = 130.sp;
    if (f is File) {
      var ex = f.path.split(".").last;
      Color bgColor = Color(0xFF2e9bdf);
      if (ex == "zip") {
        return Material(
            type: MaterialType.transparency, // likely needed
            child: Container(
              width: cardW,
              height: cardH,
              child: Stack(alignment: Alignment.topCenter, children: [
                SvgData.zip(),
                Container(
                  margin: EdgeInsets.only(right: 11.sp, bottom: 10.sp),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    Utils.getFileSize(f),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 90.w,
                      margin: EdgeInsets.only(bottom: 28.sp, right: 11.sp),
                      // alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
                      decoration: BoxDecoration(color: Colors.purple),
                      child: Text(
                        "ZIP",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.sp),
                      )),
                ),
                if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
                if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
              ]),
            ));
      }
      if (ex == "epub") {
        return Material(
            type: MaterialType.transparency, // likely needed
            child: Container(
              width: cardW,
              height: cardH,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                SvgData.epub(),
                Container(
                  margin: EdgeInsets.only(right: 5.sp, top: 15.sp),
                  alignment: Alignment.topRight,
                  child: Text(
                    Utils.getFileSize(f),
                    style: TextStyle(fontSize: 10.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 5.sp, top: 10.sp),
                      padding: EdgeInsets.only(left: 7.sp, right: 7.sp, top: 5.sp, bottom: 5.sp),
                      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15)),
                      child: Text(ex.toUpperCase())),
                ),
                if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
                if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
              ]),
            ));
      }
      if (ex == "pdf") bgColor = Color(0xFFc10103);
      return Material(
          type: MaterialType.transparency, // likely needed
          child: Container(
            width: cardW,
            height: cardH,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              SvgData.file(bgColor),
              Container(
                margin: EdgeInsets.only(left: 0, top: 5.sp),
                alignment: Alignment.topRight,
                child: Transform.rotate(
                    angle: 45 * pi / 180,
                    origin: Offset(-20, 2),
                    child: Text(
                      Utils.getFileSize(f),
                      style: TextStyle(fontSize: 10.sp),
                    )),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.sp, top: 10.sp),
                        padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
                        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15)),
                        child: Text(ex.toUpperCase()),
                      ),
                    ],
                  )),
              if (bIcon != null && bIcon) Container(alignment: Alignment.center, child: tag != null ? Hero(tag: tag, child: child) : child),
              if (bIcon == null || !bIcon) tag != null ? Hero(tag: tag, child: child) : child,
            ]),
          ));
    }
    if (f is Directory) {
      var list = f.listSync();
      return Material(
          type: MaterialType.transparency, // likely needed
          child: Container(
            width: cardW,
            height: cardH,
            child: Stack(alignment: Alignment.topCenter, children: [
              SvgData.dir(),
              Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 10.sp, bottom: 20.sp),
                    padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
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
          width: 90.sp,
          height: 80.sp,
          // color: Colors.red,
          padding: EdgeInsets.only(top: 20.sp),
          // transformAlignment: Alignment.bottomCenter,
          alignment: Alignment.topCenter,
          child: Text(name, overflow: TextOverflow.fade, textWidthBasis: TextWidthBasis.longestLine, style: TextStyle(fontSize: 12.sp)),
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
            width: 90.sp,
            height: 80.sp,
            padding: EdgeInsets.only(bottom: 10.sp),
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
                    child: Text(name, overflow: TextOverflow.fade, textWidthBasis: TextWidthBasis.longestLine, style: TextStyle(fontSize: 12.sp)),
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

  Widget changeNameWidget(File f, {HistoryIsar? history}) {
    var ex = f.path.split(".").last;
    var fileName = f.path.split("/").last;
    var name = f.path.split("/").last.split(".").first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ObxValue<RxBool>((bedit) {
          return Container(
              padding: EdgeInsets.only(bottom: 10.sp),
              child: bedit.value
                  ? TextFormField(
                      initialValue: name,
                      onFieldSubmitted: (v) {
                        bedit(false);
                        fileName = "$v.$ex";
                        if (history != null) {
                          history.name = fileName;
                          IsarCtl.putHistory(history);
                        }
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
        }, false.obs),
        Text(Utils.getFileSize(f)),
        SizedBox(height: 10),
      ],
    );
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
                        changeNameWidget(f, history: history),
                        if (kDebugMode)
                          ElevatedButton(
                              onPressed: () {
                                Utils.saveAs(f);
                              },
                              child: Text("save")),
                        // if (kDebugMode)
                        //   Card(
                        //       child: ListTile(
                        //           onTap: () async {
                        //             Get.toNamed("/editor", arguments: f.path);
                        //           },
                        //           title: Text("편집".tr))),
                        if (Get.locale != null && Get.locale!.languageCode == "ko")
                          Card(
                              child: ListTile(
                                  onTap: () async {
                                    Get.back();
                                    if (await Utils.newLineTheoremFile(f, useKss: true)) {
                                      reload(!reload.value);
                                    }
                                  },
                                  title: Text("kss 개행정리".tr))),
                        Card(
                            child: ListTile(
                                onTap: () async {
                                  Get.back();
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
                                  } else {
                                    Get.dialog(AlertDialog(
                                      content: Text("Decompression failed".tr),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("".tr)),
                                      ],
                                    ));
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
          child: Listener(
            onPointerMove: (PointerMoveEvent event) {
              if (!bDrag.value) {
                return;
              }

              RenderBox render = _listViewKey.currentContext?.findRenderObject() as RenderBox;
              Offset position = render.localToGlobal(Offset.zero);
              double topY = position.dy;
              double bottomY = topY + render.size.height;

              const detectedRange = 70;
              const moveDistance = 3;
              if (event.position.dy < topY + detectedRange) {
                var to = _scroller.offset - moveDistance;
                to = (to < 0) ? 0 : to;
                _scroller.jumpTo(to);
              }
              if (event.position.dy > bottomY - detectedRange && event.position.dx < Get.width / 2.1 && dragEx.value == "txt") {
                return;
              }
              if (event.position.dy > bottomY - detectedRange) {
                _scroller.jumpTo(_scroller.offset + moveDistance);
              }
            },
            child: SingleChildScrollView(
              key: _listViewKey,
              controller: _scroller,
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
                            if (d.path.split("/").last != rootName) {
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
                                Get.snackbar("duplicate file name".tr, "There are files".tr, snackPosition: SnackPosition.bottom);
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
        ),
        // if (!bDrag.value)
        //   Card(
        //     child: Text("Long press on".tr),
        //   ),
        if (IsarCtl.libPDir.value != null && !bDrag.value)
          ObxValue<RxBool>((bedit) {
            var pathArr = IsarCtl.libDir.value.path.split("/");
            var name = pathArr.last;
            var rootIdx = pathArr.indexOf(rootName);
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
