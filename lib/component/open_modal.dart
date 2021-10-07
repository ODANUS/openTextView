import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenModal {
  static openModalSelect({required String title}) {
    final Completer completer = Completer();

    Get.dialog(AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(title),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              completer.complete(false);
              Get.back();
            },
            child: Text("취소")),
        ElevatedButton(
            onPressed: () {
              completer.complete(true);
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }

  static openModal({required String title}) {
    final Completer completer = Completer();

    Get.dialog(AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(title),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }

  static openJumpModal() {
    final Completer completer = Completer();

    Get.dialog(AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("이동"),
            ],
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("확인"))
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    )).whenComplete(() {});

    return completer.future;
  }
}
