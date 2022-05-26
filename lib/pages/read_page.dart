import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/component/comp_text_reader.dart';
import 'package:open_textview/component/comp_ui_setting.dart';
import 'package:open_textview/component/readpage_floating_button.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReadPage extends GetView {
  @override
  Widget build(BuildContext context) {
    var bFold = context.isTablet || context.isSmallTablet || context.isLargeTablet || context.isLandscape;

    return Scaffold(
        body: SafeArea(
          child: Builder(builder: (ctx) {
            return Column(
              children: [
                Obx(() => AnimatedContainer(
                    key: Key("titlebar"),
                    color: Colors.transparent,
                    duration: const Duration(milliseconds: 300),
                    height: IsarCtl.btitleFullScreen.value ? 0 : null,
                    child: Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              child: IsarCtl.rxLastHistory(
                                (ctx, data) {
                                  return Text(
                                    data.name.replaceAll(".txt", ""),
                                    style: TextStyle(fontSize: 13.sp, overflow: TextOverflow.ellipsis),
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                IsarCtl.rxLastHistory(
                                  (ctx, data) {
                                    return Text(
                                      "${(data.cntntPstn / data.contentsLen * 100).toStringAsFixed(2)}%",
                                      style: TextStyle(overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    );
                                  },
                                ),
                                SizedBox(width: 5),
                                Obx(() {
                                  if (IsarCtl.btitleFullScreen.value) {
                                    return SizedBox();
                                  }
                                  return InkWell(
                                      onTap: () => IsarCtl.bSetting(!IsarCtl.bSetting.value),
                                      child: Icon(IsarCtl.bSetting.value ? Icons.cancel : Icons.settings_outlined));
                                }),
                                SizedBox(width: 5),
                                Obx(() {
                                  if (IsarCtl.btitleFullScreen.value) {
                                    return SizedBox();
                                  }
                                  return Row(
                                    children: [
                                      if (bFold) SizedBox(width: 5),
                                      if (bFold)
                                        IsarCtl.rxSetting(
                                          (ctx, setting) {
                                            return InkWell(
                                                onTap: () {
                                                  IsarCtl.putSetting(setting..bMultiScreen = !setting.bMultiScreen);
                                                },
                                                child: RotatedBox(
                                                  quarterTurns: setting.bMultiScreen ? 0 : 1,
                                                  child: setting.bMultiScreen ? Icon(Icons.aod) : Icon(Icons.splitscreen),
                                                ));
                                          },
                                        ),
                                      if (bFold) SizedBox(width: 10),
                                    ],
                                  );
                                })
                              ],
                            )
                          ],
                        ),
                      ),
                    ))),
                // Obx(() => IsarCtl.bfullScreen.value ? SizedBox() : AdBanner()),
                Expanded(
                  child: Stack(children: [
                    IsarCtl.rxSetting((_, setting) {
                      return Container(
                        width: Get.width,
                        height: Get.height,
                        color: Color(setting.backgroundColor),
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
                            // color: Color(setting.backgroundColor),
                            decoration: BoxDecoration(
                              color: Color(setting.backgroundColor),
                              image: setting.bgIdx <= 0
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: new ColorFilter.mode(Color(setting.bgFilter), BlendMode.dstATop),
                                      image: AssetImage('assets/images/${IsarCtl.listBg[setting.bgIdx]}'),
                                    ),
                            ),
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
                    ),
                  ]),
                ),
              ],
            );
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() => AnimatedContainer(
              key: Key("bottombar"),
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(0, IsarCtl.bfullScreen.value || IsarCtl.bSetting.value ? 130 : 0, 0),
              child: readPageFloatingButton(),
            )));
  }
}
