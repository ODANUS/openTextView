import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/Ads.dart';
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
  RxList<String> sortList = ["name", "size", "date"].obs;
  RxString sortTarget = "name".obs;
  RxBool asc = true.obs;

  @override
  void onInit() async {
    loadtmpDir();
    debounce(tmpDir, (v) => loadtmpDir());
    super.onInit();
  }

  void loadtmpDir() async {
    var tmp = await getTemporaryDirectory();
    var dir = Directory("${tmp.path}/file_picker");
    if (dir.existsSync()) {
      tmpDir(dir.path);
    }
  }
}

class LibraryPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(LibraryPageCtl());
    String path = controller.lastData.value.path;
    List<History> listHistory = controller.userData.value.history;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("my_library".tr),
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 2, bottom: 2), child: AdsComp()),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...ctl.sortList.map((e) {
                  ButtonStyle? style =
                      ElevatedButton.styleFrom(primary: Colors.grey);
                  if (ctl.sortTarget == e) {
                    style = null;
                  }
                  return ElevatedButton(
                      style: style,
                      onPressed: () {
                        ctl.sortTarget(e);
                        ctl.asc(!ctl.asc.value);
                      },
                      child: Row(children: [
                        Text(e),
                        if (ctl.sortTarget.contains(e) && ctl.asc.value)
                          Icon(Icons.arrow_drop_up)
                        else if (ctl.sortTarget.contains(e) && !ctl.asc.value)
                          Icon(Icons.arrow_drop_down)
                      ]));
                })
              ],
            )),
        Divider(),
        Expanded(
          child: Obx(() {
            Directory dir = Directory(ctl.tmpDir.value);
            var fileList = dir.listSync(recursive: true);
            if (ctl.sortTarget.contains("name")) {
              fileList.sort((e1, e2) {
                String name1 = e1.path.split("/").last;
                String name2 = e2.path.split("/").last;

                if (ctl.asc.value) {
                  return name1.compareTo(name2);
                } else {
                  return name2.compareTo(name1);
                }
              });
            }
            if (ctl.sortTarget.contains("size")) {
              fileList.sort((e1, e2) {
                int size1 = (e1 as File).lengthSync();
                int size2 = (e2 as File).lengthSync();
                if (ctl.asc.value) {
                  return size1.compareTo(size2);
                } else {
                  return size2.compareTo(size1);
                }
              });
            }
            if (ctl.sortTarget.contains("date")) {
              fileList.sort((e1, e2) {
                DateTime date1 = (e1 as File).lastModifiedSync();
                DateTime date2 = (e2 as File).lastModifiedSync();
                if (ctl.asc.value) {
                  return date1.compareTo(date2);
                } else {
                  return date2.compareTo(date1);
                }
              });
            }
            return RefreshIndicator(
                onRefresh: () async {
                  ctl.tmpDir.refresh();
                },
                child: ListView(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 30, bottom: 150),
                    children: [
                      ...fileList.map((e) {
                        File file = e as File;
                        Widget delIcon = IconSlideAction(
                          caption: 'remove_from_library'.tr,
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await file.delete();
                            ctl.tmpDir.refresh();
                          },
                        );
                        String ex = "";
                        var exList = file.path.split(".");
                        if (exList.isNotEmpty) {
                          ex = exList.last.toLowerCase();
                        }
                        String name = file.path.split("/").last;
                        List<History> targetList = listHistory.where((e) {
                          return e.name == name;
                        }).toList();
                        String size = Utils.getFileSize(file);
                        return Card(
                            child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                // actionExtentRatio: 0.2,
                                secondaryActions: [delIcon],
                                actions: [delIcon],
                                child: ListTile(
                                  leading: Icon(Ionicons.document_outline),
                                  title: Text(name),
                                  subtitle: targetList.isNotEmpty &&
                                          targetList.first.length > 0 &&
                                          ex == "txt"
                                      ? Text(
                                          '${(targetList.first.pos / targetList.first.length * 100).toStringAsFixed(2)}%')
                                      : Text(''),
                                  trailing: Text("${size}"),
                                  onTap: () async {
                                    controller.openFile(file);
                                  },
                                )));
                      })
                      // Card(
                      //     child: Padding(
                      //   padding: EdgeInsets.all(10),
                      //   child: Text("파일 추가시 길게 눌러 여러개를 추가 할 수 있습니다."),
                      // )),
                      // ...[ctl.tmpDir.value].map((e) {
                      //   if (e == "") {
                      //     return SizedBox();
                      //   }
                      //   print(ctl.tmpDir.value);
                      //   int idxOf = path.indexOf(e);
                      //   Widget delIcon = IconSlideAction(
                      //     caption: 'remove_from_library'.tr,
                      //     color: Colors.red,
                      //     icon: Icons.delete,
                      //     onTap: () {
                      //       // onDeleteFile(f);
                      //     },
                      //   );
                      //   return Card();
                      //   // return Card(
                      //   //     child: Slidable(
                      //   //         actionPane: SlidableDrawerActionPane(),
                      //   //         // actionExtentRatio: 0.2,
                      //   //         secondaryActions: [delIcon],
                      //   //         actions: [delIcon],
                      //   //         child: ListTile(
                      //   //           onTap:  () {
                      //   //             controller.openFile(f);
                      //   //           },
                      //   //           leading: Icon(Ionicons.document_outline),
                      //   //           title: Text(e.path.split("/").last,
                      //   //               style: TextStyle(
                      //   //                   color: bex ? null : Colors.grey)),
                      //   //           subtitle: targetList.isNotEmpty &&
                      //   //                   targetList.first.length > 0 &&
                      //   //                   ex == "txt"
                      //   //               ? Text(
                      //   //                   '${(targetList.first.pos / targetList.first.length * 100).toStringAsFixed(2)}%')
                      //   //               : Text(''),
                      //   //           trailing: Text("${size}"),
                      //   //         )));
                      //   // return Card(
                      //   //     child: InkWell(
                      //   //         // onLongPress: () async {
                      //   //         //   var rtn = await OpenModal.openModalSelect(
                      //   //         //       title:
                      //   //         //           "해당 서재를 리스트 에서 제거 하시겠습니까?\n(데이터는 삭제 되지 않습니다.)");
                      //   //         //   if (rtn == true) {
                      //   //         //     controller.libraryPaths.remove(e);
                      //   //         //   }
                      //   //         // },
                      //   //         child: ExpansionTile(
                      //   //             // initiallyExpanded: idx == 0,
                      //   //             initiallyExpanded: true,
                      //   //             title: Text('file_list'
                      //   //                 .tr), //Text(e.split("/").last),
                      //   //             children: [
                      //   //       DirectoryListWidget(
                      //   //         path: e,
                      //   //         delList: ctl.delList,
                      //   //         historylist: listHistory,
                      //   //         curOpenPath: path,
                      //   //         onTab: (File f) async {
                      //   //           controller.openFile(f);
                      //   //         },
                      //   //         onDeleteFile: (File f) async {
                      //   //           var status = await Permission.storage.status;
                      //   //           if (!status.isGranted) {
                      //   //             await Permission.storage.request();
                      //   //           }
                      //   //           await f.delete();
                      //   //           ctl.delList.add(f.path);
                      //   //         },
                      //   //         // onDeleteDir: (Directory d) async {
                      //   //         //   var status = await Permission.storage.status;
                      //   //         //   if (!status.isGranted) {
                      //   //         //     await Permission.storage.request();
                      //   //         //   }
                      //   //         //   await d.delete(recursive: true);
                      //   //         //   pageCtl.delList.add(d.path);
                      //   //         // },
                      //   //       )
                      //   //     ])));
                      // }).toList(),
                    ]));
          }),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var path = await Utils.selectFile();

          ctl.tmpDir.refresh();
        },
        label: Text('Add_file'.tr),
        icon: Icon(Ionicons.add),
      ),
    );
  }
}

