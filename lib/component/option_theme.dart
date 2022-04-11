import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionTheme extends GetView {
  OptionTheme({
    required this.value,
    required this.onChanged,
  });
  String value;
  Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio<String>(
                groupValue: value,
                value: "light",
                onChanged: (String? v) {
                  onChanged("light");
                }),
            Text('light theme'.tr),
          ],
        ),
        Row(children: [
          Radio(
              groupValue: value,
              value: "dark",
              onChanged: (v) {
                onChanged("dark");
              }),
          Text('Dark theme'.tr),
        ]),
      ],
    );
  }
}
