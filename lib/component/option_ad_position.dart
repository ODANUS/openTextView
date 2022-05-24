import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/controller/ad_ctl.dart';
import 'package:open_textview/isar_ctl.dart';

// 34.7MB -> 52.4MB

class OptionAdPosition extends GetView {
  @override
  Widget build(BuildContext context) {
    return IsarCtl.rxSetting((ctx, setting) {
      return ExpansionTile(onExpansionChanged: (b) async {}, title: Text("AD settings".tr), children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ad placement".tr,
                style: Theme.of(context).textTheme.subtitle1!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio<int>(
                          groupValue: setting.adPosition,
                          value: 0,
                          onChanged: (v) {
                            IsarCtl.putSetting(setting..adPosition = v!);
                          }),
                      Text('lower'.tr),
                    ],
                  ),
                  Row(children: [
                    Radio<int>(
                        groupValue: setting.adPosition,
                        value: 1,
                        onChanged: (v) {
                          IsarCtl.putSetting(setting..adPosition = v!);
                        }),
                    Text('Top'.tr),
                  ]),
                ],
              ),
            ],
          ),
        ),
        Obx(() {
          var df = DateTime.now().difference(setting.last24Ad);
          if (!IsarCtl.bRemoveAd.value || df.inHours >= 23) {
            return Card(
                child: ListTile(
              onTap: () async {
                IsarCtl.bLoadingSetting(true);
                if (!IsarCtl.bRemoveAd.value && await AdCtl.startRemoveRewardedAd()) {
                  IsarCtl.bLoadingSetting(false);
                  IsarCtl.putSetting(setting..last24Ad = DateTime.now());
                  IsarCtl.bRemoveAd(true);
                }
                IsarCtl.bLoadingSetting(false);
              },
              title: Text("Remove viewer banner ads for 24 hours after watching 30 seconds of ads".tr),
            ));
          }
          return SizedBox();
        })
      ]);
    });
  }
}
