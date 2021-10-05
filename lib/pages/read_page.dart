import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_textview/controller/audio_play.dart';
import 'package:open_textview/controller/global_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReadPageCtl extends GetxController {
  Rx<bool> bFind = false.obs;
}

class ReadPage extends GetView<GlobalController> {
  @override
  Widget build(BuildContext context) {
    final pageCtl = Get.put(ReadPageCtl());
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("파일명"),
        ),
        body: Obx(() => ScrollablePositionedList.builder(
            padding: EdgeInsets.all(10),
            itemCount: controller.contents.length,
            itemBuilder: (BuildContext context, int idx) {
              return Text(controller.contents[idx]);
            })),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => FloatingActionButton.extended(
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
                          ? Icon(Ionicons.search)
                          : Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      pageCtl.bFind(!pageCtl.bFind.value);
                                    },
                                    icon: Icon(Ionicons.search)),
                                if (pageCtl.bFind.value)
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.find_in_page_outlined)),
                                if (pageCtl.bFind.value)
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.low_priority))
                              ],
                            ),
                    ))),
                FloatingActionButton.extended(
                    onPressed: () => AudioPlay.play(),
                    label: AudioPlay.builder(builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      print("${!snapshot.data!.playing}");
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
                                          AudioPlay.play();
                                        },
                                        icon: Icon(Ionicons.play)),
                                ],
                              ),
                      );
                    })),
                // FloatingActionButton.extended(onPressed: () {
                //   // AudioPlay.play();
                // }, label: AudioPlay.builder(builder: (context, snapshot) {
                //   if (snapshot.connectionState == ConnectionState.waiting) {
                //     return CircularProgressIndicator();
                //   }

                //   return Row(
                //     children: [
                //       if (snapshot.data!.playing ||
                //           snapshot.data!.processingState ==
                //               AudioProcessingState.completed)
                //         IconButton(
                //             onPressed: () {
                //               AudioPlay.stop();
                //             },
                //             icon: Icon(Ionicons.stop)),
                //       if (snapshot.data!.playing)
                //         IconButton(
                //             onPressed: () {
                //               AudioPlay.pause();
                //             },
                //             icon: Icon(Ionicons.pause)),
                //       if (!snapshot.data!.playing)
                //         IconButton(
                //             onPressed: () {
                //               AudioPlay.play();
                //             },
                //             icon: Icon(Ionicons.play)),
                //     ],
                //   );
                // }))
              ],
            )));
  }
}
