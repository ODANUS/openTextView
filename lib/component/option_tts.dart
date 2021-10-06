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

    return Obx(() => Stack(
          children: [
            ExpansionTile(
              onExpansionChanged: (b) async {},
              title: Text("TTS 설정"),
              children: [
                ListTile(
                    title: Text('속도 : ${1}'),
                    subtitle: Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_before_sharp)),
                          Expanded(
                              child: Slider(
                            value: 1,
                            min: 0,
                            max: 5,
                            divisions: 500,
                            label: "1",
                            onChanged: (double v) {},
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_next_sharp)),
                        ]))),
                ListTile(
                    title: Text('볼륨 : ${1}'),
                    subtitle: Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_before_sharp)),
                          Expanded(
                              child: Slider(
                            value: 1,
                            min: 0,
                            max: 1,
                            divisions: 10,
                            label: "1",
                            onChanged: (double v) {},
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_next_sharp)),
                        ]))),
                ListTile(
                    title: Text('피치 : ${1}'),
                    subtitle: Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_before_sharp)),
                          Expanded(
                              child: Slider(
                            value: 1,
                            min: 0.5,
                            max: 2,
                            divisions: 15,
                            label: "1",
                            onChanged: (double v) {},
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_next_sharp)),
                        ]))),
                ListTile(
                    title: Text('한번에 읽을 라인수  : ${1}'),
                    subtitle: Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_before_sharp)),
                          Expanded(
                              child: Slider(
                            value: 1,
                            min: 1,
                            max: 40,
                            divisions: 40,
                            label: "1",
                            onChanged: (double v) {},
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_next_sharp)),
                        ]))),
                CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("다른 플레이어 실행시 정지"),
                    value: true,
                    onChanged: (b) {}),
                CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('헤드셋 버튼 사용'),
                    value: true,
                    onChanged: (b) {}),
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
        ));
  }
}
