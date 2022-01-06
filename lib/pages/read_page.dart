import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/component/readpage_floating_button.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            // centerTitle: true,
            toolbarHeight: 30,
            // elevation: 0,
            // backgroundColor: Colors.transparent,
            title: Text(
              controller.lastData.value.name,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            actions: [
              if (controller.contents.isNotEmpty)
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Obx(() => Text(
                            "${(controller.lastData.value.pos / controller.contents.length * 100).toStringAsFixed(2)}%")),
                      ],
                    )),
              InkWell(
                  onTap: () {
                    controller.bScreenHelp(!controller.bScreenHelp.value);
                  },
                  child: Icon(Icons.help_outline)),
            ]),
        body: Stack(children: [
          AudioPlay.builder(builder:
              (BuildContext context, AsyncSnapshot<PlaybackState> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Obx(
              () => ScrollablePositionedList.builder(
                  padding: EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 150),
                  itemScrollController: controller.itemScrollctl,
                  itemPositionsListener: controller.itemPosListener,
                  itemCount: controller.contents.length,
                  itemBuilder: (BuildContext context, int idx) {
                    bool bPlay = snapshot.data!.playing;
                    int pos = controller.lastData.value.pos;
                    int max = pos + controller.userData.value.tts.groupcnt;
                    bool brange = bPlay && idx >= pos && idx < max;
                    return InkWell(
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: controller.contents[idx]));
                        final snackBar = SnackBar(
                          content: Text(
                            '[${controller.contents[idx]}]\n${"Copied to clipboard".tr}.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          backgroundColor: Theme.of(context).backgroundColor,
                          duration: Duration(milliseconds: 1000),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: brange ? Colors.blue[100] : null),
                          child: Obx(
                            () => Text(
                                // controller.contents[idx],
                                idx <= controller.contents.length
                                    ? controller.contents[idx]
                                    : "",
                                style: TextStyle(
                                  fontSize: controller
                                      .userData.value.ui.fontSize
                                      .toDouble(),
                                  fontWeight: FontWeight.values[
                                      controller.userData.value.ui.fontWeight],
                                  // fontFamily: controller.userData.value.ui.fontFamily,
                                  fontFamily: controller
                                              .userData.value.ui.fontFamily ==
                                          'default'
                                      ? null
                                      : controller.userData.value.ui.fontFamily,
                                )),
                          )),
                    );
                  }),
            );
          }),
          Obx(() {
            var bhelp = controller.bScreenHelp.value;
            BoxDecoration? decoration = null;
            TextStyle style = TextStyle(color: Colors.white);
            if (bhelp) {
              decoration = BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ));
            }

            return Row(
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                        decoration: decoration,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            controller.backPage();
                          },
                          child:
                              bhelp ? Text("Back page".tr, style: style) : null,
                        ))),
                Flexible(
                    flex: 5,
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      Flexible(
                          child: Container(
                              alignment: Alignment.center,
                              decoration: decoration,
                              child: GestureDetector(
                                onTap: () {
                                  controller.backPage();
                                },
                                child: bhelp
                                    ? Text("Back page".tr, style: style)
                                    : null,
                              ))),
                      Flexible(
                          child: Container(
                              alignment: Alignment.center,
                              decoration: decoration,
                              child: GestureDetector(
                                onDoubleTap: () {
                                  if (controller.firstFullScreen.value) {
                                    controller.firstFullScreen(false);
                                    OpenModal.openFocusModal();
                                  }
                                  controller.bFullScreen(
                                      !controller.bFullScreen.value);
                                },
                                child: bhelp
                                    ? Text("Double click to full screen".tr,
                                        style: style)
                                    : null,
                              ))),
                      Flexible(
                        child: Container(
                            alignment: Alignment.center,
                            decoration: decoration,
                            child: GestureDetector(
                              onTap: () {
                                controller.nextPage();
                              },
                              child: bhelp
                                  ? Text("next page".tr, style: style)
                                  : null,
                            )),
                      ),
                    ])),
                Flexible(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: decoration,
                        child: GestureDetector(
                          onTap: () {
                            controller.nextPage();
                          },
                          child:
                              bhelp ? Text("next page".tr, style: style) : null,
                        ))),
              ],
            );
          }),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => controller.bFullScreen.value
              ? SizedBox()
              : readPageFloatingButton(),
        ));
  }
}
