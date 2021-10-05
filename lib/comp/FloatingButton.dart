import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/MainAudio.dart';
import 'package:open_textview/controller/MainCtl.dart';

class FloatingButton extends GetView<MainCtl> {
  // TextPlayerTask t = TextPlayerTask();

  // FlutterTts tts = FlutterTts();
  // bool bplayTts = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 2.0,
        onPressed: () async {
          String? selectedDirectory =
              await FilePicker.platform.getDirectoryPath();
          if (selectedDirectory != null) {
            print(selectedDirectory);
            var d = Directory(selectedDirectory);
            var flist = await d.list().toList();
            var f = File("/storage/emulated/0/미디어/대한민국헌법(헌법제9호).txt");
            String contents = await f.readAsString();

            print(contents);

            // var wf = File(selectedDirectory + "/test1111.txt");
            // var ss = await wf.writeAsString("adsdsdsds");
            // print(await ss.readAsString());
          }
        },
        child: Icon(Icons.volume_up));

    //   return StreamBuilder(
    //       stream: AudioService.runningStream,
    //       builder: (c, snapshot) {
    //         bool bplay = snapshot.data ?? false;

    //         return FloatingActionButton(
    //             elevation: 2.0,
    //             onPressed: () async {
    //               if (bplay) {
    //                 controller.stop();
    //               } else {
    //                 controller.play();
    //               }
    //             },
    //             child: Icon(bplay ? Icons.volume_off_sharp : Icons.volume_up));
    //       });
  }
}
