import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/component/comp_text_reader.dart';
import 'package:open_textview/component/comp_ui_setting.dart';
import 'package:open_textview/component/readpage_floating_button.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReadPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 30.h,
            title: InkWell(
              onTap: () {},
              child: IsarCtl.rxLastHistory(
                (ctx, data) {
                  return Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        data.name.replaceAll(".txt", ""),
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ));
                },
              ),
            ),
            actions: [
              IsarCtl.rxContents((_, contents) {
                return IsarCtl.rxLastHistory(
                  (ctx, data) {
                    return Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              "${(data.pos / contents.length * 100).toStringAsFixed(2)}%",
                            )));
                  },
                );
              }),
              InkWell(onTap: () => IsarCtl.bSetting(!IsarCtl.bSetting.value), child: Icon(Icons.settings_outlined)),
              SizedBox(width: 5),
              InkWell(
                onLongPress: () {},
                onTap: () async {
                  Get.dialog(AlertDialog(
                      content: TextField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                  )));
                  await Future.delayed(50.milliseconds);
                  Get.back();
                  IsarCtl.enableVolumeButton(true);
                },
                child: Tooltip(
                  message: "enable volume keys".tr,
                  triggerMode: TooltipTriggerMode.longPress,
                  child: Icon(Icons.stay_primary_portrait),
                ), //Icon(IsarCtl.enableVolumeButton.value ? Icons.stay_primary_portrait : Icons.phonelink_erase),
              )
            ]),
        body: Builder(builder: (ctx) {
          return Stack(children: [
            IsarCtl.rxSetting((_, data) {
              return Container(
                width: Get.width,
                height: Get.height,
                color: Color(data.backgroundColor),
              );
            }),
            AudioPlay.builder(builder: (BuildContext context, AsyncSnapshot<PlaybackState> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              // return SizedBox();
              return IsarCtl.rxSetting((_, setting) {
                return Container(
                    width: Get.width,
                    height: Get.height,
                    color: Color(setting.backgroundColor),
                    padding: EdgeInsets.only(
                      left: setting.paddingLeft,
                      right: setting.paddingRight,
                      top: setting.paddingTop,
                      bottom: setting.paddingBottom,
                    ),
                    child: IsarCtl.rxContents((_, contents) {
                      return CompTextReader(
                        contents: contents,
                        setting: setting,
                        bPlay: snapshot.data!.playing,
                      );
                    }));
              });
            }),
            Obx(
              () => IsarCtl.bSetting.value
                  ? IsarCtl.rxSetting((_, setting) {
                      return CompUiSetting(setting: setting);
                    })
                  : SizedBox(),
            )
          ]);
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() => AnimatedContainer(
            key: Key("bottombar"), duration: const Duration(milliseconds: 300), transform: Matrix4.translationValues(0, IsarCtl.bfullScreen.value ? 130 : 0, 0), child: readPageFloatingButton())));
    // floatingActionButton: Obx(() =>
    //     IsarCtl.bfullScreen.value ? SizedBox() : readPageFloatingButton()));
  }
}





