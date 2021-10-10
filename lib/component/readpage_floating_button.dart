import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/component/open_modal.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/controller/global_controller.dart';

class readPageFloatingButtonCtl extends GetxController {
  Rx<bool> bFind = false.obs;
  Rx<bool> bhide = false.obs;
}

class readPageFloatingButton extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(readPageFloatingButtonCtl());
    return Obx(() => Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
                onPressed: () => pageCtl.bFind(!pageCtl.bFind.value),
                label: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      child: child,
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                    ),
                  ),
                  child: !pageCtl.bFind.value
                      ? Icon(Ionicons.chevron_forward_outline)
                      : Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  pageCtl.bFind(!pageCtl.bFind.value);
                                },
                                icon: Icon(Ionicons.chevron_back_outline)),
                            if (pageCtl.bFind.value)
                              IconButton(
                                  onPressed: () {
                                    OpenModal.openSearchModal();
                                  },
                                  icon: Icon(Icons.find_in_page_outlined)),
                            if (pageCtl.bFind.value)
                              IconButton(
                                  onPressed: () {
                                    OpenModal.openJumpModal();
                                  },
                                  icon: Icon(Icons.low_priority)),
                            if (pageCtl.bFind.value)
                              IconButton(
                                  onPressed: () {
                                    OpenModal.openFontSizeModal();
                                    // OpenModal.openJumpModal();
                                  },
                                  icon: Icon(Ionicons.text_outline))
                          ],
                        ),
                )),
            FloatingActionButton.extended(
                onPressed: () => AudioPlay.play(
                    contents: controller.contents,
                    filter: controller.userData.value.filter.toList(),
                    lastData: controller.lastData.value.toMap(),
                    tts: controller.userData.value.tts.toMap()),
                label: AudioPlay.builder(builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        child: child,
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                      ),
                    ),
                    child: !snapshot.data!.playing &&
                            snapshot.data!.processingState !=
                                AudioProcessingState.completed
                        ? Icon(Ionicons.play)
                        : Row(
                            children: [
                              if (snapshot.data!.playing ||
                                  snapshot.data!.processingState ==
                                      AudioProcessingState.completed)
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
                                      AudioPlay.play(
                                          contents: controller.contents,
                                          filter: controller
                                              .userData.value.filter
                                              .toList(),
                                          lastData:
                                              controller.lastData.value.toMap(),
                                          tts: controller.userData.value.tts
                                              .toMap());
                                    },
                                    icon: Icon(Ionicons.play)),
                            ],
                          ),
                  );
                })),
          ],
        )));
  }
}
