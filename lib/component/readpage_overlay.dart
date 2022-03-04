import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReadpageOverlay extends GetView {
  ReadpageOverlay({
    this.bScreenHelp = false,
    this.touchLayout = 0,
    this.onBackpage,
    this.onNextpage,
    this.onFullScreen,
  }) {
    if (this.bScreenHelp) {
      this.decoration = BoxDecoration(
          color: Colors.black54,
          border: Border.all(
            width: 1,
            color: Colors.white,
          ));
    }
  }

  bool bScreenHelp;
  int touchLayout;
  BoxDecoration? decoration;
  Function? onBackpage;
  Function? onFullScreen;
  Function? onNextpage;

  Widget getText(int type) {
    String str = "Back page".tr;
    var fn = onBackpage;
    if (type == 1) {
      str = "Double click to full screen".tr;
      fn = onFullScreen;
    }
    if (type == 2) {
      str = "next page".tr;
      fn = onNextpage;
    }

    return Container(
        decoration: decoration,
        alignment: Alignment.center,
        child: GestureDetector(
            onDoubleTap: () {
              if (type == 1 && fn != null) {
                fn();
              }
            },
            onTap: () {
              if ((type == 0 || type == 2) && fn != null) {
                fn();
              }
            },
            child: this.bScreenHelp
                ? Text(
                    str,
                    style: TextStyle(color: Colors.white),
                  )
                : null));
  }

  Widget layout0() {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: getText(0),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(1),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(2),
        ),
      ],
    );
  }

  Widget layout4() {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: getText(2),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(1),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(0),
        ),
      ],
    );
  }

  Widget layout5() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: getText(2),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(1),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(0),
        ),
      ],
    );
  }

  Widget layout6() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: getText(2),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: getText(2),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: getText(1),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: getText(0),
                ),
              ],
            )),
        Flexible(
          fit: FlexFit.tight,
          child: getText(0),
        ),
      ],
    );
  }

  Widget layout1() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: getText(0),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(1),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: getText(2),
        ),
      ],
    );
  }

  Widget layout2() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: getText(0),
        ),
        Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: getText(0),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: getText(1),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: getText(2),
                ),
              ],
            )),
        Flexible(
          fit: FlexFit.tight,
          child: getText(2),
        ),
      ],
    );
  }

  Widget layout3() {
    return getText(1);
  }

  @override
  Widget build(BuildContext context) {
    Widget layout = layout0();
    if (touchLayout == 1) {
      layout = layout1();
    }
    if (touchLayout == 2) {
      layout = layout2();
    }
    if (touchLayout == 3) {
      layout = layout3();
    }
    if (touchLayout == 4) {
      layout = layout4();
    }
    if (touchLayout == 5) {
      layout = layout5();
    }
    if (touchLayout == 6) {
      layout = layout6();
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: layout,
    );
    // Row(
    //   children: [Text("aaaa")],
    // );
  }
}
