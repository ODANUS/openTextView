import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_textview/component/hero_dialog_route.dart';

class LibraryFileViewer extends GetView {
  LibraryFileViewer({
    required this.fs,
    this.onDrageStart,
    this.onDrageEnd,
    this.onDirAddFile,
    this.onMergeFile,
    this.onReorder,
    this.onSelect,
  }) {}

  FileSystemEntity fs;
  Function(FileSystemEntity)? onDrageStart;
  Function(FileSystemEntity)? onDrageEnd;
  Function(Directory dir, File f)? onDirAddFile;
  Function(File f1, File f2)? onMergeFile;
  Function(File f1, File f2)? onReorder;
  Function(File f)? onSelect;

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
    var list = f.listSync();
    return Container(
        padding: EdgeInsets.all(5),
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            Badge(
              shape: BadgeShape.circle,
              animationType: BadgeAnimationType.fade,
              badgeColor: Colors.deepPurple,
              badgeContent: Text("${list.length}", style: TextStyle(color: Colors.white)),
              child: Icon(Icons.folder_open_outlined),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Center(
                child: Material(
                  type: MaterialType.transparency, // likely needed
                  child: Text(name, overflow: TextOverflow.fade),
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
    return cardBox(child: _directoryWidget(f), tag: name);
  }

  Widget _fileWidget(File f) {
    var name = f.path.split("/").last;
    String ex = name.split(".").last;
    return Container(
        padding: EdgeInsets.all(5),
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            if (ex == "txt") Icon(Icons.description_outlined),
            if (ex == "zip") Icon(Icons.folder_zip_outlined),
            if (ex == "epub") Icon(Icons.book_outlined),
            SizedBox(height: 5),
            Expanded(
              child: Center(
                child: Material(
                    type: MaterialType.transparency, // likely needed
                    child: Text(name, overflow: TextOverflow.fade)),
              ),
            )
          ],
        ));
  }

  Widget fileFeedbackWidget(File f) {
    return cardBox(child: _fileWidget(f), bcolor: true);
  }

  Widget fileWidget(File f) {
    return cardBox(child: _fileWidget(f));
  }

  @override
  Widget build(BuildContext context) {
    var name = fs.path.split("/").last;
    String ex = name.split(".").last;
    if (fs is Directory) {
      var list = (fs as Directory).listSync();
      list = list.getRange(0, min(4, list.length)).toList();
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16.w,
            height: 100.h,
          ),
          InkWell(
              onTap: () {
                var dir = fs as Directory;
                var allFileList = dir.listSync();
                var dirList = allFileList.where((e) => e is Directory).toList();
                var fileList = allFileList.where((e) => e is File).toList();
                fileList.sort((f1, f2) {
                  return (f1 as File).lastAccessedSync().compareTo((f2 as File).lastAccessedSync());
                });
                HeroPopup.open(
                    tag: name,
                    child: Card(
                        color: Theme.of(context).cardColor.withOpacity(0.9),
                        child: Container(
                            width: Get.width,
                            height: Get.height * 0.5,
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(name, style: Theme.of(context).textTheme.headline6),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                      padding: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 200),
                                      child: Wrap(
                                        spacing: 0,
                                        runSpacing: 0,
                                        children: [...dirList, ...fileList].map((e) {
                                          return LibraryFileViewer(
                                            fs: e,
                                            onDrageStart: onDrageStart,
                                            onDrageEnd: onDrageEnd,
                                            onDirAddFile: onDirAddFile,
                                            onMergeFile: onMergeFile,
                                          );
                                        }).toList(),
                                      ))),
                            ]))));
              },
              child: DragTarget<FileSystemEntity>(onAccept: (v) {
                if (v is File && onDirAddFile != null) {
                  onDirAddFile!((fs as Directory), v);
                }
              }, builder: (ctx, listItem, lstitem2) {
                var d = fs as Directory;
                if (listItem.isNotEmpty && listItem.first is File) {
                  return Container(
                    width: 100.w,
                    height: 100.h,
                    child: cardBox(child: Icon(Icons.note_add)),
                  );
                }
                // return directoryWidget(d);
                return LongPressDraggable(
                    onDragStarted: () {
                      if (onDrageStart != null) {
                        onDrageStart!(fs);
                      }
                    },
                    onDragEnd: (d) {
                      if (onDrageEnd != null) {
                        onDrageEnd!(fs);
                      }
                    },
                    data: d,
                    child: directoryWidget(d),
                    feedback: directoryFeedbackWidget(d));
              })),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DragTarget(builder: (ctx, listItem, lstitem2) {
          return Container(
            width: 16.w,
            height: 100.h,
            color: listItem.isNotEmpty && listItem.first is File ? Colors.green : null,
          );
        }),
        DragTarget<FileSystemEntity>(onAccept: (f) {
          if (onMergeFile != null && f is File && f != fs) {
            onMergeFile!((fs as File), f);
          }
        }, builder: (ctx, listItem, lstitem2) {
          var f = fs as File;
          if (listItem.isNotEmpty && listItem.first != f && listItem.first is File) {
            return Container(
              width: 100.w,
              height: 100.h,
              child: cardBox(child: Icon(Icons.folder)),
            );
          }

          return LongPressDraggable(
              data: f,
              onDragStarted: () {
                if (onDrageStart != null) {
                  onDrageStart!(f);
                }
              },
              onDragEnd: (d) {
                if (onDrageEnd != null) {
                  onDrageEnd!(f);
                }
              },
              child: fileWidget(f),
              feedback: fileFeedbackWidget(f));
        }),
      ],
    );
  }
}
