import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Widget cardBox({required Widget child, bool? bcolor, String? tag}) {
    return Card(
        margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        color: bcolor == null || !bcolor ? null : Theme.of(Get.context!).cardColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: tag != null ? Hero(tag: tag, child: child) : child);
  }

  Widget _directoryWidget(Directory f) {
    var name = f.path.split("/").last;
    if (IsarCtl.libPDir.value == f) {
      name = "../";
    }
    var list = f.listSync();
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0x40fdcc6f),
        ),
        padding: EdgeInsets.all(5),
        width: 100.w,
        height: 110.h,
        child: Column(
          children: [
            Badge(
              shape: BadgeShape.circle,
              animationType: BadgeAnimationType.fade,
              badgeColor: Colors.deepPurple,
              badgeContent: Text("${list.length}", style: TextStyle(color: Colors.white)),
              child: Icon(
                Icons.folder_rounded,
                color: Color(0xFFfdcc6f),
                size: 40.sp,
              ),
            ),
            Expanded(
              child: Center(
                child: Material(
                  type: MaterialType.transparency, // likely needed
                  child: Text(name, overflow: TextOverflow.fade, textWidthBasis: TextWidthBasis.longestLine),
                ),
              ),
            )
          ],
        ));
  }

  Widget directoryFeedbackWidget(Directory f) {
    var name = f.path.split("/").last;
    return cardBox(child: _directoryWidget(f), bcolor: true, tag: name);
  }

  Widget directoryWidget(Directory f) {
    var name = f.path.split("/").last;
    return cardBox(child: _directoryWidget(f));
  }

  Widget _fileWidget(File f) {
    var name = f.path.split("/").last;
    String ex = name.split(".").last;
    var history = IsarCtl.historyByName(name);

    var c = Color(0x2068bef7);
    if (ex == "zip") c = Color(0x7067c99d);
    if (ex == "epub") c = Color(0x20f39e7e);

    return Material(
        type: MaterialType.transparency, // likely needed
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: c,
            ),
            padding: EdgeInsets.all(5),
            width: 100.w,
            height: 110.h,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    if (ex == "txt") Icon(Icons.description_rounded, size: 28.sp, color: Color(0x9068bef7)),
                    if (ex == "zip") Icon(Icons.folder_zip_rounded, size: 35.sp, color: Color(0xFF67c99d)),
                    if (ex == "epub") Icon(Icons.book_rounded, size: 35.sp, color: Color(0x90f39e7e)),
                    Container(
                        padding: EdgeInsets.only(top: 15.sp, left: 35.sp),
                        child: Text(
                          ex,
                          style: TextStyle(fontSize: 13.sp),
                        )),
                  ],
                ),
                SizedBox(height: 1),
                if (history != null) Text("${Utils.rdgPos(history)}"),
                if (history != null) Text("${"memo".tr}:${history.memo}", overflow: TextOverflow.ellipsis),
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
    return cardBox(child: _fileWidget(f), bcolor: true);
  }

  Widget fileWidget(File f) {
    return InkWell(onTap: () => openMenu(f), child: cardBox(child: _fileWidget(f), tag: f.path));
  }

  Widget changeNameWidget(File f) {
    var ex = f.path.split(".").last;
    var fileName = f.path.split("/").last;
    var name = f.path.split("/").last.split(".").first;
    return ObxValue<RxBool>((bedit) {
      return bedit.value
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
          : Wrap(
              children: [
                Text(
                  fileName,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(width: 10),
                InkWell(onTap: () => bedit(!bedit.value), child: Icon(Icons.edit_outlined))
              ],
            );
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
                            return Container(
                              width: 100.w,
                              height: 117.h,
                              child: cardBox(child: Icon(Icons.upload_file)),
                            );
                          }
                          if (listItem.isNotEmpty && listItem.first is File) {
                            return Container(
                              width: 100.w,
                              height: 117.h,
                              child: cardBox(child: Icon(Icons.note_add)),
                            );
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
                    DragTarget(onAccept: (v) {
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
                      if (listItem.isNotEmpty && listItem.first != f && listItem.first is File) {
                        return Container(
                          width: 100.w,
                          height: 117.h,
                          child: cardBox(child: Icon(Icons.folder)),
                        );
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
