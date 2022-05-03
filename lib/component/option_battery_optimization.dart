import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';

class OptionBatteryOptimization extends GetView {
  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>((reload) {
      reload.value;
      return StreamBuilder<bool?>(
        stream: DisableBatteryOptimization.isBatteryOptimizationDisabled.asStream(),
        builder: ((context, snapshot) {
          if (snapshot.data == null || snapshot.data == true) return SizedBox();

          return ListTile(
            onTap: () async {
              await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
              reload(!reload.value);
            },
            title: Text("Enable background operation".tr),
          );
        }),
      );
    }, false.obs);
  }
}
