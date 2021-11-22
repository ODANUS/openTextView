import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:open_textview/provider/Gdrive.dart';
import 'package:open_textview/provider/utils.dart';

class OptionTtsCtl extends GetxController {
  // RxList<File> backupFiles = RxList<File>();
  Rx<bool> isLoading = false.obs;
}

class OptionTts extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(OptionTtsCtl());

    return Obx(() {
      var tts = controller.userData.value.tts;
      return Stack(
        children: [
          ExpansionTile(
            onExpansionChanged: (b) async {},
            title: Text("TTS settings".tr),
            children: [
              ListTile(
                  title: Text(
                      '${"speed".tr} : ${tts.speechRate.toStringAsFixed(2)}'),
                  subtitle: Container(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              controller.userData.update((val) {
                                tts.speechRate -= 0.01;
                              });
                            },
                            icon: Icon(Icons.navigate_before_sharp)),
                        Expanded(
                            child: Slider(
                          value: tts.speechRate,
                          min: 0,
                          max: 5,
                          divisions: 50,
                          label: tts.speechRate.toStringAsFixed(2),
                          onChanged: (double v) {
                            controller.userData.update((val) {
                              tts.speechRate = v;
                            });
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              controller.userData.update((val) {
                                tts.speechRate += 0.01;
                              });
                            },
                            icon: Icon(Icons.navigate_next_sharp)),
                      ]))),
              ListTile(
                  title:
                      Text('${"volume".tr} : ${tts.volume.toStringAsFixed(1)}'),
                  subtitle: Container(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Row(children: [
                        Expanded(
                            child: Slider(
                          value: tts.volume,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          label: tts.volume.toStringAsFixed(1),
                          onChanged: (double v) {
                            controller.userData.update((val) {
                              tts.volume = v;
                            });
                          },
                        )),
                      ]))),
              ListTile(
                  title:
                      Text('${"pitch".tr} : ${tts.pitch.toStringAsFixed(1)}'),
                  subtitle: Container(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              controller.userData.update((val) {
                                tts.pitch -= 0.1;
                              });
                            },
                            icon: Icon(Icons.navigate_before_sharp)),
                        Expanded(
                            child: Slider(
                          value: tts.pitch,
                          min: 0.5,
                          max: 2,
                          divisions: 15,
                          label: tts.pitch.toStringAsFixed(1),
                          onChanged: (double v) {
                            controller.userData.update((val) {
                              tts.pitch = v;
                            });
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              controller.userData.update((val) {
                                tts.pitch += 0.1;
                              });
                            },
                            icon: Icon(Icons.navigate_next_sharp)),
                      ]))),
              ListTile(
                  title: Text(
                      '${"Number of lines to read at a time".tr}  : ${tts.groupcnt}'),
                  subtitle: Container(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              controller.userData.update((val) {
                                tts.groupcnt -= 1;
                              });
                            },
                            icon: Icon(Icons.navigate_before_sharp)),
                        Expanded(
                            child: Slider(
                          value: tts.groupcnt.toDouble(),
                          min: 1,
                          max: 40,
                          divisions: 40,
                          label: tts.groupcnt.toStringAsFixed(0),
                          onChanged: (double v) {
                            controller.userData.update((val) {
                              tts.groupcnt = v.toInt();
                            });
                          },
                        )),
                        IconButton(
                            onPressed: () {
                              controller.userData.update((val) {
                                tts.groupcnt += 1;
                              });
                            },
                            icon: Icon(Icons.navigate_next_sharp)),
                      ]))),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Freeze when other players are running".tr),
                    value: tts.audiosession,
                    onChanged: (b) {
                      controller.userData.update((val) {
                        tts.audiosession = b!;
                      });
                    }),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text('Using the headset button'.tr),
                      value: tts.headsetbutton,
                      onChanged: (b) {
                        controller.userData.update((val) {
                          tts.headsetbutton = b!;
                        });
                      })),
            ],
          ),
          if (pageCtl.isLoading.value)
            Positioned.fill(
              child: Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
    });
  }
}
