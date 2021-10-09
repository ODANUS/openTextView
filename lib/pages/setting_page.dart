import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:open_textview/component/option_backup.dart';
import 'package:open_textview/component/option_filter.dart';
import 'package:open_textview/component/option_history.dart';
import 'package:open_textview/component/option_osslicense.dart';
import 'package:open_textview/component/option_theme.dart';
import 'package:open_textview/component/option_tts.dart';
import 'package:open_textview/controller/global_controller.dart';

class SettingPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("설정"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Card(child: OptionBackup()),
          Card(child: OptionTts()),
          Card(child: OptionFilter()),
          Card(child: OptionHistory()),
          Card(child: OptionTheme()),
          // Card(child: OptionCache()),
          // Card(child: OptionOcr()),
          Card(child: OptionOsslicense()),
          if (kDebugMode)
            ElevatedButton(
                onPressed: () async {
                  AudioSession? session;
                  session = await AudioSession.instance;
                  session.setActive(true);
                  await session.configure(AudioSessionConfiguration.speech());

                  session.interruptionEventStream.listen((event) {
                    if (event.type == AudioInterruptionType.pause) {
                      if (event.begin) {
                        return;
                      }
                      if (event.begin &&
                          event.type == AudioInterruptionType.unknown) {
                        return;
                      }
                    }
                  });
                  // controller.changeTheme("dark");
                  // var status = await Permission.storage.status;

                  // if (!status.isGranted) {
                  //   await Permission.storage.request();
                  // }
                  // Directory d = Directory("${controller.libraryPaths[0]}/OCR");
                  // if (!d.existsSync()) {
                  //   d.create();
                  // }
                  // File("${d.path}/test_ocr.txt")
                  //     .writeAsStringSync("testestestes");
                  // File("${d.path}/test_ocr1.txt")
                  //     .writeAsStringSync("testestestes");
                  // File("${d.path}/test_ocr2.txt")
                  //     .writeAsStringSync("testestestes");
                },
                child: Text("test"))
        ],
      ),
    );
  }
}
