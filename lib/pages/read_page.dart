import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/component/readpage_floating_button.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReadPage extends GetView<BoxCtl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // centerTitle: true,
            toolbarHeight: 30,
            // elevation: 0,
            // backgroundColor: Colors.transparent,
            title: InkWell(
              onTap: () {
                // Get.dialog(AlertDialog());
              },
              child: Text(
                controller.currentHistory.value.name.replaceAll(".txt", ""),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            actions: [
              if (controller.contents.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Obx(() => Text(
                            "${(controller.currentHistory.value.pos / controller.contents.length * 100).toStringAsFixed(2)}%",
                          ))),
                ),
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
                  physics: !controller.setting.value.enablescroll &&
                          controller.bFullScreen.value
                      ? NeverScrollableScrollPhysics()
                      : null,
                  padding: EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 150),
                  itemScrollController: controller.itemScrollctl,
                  itemPositionsListener: controller.itemPosListener,
                  itemCount: controller.contents.length,
                  itemBuilder: (BuildContext context, int idx) {
                    bool bPlay = snapshot.data!.playing;
                    int pos = controller.currentHistory.value.pos;
                    // int max = pos + controller.userData.value.tts.groupcnt;
                    int max = pos + controller.setting.value.groupcnt;
                    bool brange = bPlay && idx >= pos && idx < max;
                    String text = controller.contents[idx];

                    return Obx(() => InkWell(
                          onLongPress: controller.setting.value.useClipboard
                              ? () {
                                  Clipboard.setData(ClipboardData(
                                      text: controller.contents[idx]));
                                  final snackBar = SnackBar(
                                    content: Text(
                                      '[$text]\n${"Copied to clipboard".tr}.',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    duration: Duration(milliseconds: 1000),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              : null,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: brange ? Colors.blue[100] : null),
                              child: Text(text,
                                  style: TextStyle(
                                    fontSize: controller.setting.value.fontSize
                                        .toDouble(),
                                    fontWeight: FontWeight.values[
                                        controller.setting.value.fontWeight],
                                    height: controller.setting.value.fontHeight,
                                    // fontFamily: controller.setting.value.fontFamily,
                                    fontFamily: controller
                                                .setting.value.fontFamily ==
                                            'default'
                                        ? null
                                        : controller.setting.value.fontFamily,
                                  ))),
                        ));
                  }),
            );
          }),
          Obx(() {
            return ReadpageOverlay(
                bScreenHelp: controller.bScreenHelp.value,
                touchLayout: controller.setting.value.touchLayout,
                onFullScreen: () {
                  if (controller.firstFullScreen.value) {
                    controller.firstFullScreen(false);
                    OpenModal.openFocusModal();
                  }
                  controller.bFullScreen(!controller.bFullScreen.value);
                },
                onBackpage: () {
                  controller.backPage();
                },
                onNextpage: () {
                  controller.nextPage();
                });
          })
          // Obx(() {
          //   var bhelp = controller.bScreenHelp.value;
          //   BoxDecoration? decoration = null;
          //   TextStyle style = TextStyle(color: Colors.white);
          //   if (bhelp) {
          //     decoration = BoxDecoration(
          //         color: Colors.black54,
          //         border: Border.all(
          //           width: 1,
          //           color: Colors.white,
          //         ));
          //   }

          //   return Row(
          //     children: [
          //       Flexible(
          //           flex: 2,
          //           child: Container(
          //               decoration: decoration,
          //               alignment: Alignment.center,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   controller.backPage();
          //                 },
          //                 child:
          //                     bhelp ? Text("Back page".tr, style: style) : null,
          //               ))),
          //       Flexible(
          //           flex: 5,
          //           child: Column(mainAxisSize: MainAxisSize.max, children: [
          //             Flexible(
          //                 child: Container(
          //                     alignment: Alignment.center,
          //                     decoration: decoration,
          //                     child: GestureDetector(
          //                       onTap: () {
          //                         controller.backPage();
          //                       },
          //                       child: bhelp
          //                           ? Text("Back page".tr, style: style)
          //                           : null,
          //                     ))),
          //             Flexible(
          //                 child: Container(
          //                     alignment: Alignment.center,
          //                     decoration: decoration,
          //                     child: GestureDetector(
          //                       onDoubleTap: () {
          //                         if (controller.firstFullScreen.value) {
          //                           controller.firstFullScreen(false);
          //                           OpenModal.openFocusModal();
          //                         }
          //                         controller.bFullScreen(
          //                             !controller.bFullScreen.value);
          //                       },
          //                       child: bhelp
          //                           ? Text("Double click to full screen".tr,
          //                               style: style)
          //                           : null,
          //                     ))),
          //             Flexible(
          //               child: Container(
          //                   alignment: Alignment.center,
          //                   decoration: decoration,
          //                   child: GestureDetector(
          //                     onTap: () {
          //                       controller.nextPage();
          //                     },
          //                     child: bhelp
          //                         ? Text("next page".tr, style: style)
          //                         : null,
          //                   )),
          //             ),
          //           ])),
          //       Flexible(
          //           flex: 2,
          //           child: Container(
          //               alignment: Alignment.center,
          //               decoration: decoration,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   controller.nextPage();
          //                 },
          //                 child:
          //                     bhelp ? Text("next page".tr, style: style) : null,
          //               ))),
          //     ],
          //   );
          // }),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => controller.bFullScreen.value
              ? SizedBox()
              : readPageFloatingButton(),
        ));
  }
}
