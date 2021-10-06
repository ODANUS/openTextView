import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/utils.dart';

class LibraryPageCtl extends GetxController {
  final libList = [];

  // @override
  // void onInit() {
  //   final ctl = Get.find<GlobalController>();
  //   ever(ctl.libraryPaths, (callback) {
  //     print("[[[[[[[[[[[[[[[[[[[[[[[${callback}");
  //     getLib(callback as List<String>);
  //   });
  //   getLib(ctl.libraryPaths);
  //   // TODO: implement onInit
  //   super.onInit();
  // }
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
              controller.libraryPaths.refresh();
            },
            child: ListView(
              padding: EdgeInsets.all(10),
              children: controller.libraryPaths.map((e) {
                int idx = controller.libraryPaths.indexOf(e);
                return Card(
                    child: InkWell(
                        onLongPress: () async {
                          var rtn = await OpenModal.openModalSelect(
                              title: "해당 서재를 삭제 하시겠습니까?");
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
                                onTab: (File f) async {
                                  String contents = await Utils.readFile(f);
                                  if (f.path.split(".").last == "json") {
                                    final LocalStorage storage =
                                        new LocalStorage('opentextview');
                                    await storage.ready;
                                    var json = jsonDecode(contents);
                                    var m =
                                        json['config'] as Map<String, dynamic>;
                                    var l = json['history'] as List;
                                    await storage.setItem(
                                        'config', (m.obs).toJson());
                                    await storage.setItem(
                                        'history', (l.obs).toJson());
                                    return;
                                  }
                                  controller.setContents(contents);
                                  controller.tabIndex(0);
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
      required this.onTab,
      this.exs = const ["txt", "json"]});
  String path;
  Function onTab;
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
            // snapshot.data!.sort((a, b) {
            //   (a as File).lastModified()

            // }  return
            return Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    ...snapshot.data!.map((e) {
                      if (e is Directory) {
                        return Card(
                            child: ExpansionTile(
                                leading: Icon(Ionicons.folder_outline),
                                title: Text(e.path.split("/").last),
                                children: [
                              DirectoryListWidget(path: e.path, onTab: onTab)
                            ]));
                      }
                      var f = e as File;
                      var ex = f.path.split(".").last;
                      bool bex = exs.indexOf(ex) >= 0;
                      int bytes = f.lengthSync();
                      String size = Utils.getFileSize(f);
                      return Card(
                          child: ListTile(
                        onTap: bex ? () => onTab(e) : null,
                        leading: Icon(Ionicons.document_outline),
                        title: Text(e.path.split("/").last,
                            style: TextStyle(color: bex ? null : Colors.grey)),
                        trailing: Text("${size}"),
                      ));
                    }).toList()
                  ],
                ));
          }
          return Text("");
        });
  }
}
