// import 'dart:io';
// import 'dart:typed_data';

// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_tesseract_ocr/android_ios.dart';
// import 'package:get/get.dart';
// import 'package:open_textview/component/readpage_floating_button.dart';
// import 'package:open_textview/controller/audio_play.dart';
// import 'package:open_textview/controller/global_controller.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class ImageViewerPageCtl extends GetxController {
//   Rx<bool> bFind = false.obs;
//   test() async {
//     HttpClient httpClient = new HttpClient();
//     HttpClientRequest request = await httpClient.getUrl(Uri.parse(
//         'https://github.com/tesseract-ocr/tessdata/raw/main/kor.traineddata'));
//     HttpClientResponse response = await request.close();
//     Uint8List bytes = await consolidateHttpClientResponseBytes(response);

//     String dir = await FlutterTesseractOcr.getTessdataPath();
//     print('$dir/kor.traineddata');
//     File file = new File('$dir/kor.traineddata');
//     await file.writeAsBytes(bytes);
//     print(await file.parent.list().toList());
//     var ctl = Get.find<GlobalController>();
//     // var imgpath = ctl.lastImageData[0];

//     Directory tempDir = await getTemporaryDirectory();
//     HttpClient httpc = new HttpClient();
//     HttpClientRequest re = await httpc.getUrl(Uri.parse(
//         "https://raw.githubusercontent.com/khjde1207/tesseract_ocr/master/example/assets/test1.png"));
//     HttpClientResponse rep = await re.close();
//     Uint8List byte1 = await consolidateHttpClientResponseBytes(rep);
//     String dir1 = tempDir.path;
//     print('$dir1/test.jpg');
//     File file1 = new File('$dir1/test.jpg');
//     await file1.writeAsBytes(byte1);
//     ;
//     var str = await FlutterTesseractOcr.extractText(file1.path,
//         language: "kor",
//         args: {
//           "preserve_interword_spaces": "1",
//         });
//     print(str);
//     // for (var i = 0; i < ctl.lastImageData.length; i++) {
//     // }
//   }
// }

// class ImageViewerPage extends GetView<GlobalController> {
//   @override
//   Widget build(BuildContext context) {
//     final pageCtl = Get.put(ImageViewerPageCtl());
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         // centerTitle: true,
//         toolbarHeight: 30,
//         // elevation: 0,
//         // backgroundColor: Colors.transparent,
//         title: Text(
//           "",
//           style: TextStyle(
//             fontSize: 15,
//           ),
//         ),
//         // actions: [
//         //   if (controller.contents.isNotEmpty)
//         //     Padding(
//         //         padding: EdgeInsets.only(right: 10),
//         //         child: Row(
//         //           children: [
//         //             Obx(() => Text(
//         //                 "${(controller.lastData.value.pos / controller.contents.length * 100).toStringAsFixed(2)}%")),
//         //           ],
//         //         )),
//         // ]
//       ),
//       body: AudioPlay.builder(builder:
//           (BuildContext context, AsyncSnapshot<PlaybackState> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }

//         return Obx(() => ListView(
//               children: [
//                 ...controller.lastImageData.map((e) {
//                   return Stack(
//                     children: [
//                       Image.file(File(e)),
//                       Center(child: Text("asdffff"))
//                     ],
//                   );
//                 }).toList(),
//               ],
//             ));
//         // Obx(() => ScrollablePositionedList.builder(
//         //     padding: EdgeInsets.all(10),
//         //     itemScrollController: controller.itemScrollctl,
//         //     itemPositionsListener: controller.itemPosListener,
//         //     itemCount: controller.contents.length,
//         //     itemBuilder: (BuildContext context, int idx) {
//         //       bool bPlay = snapshot.data!.playing;
//         //       int pos = controller.lastData.value.pos;
//         //       int max = pos + controller.userData.value.tts.groupcnt;
//         //       bool brange = bPlay && idx >= pos && idx < max;
//         //       return InkWell(
//         //         onLongPress: () {
//         //           Clipboard.setData(
//         //               ClipboardData(text: controller.contents[idx]));
//         //           final snackBar = SnackBar(
//         //             content: Text(
//         //               '[${controller.contents[idx]}]\n클립보드에 복사됨.',
//         //               style: Theme.of(context).textTheme.bodyText1,
//         //             ),
//         //             backgroundColor: Theme.of(context).backgroundColor,
//         //             duration: Duration(milliseconds: 1000),
//         //           );
//         //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         //         },
//         //         child: DecoratedBox(
//         //             decoration:
//         //                 BoxDecoration(color: brange ? Colors.blue[100] : null),
//         //             child: Obx(
//         //               () => Text(controller.contents[idx],
//         //                   style: TextStyle(
//         //                       fontSize: controller.userData.value.ui.fontSize
//         //                           .toDouble())),
//         //             )),
//         //       );
//         //     }));
//       }),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           pageCtl.test();
//         },
//         child: Text("adf"),
//       ),
//     );
//   }
// }
