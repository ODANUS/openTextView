import 'dart:collection';
import 'dart:developer' as d;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';

class CompTextReader extends GetView {
  CompTextReader({
    required this.setting,
    this.bPlay = false,
  }) {}

  SettingIsar setting;

  bool bPlay = false;
  final contens = IsarCtl.contents;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onVerticalDragUpdate: (d) {
            var curPos = IsarCtl.tctl.cntntPstn;
            // print(curPos);

            if (curPos <= 0 && d.delta.dy > 0 && IsarCtl.tctl.offsetY > 50) {
              return;
            }

            if (curPos >= IsarCtl.tctl.contents.length - 2 && d.delta.dy < 0) {
              return;
            }
            var dy = d.delta.dy;
            var cnt = 1;
            if (d.delta.dy < 0 && d.delta.dy < -6) {
              dy = -6;
            }
            if (d.delta.dy > 0 && d.delta.dy > 6) {
              dy = 6;
            }
            for (var i = 0; i < cnt; i++) {
              IsarCtl.tctl.offsetY += dy;
            }
          },
          onPanUpdate: (d) {
            // if (!IsarCtl.bfullScreen.value && d.delta.dy < 0) {
            //   IsarCtl.bfullScreen(true);
            //   IsarCtl.tctl.offsetY = 0;
            //   return;
            // }
            // if (IsarCtl.bfullScreen.value && d.delta.dy > 0) {
            //   IsarCtl.bfullScreen(false);
            //   IsarCtl.tctl.offsetY = 0;
            //   return;
            // }
            // var curPos = IsarCtl.tctl.cntntPstn;
            // // print(curPos);
            // if (curPos <= 0 && d.delta.dy > 0) {
            //   return;
            // }

            // if (curPos >= IsarCtl.tctl.contents.length - 2 && d.delta.dy < 0) {
            //   return;
            // }
            // print(d.delta.dy);

            // IsarCtl.tctl.offsetY += d.delta.dy;
          },
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              key: Key(IsarCtl.lastHistory?.name ?? ""),
              size: Size(100, 100),
              painter: TextViewerPainter(
                textViewerController: IsarCtl.tctl
                  ..cntntPstn = IsarCtl.cntntPstn
                  ..contents = contens.text
                  ..onChange = (idx) async {
                    IsarCtl.cntntPstnAsync(idx);
                  },
                style: IsarCtl.textStyle,
              ),
            ),
          ),
        ),
        ReadpageOverlay(
            bScreenHelp: false,
            touchLayout: setting.touchLayout,
            onFullScreen: () async {
              if (!IsarCtl.enableVolumeButton.value) {
                Get.dialog(AlertDialog(
                    content: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                )));
                await Future.delayed(50.milliseconds);
                Get.back();
                IsarCtl.enableVolumeButton(true);
              }
              IsarCtl.bfullScreen(!IsarCtl.bfullScreen.value);
            },
            onBackpage: () {
              IsarCtl.tctl.back();
            },
            onNextpage: () {
              IsarCtl.tctl.next();
            }),
      ],
    );
  }
}

class TextViewerPainter extends CustomPainter {
  TextViewerPainter({
    required this.style,
    required this.textViewerController,
  }) : super(repaint: textViewerController) {}

  TextViewerController textViewerController;

  TextStyle style;
  late double height;
  int lastPos = 0;

  Paint bg = Paint()..color = Colors.green;
  Paint highlight = Paint()..color = Colors.blueGrey.shade400;

