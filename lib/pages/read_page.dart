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
              IsarCtl.rxLastHistory(
                (ctx, data) {
                  return Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            "${(data.cntntPstn / data.contentsLen * 100).toStringAsFixed(2)}%",
                          )));
                },
              ),
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
  }
}
