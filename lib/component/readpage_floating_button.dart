import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/audio_play.dart';

class readPageFloatingButton extends GetView {
  @override
  Widget build(BuildContext context) {
    // final pageCtl = Get.put(readPageFloatingButtonCtl());
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
                heroTag: "play",
                onPressed: () => AudioPlay.play(),
                label: AudioPlay.builder(builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        child: child,
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                      ),
                    ),
                    child: !snapshot.data!.playing && snapshot.data!.processingState != AudioProcessingState.completed
                        ? Icon(Ionicons.play)
                        : Row(
                            children: [
                              if (snapshot.data!.playing || snapshot.data!.processingState == AudioProcessingState.completed)
                                IconButton(
                                    onPressed: () async {
                                      var t = await OpenModal.openAutoExitModal();
                                      if (t != null) {
                                        DateTime now = DateTime.now();
                                        DateTime exitTime = now.add(Duration(minutes: t));
                                        AudioPlay.setAutoExit(t: exitTime);
                                      }
                                    },
                                    icon: Icon(Ionicons.moon_outline)),
                              if (snapshot.data!.playing || snapshot.data!.processingState == AudioProcessingState.completed)
                                IconButton(
                                    onPressed: () {
                                      AudioPlay.stop();
                                    },
                                    icon: Icon(Ionicons.stop)),
                              if (snapshot.data!.playing)
                                IconButton(
                                    onPressed: () {
                                      AudioPlay.pause();
                                    },
                                    icon: Icon(Ionicons.pause)),
                              if (!snapshot.data!.playing)
                                IconButton(
                                    onPressed: () {
                                      AudioPlay.play();
                                    },
                                    icon: Icon(Ionicons.play)),
                            ],
                          ),
                  );
                })),
          ],
        ));
  }
}