  String getNextText(String nextText, Size size) {
    TextPainter p = TextPainter(
      text: TextSpan(text: nextText, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    List<LineMetrics> lines = p.computeLineMetrics();

    for (var line in lines) {
      if (size.height < line.baseline + line.descent) {
        var currentPageEndIndex = p.getPositionForOffset(Offset(0, line.baseline - line.ascent)).offset;
        return nextText.substring(0, currentPageEndIndex);
      }
    }
    return nextText;
  }

  String getPerText(String perText, Size size) {
    var pPer = TextPainter(
      text: TextSpan(text: perText, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    var perLines = pPer.computeLineMetrics();
    var maxPerHeight = pPer.height - size.height;
    double perHeight = 0.0;

    for (var line in perLines) {
      if (line.baseline > maxPerHeight) {
        var startPos = pPer.getPositionForOffset(Offset(line.left, line.baseline)).offset;
        return perText.substring(startPos, perText.length);
      }
    }
    return perText;
  }

  void render(Canvas canvas, Size size) {
    var ctl = textViewerController;
    var pos = ctl.cntntPstn;
    lastPos = pos;

    double offsetY = textViewerController.offsetY;

    var perText = getPerText(ctl.contents.substring(max(pos - 1000, 0), pos), size);
    var nextText = getNextText(ctl.contents.substring(pos, min(pos + 1000, ctl.contents.length)), size);
    var totalText = perText + nextText;

    var tmpperPos = min(pos, perText.length);
    var tmpTextP = TextPainter(
      text: TextSpan(text: totalText, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    var lineHeight = tmpTextP.preferredLineHeight;

    var currentOffset = tmpTextP.getOffsetForCaret(TextPosition(offset: tmpperPos), Rect.zero);

    tmpTextP.paint(canvas, Offset(0, offsetY - currentOffset.dy));
    var per = tmpTextP.getPositionForOffset(Offset(size.width, currentOffset.dy - offsetY - lineHeight));
    var next = tmpTextP.getPositionForOffset(Offset(0, currentOffset.dy - offsetY));

    var tmppo = (pos + next.offset) - tmpperPos;
    var tmpPerPo = (pos + per.offset) - tmpperPos;

    ctl.perPos = pos - perText.length;
    ctl.maxPos = pos + nextText.length;

    if (tmpPerPo != tmppo && offsetY != 0) {
      if (pos < tmppo && (tmppo - pos).abs() > 1) {
        ctl.setCntntPstn(tmppo, offsetY: 0.001);
      } else if (pos > tmpPerPo && (tmpPerPo - pos).abs() > 1) {
        ctl.setCntntPstn(tmppo, offsetY: -lineHeight + 000.1);
      }
    }

    return;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    render(canvas, size);
  }

  @override
  bool shouldRebuildSemantics(TextViewerPainter oldDelegate) {
    return textViewerController.cntntPstn != oldDelegate.lastPos;
  }

  @override
  bool shouldRepaint(TextViewerPainter oldDelegate) {
    return textViewerController.cntntPstn != oldDelegate.lastPos;
  }
}

class TextViewerController extends ChangeNotifier {
  double _offsetY = 0;
  // int _pos = 0;
  int _cntntPstn = 0;
  String contents = "";

  int lastPos = -999;

  int _per = 0;

  int _max = 0;

  bool bHighlight = false;
  int highlightPos = 0;
  int highlightCnt = 0;

  Map<int, TextPainter> cache = {};

  Function(int)? onChange;

  set cntntPstn(int v) {
    _cntntPstn = v;
  }

  int get cntntPstn => _cntntPstn;

  setCntntPstn(int v, {double offsetY = 0}) async {
    cntntPstn = v;
    _offsetY = offsetY;
    if (onChange != null) {
      onChange!(v);
    }
  }

  set offsetY(double v) {
    _offsetY = v;

    notifyListeners();
  }

  double get offsetY => _offsetY;

  set maxPos(int v) {
    if (v > contents.length - 1) {
      v = contents.length - 1;
    }
    _max = v;
  }

  int get maxPos => _max;

  set perPos(int v) => _per = v;
  int get perPos => _per;

  back() {
    onChange!(perPos);
    offsetY = 0;
    cntntPstn = perPos;
  }

  next() {
    if (maxPos < contents.length - 1) {
      onChange!(maxPos);
      offsetY = 0;
      cntntPstn = maxPos;
    }
    // print(maxPos);
  }

  // void clearItems() {
  //   items.clear();
  //   notifyListeners();
  // }
}
