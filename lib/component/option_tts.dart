import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';

class OptionTts extends GetView {
  @override
  Widget build(BuildContext context) {
    var speedCmd = "${"default speed".tr}: (1.0)";
    if (Platform.isIOS) {
      speedCmd = "${"default speed".tr}: (0.4)";
    }

    return IsarCtl.rxSetting((ctx, setting) {
      return ExpansionTile(
        onExpansionChanged: (b) async {},
        title: Text("TTS settings".tr),
        children: [
          ListTile(
              title: Text('${"speed".tr} : ${setting.speechRate.toStringAsFixed(2)}   ${speedCmd}'),
              subtitle: Container(
                  width: double.infinity,
                  // color: Colors.red,
                  child: ObxValue<RxDouble>((speechRate) {
                    return Row(children: [
                      IconButton(
                          onPressed: () {
                            var p = double.parse((setting.speechRate - 0.01).toStringAsFixed(2));
                            setting.speechRate = max(p, 0);
                            IsarCtl.putSetting(setting);
                          },
                          icon: Icon(Icons.navigate_before_sharp)),
                      Expanded(
                          child: Slider(
                        value: speechRate.value,
                        min: 0,
                        max: 5,
                        divisions: 50,
                        label: speechRate.toStringAsFixed(2),
                        onChangeEnd: (double v) {
                          IsarCtl.putSetting(setting..speechRate = v);
                        },
                        onChanged: (double v) {
                          speechRate(v);
                          // IsarCtl.putSetting(setting..speechRate = v);
                        },
                      )),
                      IconButton(
                          onPressed: () {
                            var p = double.parse((setting.speechRate + 0.01).toStringAsFixed(2));
                            setting.speechRate = min(p, 5);
                            IsarCtl.putSetting(setting);
                          },
                          icon: Icon(Icons.navigate_next_sharp)),
                    ]);
                  }, setting.speechRate.obs))),
          ListTile(
              title: Text('${"volume".tr} : ${setting.volume.toStringAsFixed(1)}'),
              subtitle: Container(
                width: double.infinity,
                // color: Colors.red,
                child: ObxValue<RxDouble>((volume) {
                  return Row(children: [
                    Expanded(
                        child: Slider(
                      value: volume.value,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      label: volume.toStringAsFixed(1),
                      onChangeEnd: (v) => IsarCtl.putSetting(setting..volume = v),
                      onChanged: volume,
                    )),
                  ]);
                }, setting.volume.obs),
              )),
          ListTile(
              title: Text('${"pitch".tr} : ${setting.pitch.toStringAsFixed(1)}'),
              subtitle: Container(
                  width: double.infinity,
                  // color: Colors.red,
                  child: ObxValue<RxDouble>((pitch) {
                    return Row(children: [
                      IconButton(
                          onPressed: () {
                            var p = double.parse((setting.pitch - 0.01).toStringAsFixed(2));
                            setting.pitch = max(p, 0.5);
                            IsarCtl.putSetting(setting);
                          },
                          icon: Icon(Icons.navigate_before_sharp)),
                      Expanded(
                          child: Slider(
                        value: pitch.value,
                        min: 0.5,
                        max: 2,
                        divisions: 15,
                        label: pitch.toStringAsFixed(1),
                        onChangeEnd: (v) => IsarCtl.putSetting(setting..pitch = v),
                        onChanged: (double v) {
                          pitch(v);
                        },
                      )),
                      IconButton(
                          onPressed: () {
                            var p = double.parse((setting.pitch + 0.01).toStringAsFixed(2));
                            setting.pitch = min(p, 2);
                            IsarCtl.putSetting(setting);
                          },
                          icon: Icon(Icons.navigate_next_sharp)),
                    ]);
                  }, setting.pitch.obs))),
          ListTile(
              title: Text('${"Number of lines to read at a time".tr}  : ${setting.groupcnt}'),
              subtitle: Container(
                width: double.infinity,
                // color: Colors.red,
                child: ObxValue<RxInt>((groupcnt) {
                  return Row(children: [
                    IconButton(
                        onPressed: () {
                          if (setting.groupcnt <= 1) return;
                          IsarCtl.putSetting(setting..groupcnt -= 1);
                        },
                        icon: Icon(Icons.navigate_before_sharp)),
                    Expanded(
                        child: Slider(
                      value: groupcnt.value < 1 ? 1 : groupcnt.toDouble(),
                      min: 1,
                      max: 40,
                      divisions: 40,
                      label: groupcnt.toStringAsFixed(0),
                      onChangeEnd: (v) {
                        IsarCtl.putSetting(setting..groupcnt = v.toInt());
                      },
                      onChanged: (double v) {
                        groupcnt(v.toInt());
                      },
                    )),
                    IconButton(
                        onPressed: () {
                          if (setting.groupcnt >= 40) return;
                          IsarCtl.putSetting(setting..groupcnt += 1);
                        },
                        icon: Icon(Icons.navigate_next_sharp)),
                  ]);
                }, setting.groupcnt.obs),
              )),
          if (Platform.isAndroid)
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("stop_audioduck".tr),
                  value: setting.audioduck,
                  onChanged: (b) {
                    IsarCtl.putSetting(setting..audioduck = b!);
                  }),
            ),
          if (Platform.isAndroid)
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Freeze when other players are running".tr),
                  value: setting.audiosession,
                  onChanged: (b) {
                    IsarCtl.putSetting(setting..audiosession = b!);
                    // setting.update((val) {
                    //   tts.audiosession = b!;
                    // });
                  }),
            ),
          if (Platform.isAndroid)
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Using the headset button'.tr),
                    value: setting.headsetbutton,
                    onChanged: (b) {
                      IsarCtl.putSetting(setting..headsetbutton = b!);
                    })),
        ],
      );
    });
  }
}
