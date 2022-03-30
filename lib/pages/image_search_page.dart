// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:open_textview/box_ctl.dart';
// import 'package:open_textview/provider/net.dart';

// class ImageSearchPageCtl extends GetxController {
//   RxString keyword = "".obs;

//   RxList<String> imageUrls = RxList<String>();
//   RxString selectImage = "".obs;

//   searchImage() async {
//     var ss = await Net.getImage(keyword.value);
//     imageUrls(ss);
//   }
// }

// class ImageSearchPage extends GetView<BoxCtl> {
//   final ctl = Get.put(ImageSearchPageCtl());
//   @override
//   Widget build(BuildContext context) {
//     String name = Get.arguments;
//     name = name.split(".").first;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Book Image Search".tr),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: TextFormField(
//               initialValue: name,
//               decoration: InputDecoration(
//                 labelText: "Please enter a word/sentence to search for".tr,
//                 suffixIcon: IconButton(
//                     onPressed: () {
//                       FocusScope.of(context).unfocus();
//                       ctl.searchImage();
//                     },
//                     icon: Icon(Icons.search)),
//               ),
//               textInputAction: TextInputAction.search,
//               onEditingComplete: () {
//                 FocusScope.of(context).unfocus();
//                 ctl.searchImage();
//               },
//               onChanged: (v) {
//                 ctl.keyword(v);
//               },
//             ),
//           ),
//           Obx(
//             () => Expanded(
//                 child: MasonryGridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 4,
//               crossAxisSpacing: 4,
//               itemCount: ctl.imageUrls.length,
//               itemBuilder: (context, index) {
//                 var e = ctl.imageUrls[index];
//                 return Obx(() => Column(children: [
//                       InkWell(
//                         onTap: () {
//                           ctl.selectImage(e);
//                         },
//                         child: Image.network(
//                           e,
//                           errorBuilder: (c, o, s) {
//                             return SizedBox(
//                               child: Text("image\nnot\nfound"),
//                             );
//                           },
//                         ),
//                       ),
//                       Radio(
//                           value: e,
//                           groupValue: ctl.selectImage.value,
//                           onChanged: (_) {
//                             ctl.selectImage(e);
//                           })
//                     ]));
//               },
//               // childAspectRatio: 19 / 6,
//               // children: [
//               //   ...ctl.imageUrls.map((e) {
//               //     return Column(children: [
//               //       InkWell(
//               //         onTap: () {
//               //           ctl.selectImage(e);
//               //         },
//               //         child: Image.network(e),
//               //       ),
//               //       Radio(
//               //           value: e,
//               //           groupValue: ctl.selectImage.value,
//               //           onChanged: (_) {
//               //             ctl.selectImage(e);
//               //           })
//               //     ]);
//               //   }).toList(),
//               // ],
//             )),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: Text("cancel".tr),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back(result: {
//                 "imageUri": "",
//                 "searchKeyWord": "",
//               });
//             },
//             child: Text("delete".tr),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (ctl.selectImage.value.isEmpty || ctl.keyword.value.isEmpty) {
//                 return;
//               }
//               Get.back(result: {
//                 "imageUri": ctl.selectImage.value,
//                 "searchKeyWord": ctl.keyword.value,
//               });
//             },
//             child: Text("confirm".tr),
//           ),
//         ],
//       ),
//     );
//   }
// }
