import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/readpage_overlay.dart';

class OptionLayout extends GetView<BoxCtl> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExpansionTile(
          onExpansionChanged: (b) async {},
          title: Text("layout Setting".tr),
          children: [
            Container(
                height: 300,
                child: Obx(
                  () => ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...[0, 1, 2, 3].map((e) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              InkWell(
                                onTap: () {
                                  controller.setting.value.touchLayout = e;
                                  controller.setting.refresh();
                                },
                                child: Container(
                                    width: 200,
                                    height: 200,
                                    child: ReadpageOverlay(
                                      bScreenHelp: true,
                                      touchLayout: e,
                                    )),
                              ),
                              Radio(
                                  value: e,
                                  groupValue:
                                      controller.setting.value.touchLayout,
                                  onChanged: (idx) {
                                    controller.setting.value.touchLayout = e;
                                    controller.setting.refresh();
                                  })
                            ]));
                      }).toList(),
                    ],
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
