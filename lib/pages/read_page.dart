import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_textview/component/readpage_floating_button.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReadPageCtl extends GetxController {
  Rx<bool> bFind = false.obs;
}

class ReadPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(ReadPageCtl());
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.lastData.value.name,
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Obx(() => ScrollablePositionedList.builder(
          padding: EdgeInsets.all(10),
          itemScrollController: controller.itemScrollctl,
          itemPositionsListener: controller.itemPosListener,
          itemCount: controller.contents.length,
          itemBuilder: (BuildContext context, int idx) {
            return InkWell(
              onLongPress: () {
                Clipboard.setData(
                    ClipboardData(text: controller.contents[idx]));
                final snackBar = SnackBar(
                  content: Text(
                    '[${controller.contents[idx]}]\n클립보드에 복사됨.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  duration: Duration(milliseconds: 1000),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(controller.contents[idx]),
            );
          })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: readPageFloatingButton(),
    );
  }
}
