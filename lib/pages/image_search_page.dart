import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:googleapis/servicenetworking/v1.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/Ads.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:open_textview/model/user_data.dart';
import 'package:open_textview/provider/net.dart';
import 'package:open_textview/provider/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSearchPageCtl extends GetxController {
  RxString keyword = "".obs;

  RxList<String> imageUrls = RxList<String>();
  RxString selectImage = "".obs;

  searchImage() async {
    var ss = await Net.getImage(keyword.value);
    imageUrls(ss);
  }
}

class ImageSearchPage extends GetView<BoxCtl> {
  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(ImageSearchPageCtl());
    String name = Get.arguments;
    name = name.split(".").first;

    return Scaffold(
      appBar: AppBar(
        title: Text("Book Image Search".tr),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                labelText: "Please enter a word/sentence to search for".tr,
                suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ctl.searchImage();
                    },
                    icon: Icon(Icons.search)),
              ),
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                ctl.searchImage();
              },
              onChanged: (v) {
                ctl.keyword(v);
              },
            ),
          ),
          Obx(
            () => Expanded(
                child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: ctl.imageUrls.length,
              itemBuilder: (context, index) {
                var e = ctl.imageUrls[index];
                return Obx(() => Column(children: [
                      InkWell(
                        onTap: () {
                          ctl.selectImage(e);
                        },
                        child: Image.network(e),
                      ),
                      Radio(
                          value: e,
                          groupValue: ctl.selectImage.value,
                          onChanged: (_) {
                            ctl.selectImage(e);
                          })
                    ]));
              },
              // childAspectRatio: 19 / 6,
              // children: [
              //   ...ctl.imageUrls.map((e) {
              //     return Column(children: [
              //       InkWell(
              //         onTap: () {
              //           ctl.selectImage(e);
              //         },
              //         child: Image.network(e),
              //       ),
              //       Radio(
              //           value: e,
              //           groupValue: ctl.selectImage.value,
              //           onChanged: (_) {
              //             ctl.selectImage(e);
              //           })
              //     ]);
              //   }).toList(),
              // ],
            )),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("cancel".tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(result: {
                "imageUri": ctl.selectImage.value,
                "searchKeyWord": ctl.keyword.value,
              });
            },
            child: Text("confirm".tr),
          )
        ],
      ),
    );
  }
}