// StreamBuilder<List<LocalSettingIsar>>(
                //     stream: IsarCtl.streamLocalSetting,
                //     builder: (_, localsetting) {
                //       return StreamBuilder<List<SettingIsar>>(
                //           stream: IsarCtl.streamSetting,
                //           builder: (_, setting) {
                //             if (!localsetting.hasData ||
                //                 !setting.hasData) {
                //               return SizedBox();
                //             }
                //             return CompTextReader(
                //               localSetting: localsetting.data!.first,
                //               setting: setting.data!.first,
                //             );
                //           });
                //     }),

                // IsarCtl.rxLocalSetting(builder: (ctx, data) {
                //   return IsarCtl.rxSetting(
                //       builder: (_, setting) => CompTextReader(
                //             localSetting: data,
                //             setting: setting,
                //           ));
                // ScrollablePositionedList.builder(
                //     itemScrollController: IsarCtl.itemScrollctl,
                //     itemPositionsListener: IsarCtl.itemPosListener,
                //     itemCount: data.contents.length,
                //     itemBuilder: (BuildContext context, int idx) {
                //       return Text("${data.contents[idx]}");
                //     });
                // })
                // ScrollablePositionedList.builder(
                //   key: Key(
                //       "readScroll${controller.currentHistory.value.name}"),
                //   initialScrollIndex: controller.currentHistory.value.pos,
                //   physics: controller.bFullScreen.value
                //       ? NeverScrollableScrollPhysics()
                //       : null,
                //   padding: EdgeInsets.only(bottom: 150),
                //   itemScrollController: controller.itemScrollctl,
                //   itemPositionsListener: controller.itemPosListener,
                //   itemCount: controller.contents.length,
                //   itemBuilder: (BuildContext context, int idx) {
                //     bool bPlay = snapshot.data!.playing;
                //     int pos = bPlay
                //         ? snapshot.data!.updatePosition.inSeconds
                //         : controller.currentHistory.value.pos;

                //     int max = pos + controller.setting.value.groupcnt;
                //     bool brange = bPlay && idx >= pos && idx < max;
                //     String text = controller.contents[idx];
                //     var textcolor = Color(
                //         controller.setting.value.fontColor == 0
                //             ? Theme.of(Get.context!)
                //                 .textTheme
                //                 .bodyText1!
                //                 .color!
                //                 .value
                //             : controller.setting.value.fontColor);

                //     bool bHide = false;
                //     if (controller.bFullScreen.value &&
                //         controller.max != controller.min &&
                //         controller.max == idx) {
                //       bHide = true;
                //     }
                //     return Obx(() => InkWell(
                //           // onLongPress: controller
                //           //         .setting.value.useClipboard
                //           //     ? () {
                //           //         Clipboard.setData(ClipboardData(
                //           //             text: controller.contents[idx]));
                //           //         final snackBar = SnackBar(
                //           //           content: Text(
                //           //             '[$text]\n${"Copied to clipboard".tr}.',
                //           //             style: Theme.of(context)
                //           //                 .textTheme
                //           //                 .bodyText1,
                //           //           ),
                //           //           backgroundColor: Theme.of(context)
                //           //               .backgroundColor,
                //           //           duration:
                //           //               Duration(milliseconds: 1000),
                //           //         );
                //           //         ScaffoldMessenger.of(context)
                //           //             .showSnackBar(snackBar);
                //           //       }
                //           //     : null,
                //           child: Container(
                //               decoration: BoxDecoration(
                //                   color:
                //                       brange ? Colors.blue[100] : null),
                //               child: Text("$text",
                //                   style: TextStyle(
                //                     color: bHide
                //                         ? Colors.transparent
                //                         : textcolor.withOpacity(1),
                //                     fontSize: controller
                //                         .setting.value.fontSize
                //                         .toDouble(),
                //                     fontWeight: FontWeight.values[
                //                         controller
                //                             .setting.value.fontWeight],
                //                     height: controller
                //                         .setting.value.fontHeight,
                //                     // fontFamily: controller.setting.value.fontFamily,
                //                     fontFamily: controller.setting.value
                //                                 .fontFamily ==
                //                             'default'
                //                         ? null
                //                         : controller
                //                             .setting.value.fontFamily,
                //                     letterSpacing: controller
                //                         .setting.value.letterSpacing,
                //                   ))),
                //         ));
                //   },
                // ),
                // );
                // }),
                // Obx(() {
                //   if (controller.bImageFullScreen.value) {
                //     return InkWell(
                //         onTap: () {
                //           controller.bImageFullScreen(false);
                //           controller.bFullScreen(false);
                //         },
                //         child: Container(
                //             color: Theme.of(context)
                //                 .scaffoldBackgroundColor
                //                 .withOpacity(0.2),
                //             padding: EdgeInsets.all(10),
                //             // constraints: BoxConstraints(maxHeight: Get.height / 2),
                //             alignment: Alignment.topCenter,
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 InkWell(
                //                     onTap: () {
                //                       // editImage();
                //                     },
                //                     child: Container(
                //                       constraints: BoxConstraints(
                //                           maxHeight: Get.height * 0.8,
                //                           maxWidth: Get.width * 0.8),
                //                       child: Image.network(
                //                         controller.currentHistory.value.imageUri,
                //                         // fit: BoxFit.fitHeight,
                //                         errorBuilder: (c, o, _) {
                //                           return Icon(
                //                             Icons.image_search_sharp,
                //                             size: 80,
                //                           );
                //                         },
                //                       ),
                //                     )),
                //                 SizedBox(height: 10),
                //               ],
                //             )));
                //   }
                //   return SizedBox();
                // }),
                // Obx(() {
                //   if (controller.bTowDrage.value) {
                //     var boxdeco = BoxDecoration(
                //       color: Colors.black45,
                //       border: Border.all(color: Colors.white, width: 1),
                //     );
                //     return Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Expanded(
                //           child: GestureDetector(
                //             onVerticalDragUpdate: (d) {
                //               var setting = controller.setting.value;
                //               if (setting.paddingTop < 0) {
                //                 setting.paddingTop = 0;
                //               }
                //               if (d.delta.dy < 0 && setting.paddingTop > 0) {
                //                 setting.paddingTop -= 0.1;
                //               }
                //               if (d.delta.dy > 0 && setting.paddingTop < 100) {
                //                 setting.paddingTop += 0.1;
                //               }
                //               controller.setting.refresh();
                //             },
                //             child: Container(
                //               decoration: boxdeco,
                //               alignment: Alignment.center,
                //               child: Column(
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Text("Top Padding"),
                //                     Icon(Icons.swipe_vertical),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceAround,
                //                       children: [
                //                         IconButton(
                //                             onPressed: () {
                //                               var setting =
                //                                   controller.setting.value;
                //                               if (setting.paddingTop > 0) {
                //                                 setting.paddingTop -= 0.1;
                //                               }
                //                               controller.setting.refresh();
                //                             },
                //                             icon: Icon(Icons.remove)),
                //                         Text(
                //                             "${controller.setting.value.paddingTop.toStringAsFixed(1)}"),
                //                         IconButton(
                //                             onPressed: () {
                //                               var setting =
                //                                   controller.setting.value;
                //                               setting.paddingTop += 0.1;
                //                               controller.setting.refresh();
                //                             },
                //                             icon: Icon(Icons.add)),
                //                       ],
                //                     )
                //                   ]),
                //             ),
                //           ),
                //         ),
                // Expanded(
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: GestureDetector(
                //               onHorizontalDragUpdate: (d) {
                //                 var setting = controller.setting.value;
                //                 if (setting.paddingLeft < 0) {
                //                   setting.paddingLeft = 0;
                //                 }
                //                 if (d.delta.dx < 0 &&
                //                     setting.paddingLeft > 0) {
                //                   setting.paddingLeft -= 0.1;
                //                 }
                //                 if (d.delta.dx > 0 &&
                //                     setting.paddingLeft < 100) {
                //                   setting.paddingLeft += 0.1;
                //                 }
                //                 controller.setting.refresh();
                //               },
                //               child: Container(
                //                 decoration: boxdeco,
                //                 alignment: Alignment.center,
                //                 child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       Text("Left Padding"),
                //                       Icon(Icons.swipe),
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceAround,
                //                         children: [
                //                           IconButton(
                //                               onPressed: () {
                //                                 var setting = controller
                //                                     .setting.value;
                //                                 if (setting.paddingLeft >
                //                                     0) {
                //                                   setting.paddingLeft -=
                //                                       0.1;
                //                                 }
                //                                 controller.setting
                //                                     .refresh();
                //                               },
                //                               icon: Icon(Icons.remove)),
                //                           Text(
                //                               "${controller.setting.value.paddingLeft.toStringAsFixed(1)}"),
                //                           IconButton(
                //                               onPressed: () {
                //                                 var setting = controller
                //                                     .setting.value;
                //                                 setting.paddingLeft +=
                //                                     0.1;
                //                                 controller.setting
                //                                     .refresh();
                //                               },
                //                               icon: Icon(Icons.add)),
                //                         ],
                //                       )
                //                     ]),
                //               ))),
                //       Expanded(
                //           child: GestureDetector(
                //               onHorizontalDragUpdate: (d) {
                //                 var setting = controller.setting.value;
                //                 if (setting.paddingRight < 0) {
                //                   setting.paddingRight = 0;
                //                 }
                //                 if (d.delta.dx > 0 &&
                //                     setting.paddingRight > 0) {
                //                   setting.paddingRight -= 0.1;
                //                 }
                //                 if (d.delta.dx < 0 &&
                //                     setting.paddingRight < 100) {
                //                   setting.paddingRight += 0.1;
                //                 }
                //                 controller.setting.refresh();
                //               },
                //               child: Container(
                //                 decoration: boxdeco,
                //                 alignment: Alignment.center,
                //                 child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: [
                //                       Text("Right Padding"),
                //                       Icon(Icons.swipe),
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceAround,
                //                         children: [
                //                           IconButton(
                //                               onPressed: () {
                //                                 var setting = controller
                //                                     .setting.value;
                //                                 if (setting.paddingRight >
                //                                     0) {
                //                                   setting.paddingRight -=
                //                                       0.1;
                //                                 }
                //                                 controller.setting
                //                                     .refresh();
                //                               },
                //                               icon: Icon(Icons.remove)),
                //                           Text(
                //                               "${controller.setting.value.paddingRight.toStringAsFixed(1)}"),
                //                           IconButton(
                //                               onPressed: () {
                //                                 var setting = controller
                //                                     .setting.value;
                //                                 setting.paddingRight +=
                //                                     0.1;
                //                                 controller.setting
                //                                     .refresh();
                //                               },
                //                               icon: Icon(Icons.add)),
                //                         ],
                //                       )
                //                     ]),
                //               )))
                //     ],
                //   ),
                // ),
                // Expanded(
                //     child: GestureDetector(
                //   onVerticalDragUpdate: (d) {
                //     var setting = controller.setting.value;
                //     if (setting.paddingBottom < 0) {
                //       setting.paddingBottom = 0;
                //     }
                //     if (d.delta.dy > 0 && setting.paddingBottom > 0) {
                //       setting.paddingBottom -= 0.1;
                //     }
                //     if (d.delta.dy < 0 && setting.paddingBottom < 100) {
                //       setting.paddingBottom += 0.1;
                //     }
                //     controller.setting.refresh();
                //   },
                //   child: Container(
                //     decoration: boxdeco,
                //     alignment: Alignment.center,
                //     child:
                //         Column(mainAxisSize: MainAxisSize.min, children: [
                //       Text("Bottom Padding"),
                //       Icon(Icons.swipe_vertical),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           IconButton(
                //               onPressed: () {
                //                 var setting = controller.setting.value;
                //                 if (setting.paddingBottom > 0) {
                //                   setting.paddingBottom -= 0.1;
                //                 }
                //                 controller.setting.refresh();
                //               },
                //               icon: Icon(Icons.remove)),
                //           Text(
                //               "${controller.setting.value.paddingBottom.toStringAsFixed(1)}"),
                //           IconButton(
                //               onPressed: () {
                //                 var setting = controller.setting.value;
                //                 setting.paddingBottom += 0.1;
                //                 controller.setting.refresh();
                //               },
                //               icon: Icon(Icons.add)),
                //         ],
                //       )
                //     ]),
                //   ),
                // )),
                //   ],
                // );
                // }
                // return SizedBox();