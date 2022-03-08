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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReadPage extends GetView<BoxCtl> {
  Offset? startPos;
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
              Obx(
                () => controller.bImageFullScreen.value
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          controller.bTowDrage(!controller.bTowDrage.value);
                        },
                        child: Icon(Icons.vertical_align_center_sharp)),
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
              AudioPlay.builder(
                builder: (BuildContext context,
                    AsyncSnapshot<PlaybackState> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      controller.contents.length > 0) {
                    return CircularProgressIndicator();
                  }

                  return Obx(() {
                    return Container(
                        width: Get.width,
                        padding: EdgeInsets.only(
                          left: controller.setting.value.paddingLeft,
                          right: controller.setting.value.paddingRight,
                          top: controller.setting.value.paddingTop,
                          bottom: controller.setting.value.paddingBottom,
                        ),
                        child: ScrollablePositionedList.builder(
                            key: Key(
                                "readScroll${controller.currentHistory.value.name}"),
                            initialScrollIndex:
                                controller.currentHistory.value.pos,
                            physics: controller.bFullScreen.value
                                ? NeverScrollableScrollPhysics()
                                : null,
                            padding: EdgeInsets.only(bottom: 150),
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
                                                text:
                                                    controller.contents[idx]));
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
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: brange
                                                ? Colors.blue[100]
                                                : null),
                                        child: Text("$text",
                                            style: TextStyle(
                                              color: controller
                                                          .bFullScreen.value &&
                                                      controller.max <= idx
                                                  ? Colors.transparent
                                                  : textcolor,
                                              fontSize: controller
                                                  .setting.value.fontSize
                                                  .toDouble(),
                                              fontWeight: FontWeight.values[
                                                  controller.setting.value
                                                      .fontWeight],
                                              height: controller
                                                  .setting.value.fontHeight,
                                              // fontFamily: controller.setting.value.fontFamily,
                                              fontFamily: controller.setting
                                                          .value.fontFamily ==
                                                      'default'
                                                  ? null
                                                  : controller
                                                      .setting.value.fontFamily,
                                            ))),
                                  ));
                            }));
                  });
                },
              ),
              Obx(() {
                return ReadpageOverlay(
                    bScreenHelp: controller.bScreenHelp.value,
                    touchLayout: controller.setting.value.touchLayout,
                    onFullScreen: () {
                      // 순서 중요
                      controller.bFullScreen(!controller.bFullScreen.value);
                      if (controller.firstFullScreen.value) {
                        controller.firstFullScreen(false);
                        OpenModal.openFocusModal();
                      }
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
                            ],
                          )));
                }
                return SizedBox();
              }),
              Obx(() {
                if (controller.bTowDrage.value) {
                  var boxdeco = BoxDecoration(
                    color: Colors.black45,
                    border: Border.all(color: Colors.white, width: 1),
                  );
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onVerticalDragUpdate: (d) {
                            var setting = controller.setting.value;
                            if (setting.paddingTop < 0) {
                              setting.paddingTop = 0;
                            }
                            if (d.delta.dy < 0 && setting.paddingTop > 0) {
                              setting.paddingTop -= 0.1;
                            }
                            if (d.delta.dy > 0 && setting.paddingTop < 100) {
                              setting.paddingTop += 0.1;
                            }
                            controller.setting.refresh();
                          },
                          child: Container(
                            decoration: boxdeco,
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Top Padding"),
                                  Icon(Icons.swipe_vertical),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            var setting =
                                                controller.setting.value;
                                            if (setting.paddingTop > 0) {
                                              setting.paddingTop -= 0.1;
                                            }
                                            controller.setting.refresh();
                                          },
                                          icon: Icon(Icons.remove)),
                                      Text(
                                          "${controller.setting.value.paddingTop.toStringAsFixed(1)}"),
                                      IconButton(
                                          onPressed: () {
                                            var setting =
                                                controller.setting.value;
                                            setting.paddingTop += 0.1;
                                            controller.setting.refresh();
                                          },
                                          icon: Icon(Icons.add)),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                                    onHorizontalDragUpdate: (d) {
                                      var setting = controller.setting.value;
                                      if (setting.paddingLeft < 0) {
                                        setting.paddingLeft = 0;
                                      }
                                      if (d.delta.dx < 0 &&
                                          setting.paddingLeft > 0) {
                                        setting.paddingLeft -= 0.1;
                                      }
                                      if (d.delta.dx > 0 &&
                                          setting.paddingLeft < 100) {
                                        setting.paddingLeft += 0.1;
                                      }
                                      controller.setting.refresh();
                                    },
                                    child: Container(
                                      decoration: boxdeco,
                                      alignment: Alignment.center,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Left Padding"),
                                            Icon(Icons.swipe),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      var setting = controller
                                                          .setting.value;
                                                      if (setting.paddingLeft >
                                                          0) {
                                                        setting.paddingLeft -=
                                                            0.1;
                                                      }
                                                      controller.setting
                                                          .refresh();
                                                    },
                                                    icon: Icon(Icons.remove)),
                                                Text(
                                                    "${controller.setting.value.paddingLeft.toStringAsFixed(1)}"),
                                                IconButton(
                                                    onPressed: () {
                                                      var setting = controller
                                                          .setting.value;
                                                      setting.paddingLeft +=
                                                          0.1;
                                                      controller.setting
                                                          .refresh();
                                                    },
                                                    icon: Icon(Icons.add)),
                                              ],
                                            )
                                          ]),
                                    ))),
                            Expanded(
                                child: GestureDetector(
                                    onHorizontalDragUpdate: (d) {
                                      var setting = controller.setting.value;
                                      if (setting.paddingRight < 0) {
                                        setting.paddingRight = 0;
                                      }
                                      if (d.delta.dx > 0 &&
                                          setting.paddingRight > 0) {
                                        setting.paddingRight -= 0.1;
                                      }
                                      if (d.delta.dx < 0 &&
                                          setting.paddingRight < 100) {
                                        setting.paddingRight += 0.1;
                                      }
                                      controller.setting.refresh();
                                    },
                                    child: Container(
                                      decoration: boxdeco,
                                      alignment: Alignment.center,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Right Padding"),
                                            Icon(Icons.swipe),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      var setting = controller
                                                          .setting.value;
                                                      if (setting.paddingRight >
                                                          0) {
                                                        setting.paddingRight -=
                                                            0.1;
                                                      }
                                                      controller.setting
                                                          .refresh();
                                                    },
                                                    icon: Icon(Icons.remove)),
                                                Text(
                                                    "${controller.setting.value.paddingRight.toStringAsFixed(1)}"),
                                                IconButton(
                                                    onPressed: () {
                                                      var setting = controller
                                                          .setting.value;
                                                      setting.paddingRight +=
                                                          0.1;
                                                      controller.setting
                                                          .refresh();
                                                    },
                                                    icon: Icon(Icons.add)),
                                              ],
                                            )
                                          ]),
                                    )))
                          ],
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onVerticalDragUpdate: (d) {
                          var setting = controller.setting.value;
                          if (setting.paddingBottom < 0) {
                            setting.paddingBottom = 0;
                          }
                          if (d.delta.dy > 0 && setting.paddingBottom > 0) {
                            setting.paddingBottom -= 0.1;
                          }
                          if (d.delta.dy < 0 && setting.paddingBottom < 100) {
                            setting.paddingBottom += 0.1;
                          }
                          controller.setting.refresh();
                        },
                        child: Container(
                          decoration: boxdeco,
                          alignment: Alignment.center,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text("Bottom Padding"),
                            Icon(Icons.swipe_vertical),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      var setting = controller.setting.value;
                                      if (setting.paddingBottom > 0) {
                                        setting.paddingBottom -= 0.1;
                                      }
                                      controller.setting.refresh();
                                    },
                                    icon: Icon(Icons.remove)),
                                Text(
                                    "${controller.setting.value.paddingBottom.toStringAsFixed(1)}"),
                                IconButton(
                                    onPressed: () {
                                      var setting = controller.setting.value;
                                      setting.paddingBottom += 0.1;
                                      controller.setting.refresh();
                                    },
                                    icon: Icon(Icons.add)),
                              ],
                            )
                          ]),
                        ),
                      )),
                    ],
                  );
                }
                return SizedBox();
              })
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
