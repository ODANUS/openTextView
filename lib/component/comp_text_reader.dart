import 'dart:collection';
import 'dart:developer' as d;
import 'dart:math';
import 'dart:ui';

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
            var curPos = IsarCtl.cntntPstn;
            // print(curPos);
            if (curPos <= 0 && d.delta.dy > 0) {
              return;
            }

            if (curPos >= IsarCtl.tctl.contents.length - 2 && d.delta.dy < 0) {
              return;
            }

            IsarCtl.tctl.offsetY += d.delta.dy * 0.5;
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
                  ..onChange = (idx) {
                    IsarCtl.cntntPstn = idx;
                  },
                style: IsarCtl.textStyle,
              ),
            ),
          ),
        ),
        ReadpageOverlay(
            bScreenHelp: false,
            touchLayout: setting.touchLayout,
            onFullScreen: () {
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
  // late TextViewerPainterCtl ctl;
  TextViewerController textViewerController;

  TextStyle style;
  late double height;

  Paint bg = Paint()..color = Colors.green;
  Paint highlight = Paint()..color = Colors.blueGrey.shade400;

  void render(Canvas canvas, Size size) {
    var ctl = textViewerController;
    var pos = ctl.cntntPstn;
    // print(pos);
    double offsetY = textViewerController.offsetY;
    var tmpcontents = ctl.contents;
    var perText = tmpcontents.substring(max(pos - 1000, 0), pos);
    var nextText = tmpcontents.substring(pos, min(pos + 1000, tmpcontents.length));

    var pPer = TextPainter(
      text: TextSpan(text: perText, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    var perLines = pPer.computeLineMetrics();
    var maxPerHeight = pPer.height - size.height;
    double perHeight = 0.0;
    for (var line in perLines) {
      if (line.baseline > maxPerHeight) {
        var startPos = pPer.getPositionForOffset(Offset(line.left, line.baseline + line.descent)).offset;
        perText = perText.substring(startPos, perText.length);
        pPer = TextPainter(
          text: TextSpan(text: perText, style: style),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: size.width);
        perHeight = pPer.height;
        break;
      }
    }

    TextPainter p = TextPainter(
      text: TextSpan(text: nextText, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    List<LineMetrics> lines = p.computeLineMetrics();
    for (var line in lines) {
      if (size.height < line.baseline + line.descent) {
        var currentPageEndIndex = p.getPositionForOffset(Offset(line.left, line.baseline - line.ascent)).offset;
        p = TextPainter(
          text: TextSpan(text: nextText.substring(0, currentPageEndIndex), style: style),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: size.width);

        break;
      }
    }

    p.paint(canvas, Offset(0, offsetY));
    pPer.paint(canvas, Offset(0, offsetY - perHeight));

    var perPos = pPer.text!.toPlainText().length;

    var maxPos = p.text!.toPlainText().length;
    ctl.perPos = pos - perPos;
    ctl.maxPos = pos + maxPos;

    var po = pos + p.getPositionForOffset(Offset(0, -offsetY)).offset;
    var perPo = pos - (pPer.text!.toPlainText().length - pPer.getPositionForOffset(Offset(pPer.width, pPer.height - (offsetY))).offset);

    if (pos != po) {
      var l = p.computeLineMetrics();
      ctl.setCntntPstn(po, offsetY: offsetY + l.first.height);
    } else if (pos != perPo) {
      var l = pPer.computeLineMetrics();
      var tmppos = pos - (pPer.text!.toPlainText().length - pPer.getPositionForOffset(Offset(0, pPer.height - (offsetY))).offset);

      ctl.setCntntPstn(tmppos, offsetY: offsetY - (l.last.height));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    render(canvas, size);
  }

  @override
  bool shouldRepaint(TextViewerPainter oldDelegate) {
    return true;
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
    _offsetY = 0;
    if (onChange != null) {
      onChange!(v);
    }
    // notifyListeners();
  }

  int get cntntPstn => _cntntPstn;

  setCntntPstn(int v, {double offsetY = 0}) {
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
    offsetY = 0;
    cntntPstn = perPos;
  }

  next() {
    if (maxPos < contents.length - 1) {
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
