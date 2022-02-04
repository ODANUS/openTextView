// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:googleapis/drive/v3.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:open_textview/box_ctl.dart';
// import 'package:open_textview/controller/global_controller.dart';
// import 'package:open_textview/model/user_data.dart';
// import 'package:open_textview/provider/Gdrive.dart';
// import 'package:open_textview/provider/utils.dart';

// class OptionHistoryCtl extends GetxController {
//   // RxList<File> backupFiles = RxList<File>();
//   final searchText = "".obs;
// }

// class OptionHistory extends GetView<BoxCtl> {
//   @override
//   Widget build(BuildContext context) {
//     final pageCtl = Get.put(OptionHistoryCtl());

//     return Obx(() {
//       var historyList = controller.userData.value.history;
//       var copyHistoryList = List<History>.from(historyList);
//       copyHistoryList.sort((a, b) {
//         return b.date.compareTo(a.date);
//       });
//       copyHistoryList = copyHistoryList
//           .where((el) => el.name.indexOf(pageCtl.searchText.value) >= 0)
//           .toList();
//       return Stack(
//         children: [
//           ExpansionTile(
//             onExpansionChanged: (b) async {},
//             title: Text("history".tr),
//             children: [
//               ListTile(
//                   title: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText:
//                                 "Please enter a word/sentence to search for".tr,
//                           ),
//                           onChanged: (v) {
//                             pageCtl.searchText(v);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   trailing: IconButton(
//                     icon: new Icon(Ionicons.search),
//                     color: Colors.black26,
//                     onPressed: () {},
//                   )),
//               ...copyHistoryList.map((e) {
//                 Widget delwidget = Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.delete, color: Colors.white),
//                     Text(
//                       "Drag to delete".tr,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 );
//                 return Card(
//                     child: Dismissible(
//                   key: Key(e.name),
//                   onDismissed: (direction) {
//                     controller.userData.update((UserData? val) {
//                       if (val != null) {
//                         val.history.remove(e);
//                       }
//                     });
//                   },
//                   background: Container(
//                     padding: EdgeInsets.only(left: 20, right: 20),
//                     color: Colors.red,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [delwidget, delwidget],
//                     ),
//                   ),
//                   child: ListTile(
//                     onTap: () {},
//                     title: Text(e.name),
//                     subtitle: Row(
//                       children: [
//                         Text("${"last position".tr} : "),
//                         Text("${e.pos}")
//                       ],
//                     ),
//                   ),
//                 )
//                     // actionExtentRatio: 0.2,
//                     // secondaryActions: [delIcon],
//                     // actions: [delIcon],
//                     // ),
//                     );
//               }).toList(),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
