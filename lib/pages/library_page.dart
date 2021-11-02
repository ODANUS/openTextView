import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryPageCtl extends GetxController {
  final libList = [];
  RxList<String> delList = RxList<String>();
  RxString tmpDir = "".obs;
  RxBool reload = false.obs;

  @override
  void onInit() async {
    var tmp = await getTemporaryDirectory();
    var dir = Directory("${tmp.path}/file_picker");

    if (dir.existsSync()) {
      tmpDir(dir.path);
    }
    super.onInit();
  }
}

class LibraryPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(LibraryPageCtl());
    String path = controller.lastData.value.path;
    List<History> listHistory = controller.userData.value.history;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("내서재"),
      ),
      body: Obx(() {
        // Utils.getLibraryList(controller.libraryPaths.first);
        return RefreshIndicator(
            onRefresh: () async {
              pageCtl.tmpDir.refresh();
              // pageCtl.delList.clear();
              // controller.libraryPaths.refresh();
            },
            child: ListView(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 150),
                children: [
                  Card(
                      child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("파일 추가시 길게 눌러 여러개를 추가 할 수 있습니다."),
                  )),
                  ...[pageCtl.tmpDir.value].map((e) {
                    if (e == "") {
                      return SizedBox();
                    }
                    int idxOf = path.indexOf(e);
                    return Card(
                        child: InkWell(
                            // onLongPress: () async {
                            //   var rtn = await OpenModal.openModalSelect(
                            //       title:
                            //           "해당 서재를 리스트 에서 제거 하시겠습니까?\n(데이터는 삭제 되지 않습니다.)");
                            //   if (rtn == true) {
                            //     controller.libraryPaths.remove(e);
                            //   }
                            // },
                            child: ExpansionTile(
                                // initiallyExpanded: idx == 0,
                                initiallyExpanded: true,
                                title: Text('파일목록'), //Text(e.split("/").last),
                                children: [
                          DirectoryListWidget(
                            path: e,
                            delList: pageCtl.delList,
                            historylist: listHistory,
                            curOpenPath: path,
                            onTab: (File f) async {
                              controller.openFile(f);
                            },
                            onDeleteFile: (File f) async {
                              var status = await Permission.storage.status;
                              if (!status.isGranted) {
                                await Permission.storage.request();
                              }
                              await f.delete();
                              pageCtl.delList.add(f.path);
                            },
                            // onDeleteDir: (Directory d) async {
                            //   var status = await Permission.storage.status;
                            //   if (!status.isGranted) {
                            //     await Permission.storage.request();
                            //   }
                            //   await d.delete(recursive: true);
                            //   pageCtl.delList.add(d.path);
                            // },
                          )
                        ])));
                  }).toList(),
                ]));
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // pageCtl.getLib(controller.libraryPaths);
          // var path = await Utils.selectLibrary();
          var path = await Utils.selectFile();
          // controller.libraryPaths.refresh();
          pageCtl.tmpDir.refresh();
          // print(path);
          // if (path != null) {
          //   controller.addLibrary(path);
          // }
        },
        label: Text('파일 추가'),
        icon: Icon(Ionicons.add),
      ),
    );
  }
}

class DirectoryListWidget extends GetView {
  DirectoryListWidget({
    required this.path,
    required this.delList,
    required this.onTab,
    required this.historylist,
    this.curOpenPath = "",
    this.exs = const [
      "txt",
      // "gif",
      // "png",
      // "jpg",
      // "tiff",
      // "zip",
    ],
    required this.onDeleteFile,
    // required this.onDeleteDir,
  });
  String path;
  List<String> delList;
  Function onTab;
  List<String> exs;
  String curOpenPath;
  List<History> historylist;
  Function(File) onDeleteFile;
  // Function(Directory) onDeleteDir;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: Utils.getLibraryList(path),
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            snapshot.data!.sort((a, b) {
              if (a is File && b is File) {
                return a.path.split("/").last.compareTo(b.path.split("/").last);
              }
              if (a is Directory) {
                return -2;
              }
              return 1;
            });
            if (snapshot.data!.isEmpty) {
              return SizedBox();
            }
            // snapshot.data!.sort((a, b) {
            //   (a as File).lastModified()

            // }  return
            return Obx(() {
              var dellis = delList;

              return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      ...snapshot.data!.map((e) {
                        if (dellis.indexOf(e.path) >= 0) {
                          return SizedBox();
                        }
                        if (e is Directory) {
                          // Widget delIcon = IconSlideAction(
                          //   caption: '삭제',
                          //   color: Colors.red,
                          //   icon: Icons.delete,
                          //   onTap: () {
                          //     onDeleteDir(e as Directory);
                          //   },
                          // );
                          int idxOf = curOpenPath.indexOf(e.path);

                          return Card(
                              child: Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.2,
                                  // secondaryActions: [delIcon],
                                  // actions: [delIcon],
                                  child: ExpansionTile(
                                      initiallyExpanded: idxOf >= 0,
                                      leading: Icon(Ionicons.folder_outline),
                                      title: Text(e.path.split("/").last),
                                      children: [
                                        DirectoryListWidget(
                                          path: e.path,
                                          delList: delList,
                                          historylist: historylist,
                                          onTab: onTab,
                                          onDeleteFile: onDeleteFile,
                                          // onDeleteDir: onDeleteDir,
                                        )
                                      ])));
                        }
                        var f = e as File;
                        String ex = "";
                        var exList = f.path.split(".");
                        if (exList.isNotEmpty) {
                          ex = exList.last.toLowerCase();
                        }
                        bool bex = exs.indexOf(ex) >= 0;
                        String size = Utils.getFileSize(f);
                        Widget delIcon = IconSlideAction(
                          caption: '서재에서 제거',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            onDeleteFile(f);
                          },
                        );
                        String name = e.path.split("/").last;
                        List<History> targetList = historylist.where((e) {
                          return e.name == name;
                        }).toList();

                        return Card(
                            child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                // actionExtentRatio: 0.2,
                                secondaryActions: [delIcon],
                                actions: [delIcon],
                                child: ListTile(
                                  onTap: bex ? () => onTab(e) : null,
                                  leading: Icon(Ionicons.document_outline),
                                  title: Text(e.path.split("/").last,
                                      style: TextStyle(
                                          color: bex ? null : Colors.grey)),
                                  subtitle: targetList.isNotEmpty &&
                                          targetList.first.length > 0 &&
                                          ex == "txt"
                                      ? Text(
                                          '${(targetList.first.pos / targetList.first.length * 100).toStringAsFixed(2)}%')
                                      : Text(''),
                                  trailing: Text("${size}"),
                                )));
                      }).toList()
                    ],
                  ));
            });
          }
          return Text("");
        });
  }
}
