import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/oss_licenses.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionOsslicense extends GetView {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExpansionTile(
            onExpansionChanged: (b) async {},
            title: Text("open source license".tr),
            children: ossLicenses
                .map((key, value) {
                  return MapEntry(
                      key,
                      Card(
                        child: ListTile(
                          title: Text(value["name"]),
                          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                              '${"license".tr} : ${value["license"]}',
                              maxLines: 5,
                            ),
                            Divider(),
                            if (value['homepage'] != null)
                              InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: new Text(
                                      'home page'.tr,
                                      style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  onTap: () {
                                    launch(value['homepage']);
                                  }),
                          ]),
                        ),
                      ));
                })
                .values
                .toList()),
      ],
    );
  }
}
