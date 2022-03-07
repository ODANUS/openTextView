import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/component/readpage_floating_button.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/model/box_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReadPage extends GetView<BoxCtl> {
  editImage() async {
    String name = controller.currentHistory.value.name.split("/").last;
    var result = await Get.toNamed("/searchpage", arguments: name);
    if (result != null) {
      controller.currentHistory.update((v) {
        v!.searchKeyWord = result["searchKeyWord"];
        v.imageUri = result["imageUri"];
      });
      controller.editHistory(controller.currentHistory.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 30,
            title: InkWell(
              onTap: () {
                controller.bImageFullScreen(true);
                controller.bFullScreen(true);
                // Get.dialog(AlertDialog());
              },
              child: Obx(
                () => controller.bImageFullScreen.value
                    ? Text("")
                    : Text(
                        controller.currentHistory.value.name
                            .replaceAll(".txt", ""),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
            actions: [
              Obx(() => controller.contents.isNotEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Obx(() => Text(
                                "${(controller.currentHistory.value.pos / controller.contents.length * 100).toStringAsFixed(2)}%",
                              ))),
                    )
                  : SizedBox()),
              Obx(
                () => controller.bImageFullScreen.value
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          controller.bScreenHelp(!controller.bScreenHelp.value);
                        },
                        child: Icon(Icons.help_outline)),
              ),
            ]),
        body: SafeArea(
          child: Builder(builder: (ctx) {
            return Stack(children: [
              Obx(() {
                return Container(
                  width: Get.width,
                  height: Get.height,
                  color: Color(controller.setting.value.backgroundColor),
                );
              }),
              AudioPlay.builder(builder: (BuildContext context,
                  AsyncSnapshot<PlaybackState> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    controller.contents.length > 0) {
                  return CircularProgressIndicator();
                }

                return Obx(() {
                  return Container(
                      width: Get.width,
                      padding: controller.bFullScreen.value
                          ? EdgeInsets.only(
                              top: controller.setting.value.fontSize.toDouble(),
                              bottom: controller.setting.value.fontSize
                                      .toDouble() +
                                  (controller.setting.value.fontHeight.sp * 4))
                          : null,
                      child: ScrollablePositionedList.builder(
                          key: Key(
                              "readScroll${controller.currentHistory.value.name}"),
                          initialScrollIndex:
                              controller.currentHistory.value.pos,
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
                            int pos = bPlay
                                ? snapshot.data!.updatePosition.inSeconds
                                : controller.currentHistory.value.pos;

                            int max = pos + controller.setting.value.groupcnt;
                            bool brange = bPlay && idx >= pos && idx < max;
                            String text = controller.contents[idx];
                            var textcolor = Color(
                                controller.setting.value.fontColor == 0
                                    ? Theme.of(Get.context!)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .value
                                    : controller.setting.value.fontColor);

                            return Obx(() => InkWell(
                                  onLongPress: controller
                                          .setting.value.useClipboard
                                      ? () {
                                          Clipboard.setData(ClipboardData(
                                              text: controller.contents[idx]));
                                          final snackBar = SnackBar(
                                            content: Text(
                                              '[$text]\n${"Copied to clipboard".tr}.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .backgroundColor,
                                            duration:
                                                Duration(milliseconds: 1000),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      : null,
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color:
                                              brange ? Colors.blue[100] : null),
                                      child: Text("$text",
                                          style: TextStyle(
                                            color: textcolor,
                                            fontSize: controller
                                                .setting.value.fontSize
                                                .toDouble(),
                                            fontWeight: FontWeight.values[
                                                controller
                                                    .setting.value.fontWeight],
                                            height: controller
                                                .setting.value.fontHeight,
                                            // fontFamily: controller.setting.value.fontFamily,
                                            fontFamily: controller.setting.value
                                                        .fontFamily ==
                                                    'default'
                                                ? null
                                                : controller
                                                    .setting.value.fontFamily,
                                          ))),
                                ));
                          }));
                });
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
              }),
              Obx(() {
                if (controller.bImageFullScreen.value) {
                  return InkWell(
                      onTap: () {
                        controller.bImageFullScreen(false);
                        controller.bFullScreen(false);
                      },
                      child: Container(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.2),
                          padding: EdgeInsets.all(10),
                          // constraints: BoxConstraints(maxHeight: Get.height / 2),
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () {
                                    editImage();
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: Get.height * 0.8,
                                        maxWidth: Get.width * 0.8),
                                    child: Image.network(
                                      controller.currentHistory.value.imageUri,
                                      // fit: BoxFit.fitHeight,
                                      errorBuilder: (c, o, _) {
                                        return Icon(
                                          Icons.image_search_sharp,
                                          size: 80,
                                        );
                                      },
                                    ),
                                  )),
                              SizedBox(height: 10),
                              // Container(
                              //   padding: EdgeInsets.only(left: 10 , right: 10),
                              //   color: Theme.of(context).scaffoldBackgroundColor,
                              //   child: IntrinsicWidth(
                              //       child: TextFormField(
                              //     decoration:
                              //         InputDecoration(border: InputBorder.none),
                              //     textAlign: TextAlign.center,
                              //     textAlignVertical: TextAlignVertical.center,
                              //     initialValue: controller.currentHistory.value.name
                              //         .replaceAll(".txt", ""),
                              //     onEditingComplete: () {
                              //       FocusScope.of(context).unfocus();
                              //     },
                              //   )),
                              // ),
                            ],
                          )));
                }
                return SizedBox();
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
            ]);
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => controller.bFullScreen.value
              ? SizedBox()
              : readPageFloatingButton(),
        ));
  }
}
