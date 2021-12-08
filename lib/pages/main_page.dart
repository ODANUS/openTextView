import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:get/get.dart';
import 'package:open_textview/controller/global_controller.dart';
// import 'package:open_textview/pages/image_viewer_page.dart';
import 'package:open_textview/pages/library_page.dart';
import 'package:open_textview/pages/read_page.dart';
import 'package:open_textview/pages/setting_page.dart';

class MainPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    // final pageCtl = Get.put(MainPageCtl());
    return Scaffold(
      body: Obx(() => IndexedStack(index: controller.tabIndex.value, children: [
            ReadPage(),
            // ImageViewerPage(),
            LibraryPage(),
            SettingPage()
          ])),

      bottomNavigationBar: Obx(() {
        if (controller.bFullScreen.value) {
          return SizedBox();
        }

        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.tabIndex.value,
            onTap: (idx) => controller.tabIndex(idx),
            items: [
              BottomNavigationBarItem(
                label: "text_viewer".tr,
                icon: Icon(Icons.menu_book_outlined),
              ),
              // BottomNavigationBarItem(
              //   label: "이미지 뷰어",
              //   icon: Icon(Icons.image_outlined),
              // ),
              BottomNavigationBarItem(
                label: "my_library".tr,
                icon: Icon(Ionicons.library_outline),
              ),
              BottomNavigationBarItem(
                label: "Settings".tr,
                icon: Icon(Ionicons.settings_outline),
              ),
            ]);
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // floatingActionButton: FloatingButton(),
    );
  }
}



 //   StreamBuilder(
//       stream: AudioService.runningStream,
//       builder: (c, snapshot) => GetBuilder<MainCtl>(builder: (ctl) {
//             if (ctl.contents.isEmpty) {
//               return Text(
//                   "좌측 상단 책 아이콘을 클릭하거나. 우측 ... 아이콘 큭릭후 파일 탐색기를 이용하여 책을 열어주세요.");
//             }
//             return ScrollablePositionedList.builder(
//               itemCount: ctl.contents.length,
//               itemBuilder: (context, index) {
//                 if (index >= ctl.contents.length || index < 0) {
//                   return Text('');
//                 }
//                 if (snapshot.data) {
//                   int cnt =
//                       ((ctl.config['tts'] as RxMap)['groupcnt']);
//                   int endpos = ctl.curPos.value + cnt;
//                   if (index >= ctl.curPos.value && index < endpos) {
//                     return InkWell(
//                         onLongPress: () {
//                           Clipboard.setData(ClipboardData(
//                               text: ctl.contents[index]));
//                           final snackBar = SnackBar(
//                             content: Text(
//                               '[${ctl.contents[index]}]\n클립보드에 복사됨.',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1,
//                             ),
//                             backgroundColor:
//                                 Theme.of(context).cardTheme.color,
//                             duration: Duration(milliseconds: 1000),
//                           );
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(snackBar);
//                         },
//                         child: Text(
//                           '${ctl.contents[index]}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             // backgroundColor: Theme.of(context)
//                             //     .colorScheme
//                             //     .surface
//                           ),
//                         ));
//                   }
//                 }
//                 return InkWell(
//                   child: Text('${ctl.contents[index] ?? ""}'),
//                   onLongPress: () {
//                     Clipboard.setData(
//                         ClipboardData(text: ctl.contents[index]));
//                     final snackBar = SnackBar(
//                       content: Text(
//                         '[${ctl.contents[index]}]\n클립보드에 복사됨.',
//                         style:
//                             Theme.of(context).textTheme.bodyText1,
//                       ),
//                       backgroundColor:
//                           Theme.of(context).cardTheme.color,
//                       duration: Duration(milliseconds: 1000),
//                     );

//                     // Find the ScaffoldMessenger in the widget tree
//                     // and use it to show a SnackBar.
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(snackBar);
//                   },
//                 );
//               },
//               itemScrollController: ctl.itemScrollctl,
//               itemPositionsListener: ctl.itemPosListener,
//             );
//           })),

// Obx(() {
//   if (controller.ocrData['current'] !=
//           controller.ocrData['total'] &&
//       (controller.config['picker'] as Map)['extension'] == 'zip') {
//     return Container(
//         padding: EdgeInsets.all(5),
//         child: Column(
//           children: [
//             Text(
//                 '${controller.ocrData['current']} / ${controller.ocrData['total']}'),
//             LinearProgressIndicator(
//               value: max(controller.ocrData['current'], 1) /
//                   max(controller.ocrData['total'], 1),
//               semanticsLabel: 'Linear progress indicator',
//             )
//           ],
//         ));
//   }
//   return SizedBox();
// }),

 // PopupMenuButton(
//     itemBuilder: (context) => [
//           ...NAVBUTTON.map((el) {
//             RxList nav = controller.config['nav'];
//             String name = el.runtimeType.toString();
//             return PopupMenuItem(
//                 value: "12",
//                 child: Obx(() => ListTileTheme(
//                     iconColor:
//                         Theme.of(Get.context!).iconTheme.color,
//                     child: ListTile(
//                       leading: el,
//                       title: Text(el.name),
//                       trailing: Checkbox(
//                         value: nav
//                             .where((e) => e.toString() == name)
//                             .isNotEmpty,
//                         onChanged: (value) {
//                           if (value!) {
//                             nav.add(name);
//                           } else {
//                             nav.remove(name);
//                           }
//                           controller.update();
//                         },
//                       ),
//                       onTap: () {
//                         el.openSetting();
//                       },
//                     ))));
//           }).toList(),
//         ])