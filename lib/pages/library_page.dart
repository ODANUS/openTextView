import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryPageCtl extends GetxController {
  final libList = [];
  RxList<String> delList = RxList<String>();
  RxString tmpDir = "".obs;

  @override
  void onInit() async {
    tmpDir((await getTemporaryDirectory()).path);
    super.onInit();
  }
}

class LibraryPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(LibraryPageCtl());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("내서재"),
      ),
      body: Obx(() {
        if (controller.libraryPaths.isEmpty) {
          Text("서재 를 추가해 주세요.");
        }
        // Utils.getLibraryList(controller.libraryPaths.first);
        return RefreshIndicator(
            onRefresh: () async {
              pageCtl.delList.clear();
              controller.libraryPaths.refresh();
            },
            child: ListView(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 150),
              children:
                  [...controller.libraryPaths, pageCtl.tmpDir.value].map((e) {
                if (e == "") {
                  return SizedBox();
                }
                return Card(
                    child: InkWell(
                        onLongPress: () async {
                          var rtn = await OpenModal.openModalSelect(
                              title:
                                  "해당 서재를 리스트 에서 제거 하시겠습니까?\n(데이터는 삭제 되지 않습니다.)");
                          if (rtn == true) {
                            controller.libraryPaths.remove(e);
                          }
                        },
                        child: ExpansionTile(
                            // initiallyExpanded: idx == 0,
                            title: Text(e.split("/").last),
                            children: [
                              DirectoryListWidget(
                                path: e,
                                delList: pageCtl.delList,
                                onTab: (File f) async {
                                  String contents = await Utils.readFile(f);
                                  // if (f.path.split(".").last == "json") {
                                  //   final LocalStorage storage =
                                  //       new LocalStorage('opentextview');
                                  //   await storage.ready;
                                  //   var json = jsonDecode(contents);
                                  //   var m =
                                  //       json['config'] as Map<String, dynamic>;
                                  //   var l = json['history'] as List;
                                  //   await storage.setItem(
                                  //       'config', (m.obs).toJson());
                                  //   await storage.setItem(
                                  //       'history', (l.obs).toJson());
                                  //   return;
                                  // }
                                  controller.setContents(contents);
                                  controller.tabIndex(0);
                                },
                                onDeleteFile: (File f) async {
                                  var status = await Permission.storage.status;
                                  if (!status.isGranted) {
                                    await Permission.storage.request();
                                  }
                                  await f.delete();
                                  pageCtl.delList.add(f.path);
                                },
                                onDeleteDir: (Directory d) async {
                                  var status = await Permission.storage.status;
                                  if (!status.isGranted) {
                                    await Permission.storage.request();
                                  }

                                  await d.delete(recursive: true);
                                  pageCtl.delList.add(d.path);
                                },
                              )
                            ])));
              }).toList(),
            ));
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // pageCtl.getLib(controller.libraryPaths);
          var path = await Utils.selectLibrary();
          if (path != null) {
            print(path);
            controller.addLibrary(path);
          }
        },
        label: Text('서재 추가'),
        icon: Icon(Ionicons.add),
      ),
    );
  }
}

class DirectoryListWidget extends GetView {
  DirectoryListWidget(
      {required this.path,
      required this.delList,
      required this.onTab,
      required this.onDeleteFile,
      required this.onDeleteDir,
      this.exs = const ["txt"]});
  String path;
  List<String> delList;
  Function onTab;
  Function(File) onDeleteFile;
  Function(Directory) onDeleteDir;
  List<String> exs;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: Utils.getLibraryList(path),
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          print(snapshot.connectionState);
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
                          Widget delIcon = IconSlideAction(
                            caption: '삭제',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              onDeleteDir(e as Directory);
                            },
                          );
                          return Card(
                              child: Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.2,
                                  secondaryActions: [delIcon],
                                  actions: [delIcon],
                                  child: ExpansionTile(
                                      leading: Icon(Ionicons.folder_outline),
                                      title: Text(e.path.split("/").last),
                                      children: [
                                        DirectoryListWidget(
                                            path: e.path,
                                            delList: delList,
                                            onTab: onTab,
                                            onDeleteFile: onDeleteFile,
                                            onDeleteDir: onDeleteDir)
                                      ])));
                        }
                        var f = e as File;

                        var ex = f.path.split(".").last;
                        bool bex = exs.indexOf(ex) >= 0;
                        String size = Utils.getFileSize(f);
                        Widget delIcon = IconSlideAction(
                          caption: '삭제',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            onDeleteFile(f);
                          },
                        );
                        return Card(
                            child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.2,
                                secondaryActions: [delIcon],
                                actions: [delIcon],
                                child: ListTile(
                                  onTap: bex ? () => onTab(e) : null,
                                  leading: Icon(Ionicons.document_outline),
                                  title: Text(e.path.split("/").last,
                                      style: TextStyle(
                                          color: bex ? null : Colors.grey)),
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
