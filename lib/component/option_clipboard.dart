import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/readpage_overlay.dart';

class OptionClipboard extends GetView {
  OptionClipboard({
    required this.value,
    required this.onChanged,
  });
  bool value;
  Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text('use Clipboard'.tr),
            Switch(
                value: value,
                onChanged: (e) {
                  onChanged(e);
                }),
          ],
        ),
      ],
    );
  }
}