// class DirectoryListWidget extends GetView {
//   DirectoryListWidget({
//     required this.path,
//     required this.delList,
//     required this.onTab,
//     required this.historylist,
//     this.curOpenPath = "",
//     this.exs = const [
//       "txt",
//       // "gif",
//       // "png",
//       // "jpg",
//       // "tiff",
//       // "zip",
//     ],
//     required this.onDeleteFile,
//     // required this.onDeleteDir,
//   });
//   String path;
//   List<String> delList;
//   Function onTab;
//   List<String> exs;
//   String curOpenPath;
//   List<History> historylist;
//   Function(File) onDeleteFile;
//   // Function(Directory) onDeleteDir;

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return FutureBuilder(
//         future: Utils.getLibraryList(path),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<FileSystemEntity>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             snapshot.data!.sort((a, b) {
//               if (a is File && b is File) {
//                 return a.path.split("/").last.compareTo(b.path.split("/").last);
//               }
//               if (a is Directory) {
//                 return -2;
//               }
//               return 1;
//             });
//             if (snapshot.data!.isEmpty) {
//               return SizedBox();
//             }
//             // snapshot.data!.sort((a, b) {
//             //   (a as File).lastModified()

//             // }  return
//             return Obx(() {
//               var dellis = delList;

//               return Padding(
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   child: Column(
//                     children: [
//                       ...snapshot.data!.map((e) {
//                         if (dellis.indexOf(e.path) >= 0) {
//                           return SizedBox();
//                         }
//                         if (e is Directory) {
//                           // Widget delIcon = IconSlideAction(
//                           //   caption: '삭제',
//                           //   color: Colors.red,
//                           //   icon: Icons.delete,
//                           //   onTap: () {
//                           //     onDeleteDir(e as Directory);
//                           //   },
//                           // );
//                           int idxOf = curOpenPath.indexOf(e.path);

//                           return Card(
//                               child: Slidable(
//                                   actionPane: SlidableDrawerActionPane(),
//                                   actionExtentRatio: 0.2,
//                                   // secondaryActions: [delIcon],
//                                   // actions: [delIcon],
//                                   child: ExpansionTile(
//                                       initiallyExpanded: idxOf >= 0,
//                                       leading: Icon(Ionicons.folder_outline),
//                                       title: Text(e.path.split("/").last),
//                                       children: [
//                                         DirectoryListWidget(
//                                           path: e.path,
//                                           delList: delList,
//                                           historylist: historylist,
//                                           onTab: onTab,
//                                           onDeleteFile: onDeleteFile,
//                                           // onDeleteDir: onDeleteDir,
//                                         )
//                                       ])));
//                         }
//                         var f = e as File;
//                         String ex = "";
//                         var exList = f.path.split(".");
//                         if (exList.isNotEmpty) {
//                           ex = exList.last.toLowerCase();
//                         }
//                         bool bex = exs.indexOf(ex) >= 0;
//                         String size = Utils.getFileSize(f);
//                         Widget delIcon = IconSlideAction(
//                           caption: 'remove_from_library'.tr,
//                           color: Colors.red,
//                           icon: Icons.delete,
//                           onTap: () {
//                             onDeleteFile(f);
//                           },
//                         );
//                         String name = e.path.split("/").last;
//                         List<History> targetList = historylist.where((e) {
//                           return e.name == name;
//                         }).toList();

//                         return Card(
//                             child: Slidable(
//                                 actionPane: SlidableDrawerActionPane(),
//                                 // actionExtentRatio: 0.2,
//                                 secondaryActions: [delIcon],
//                                 actions: [delIcon],
//                                 child: ListTile(
//                                   onTap: bex ? () => onTab(e) : null,
//                                   leading: Icon(Ionicons.document_outline),
//                                   title: Text(e.path.split("/").last,
//                                       style: TextStyle(
//                                           color: bex ? null : Colors.grey)),
//                                   subtitle: targetList.isNotEmpty &&
//                                           targetList.first.length > 0 &&
//                                           ex == "txt"
//                                       ? Text(
//                                           '${(targetList.first.pos / targetList.first.length * 100).toStringAsFixed(2)}%')
//                                       : Text(''),
//                                   trailing: Text("${size}"),
//                                 )));
//                       }).toList()
//                     ],
//                   ));
//             });
//           }
//           return Text("");
//         });
//   }
// }
