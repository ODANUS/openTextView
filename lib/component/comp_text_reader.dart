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

            IsarCtl.tctl.offsetY += d.delta.dy * 0.9;
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
                    // IsarCtl.cntntPstn = idx;
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
    // if (perLines.length == 1) {
    //   maxPerHeight = 0;
    // }
    for (var line in perLines) {
      if (line.baseline > maxPerHeight) {
        var startPos = pPer.getPositionForOffset(Offset(line.left, line.baseline)).offset;
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
    // if (ctl.highlightPos - pos >= 0) {
    //   print(ctl.highlightPos);
    //   print(pos);
    //   var top = p.getWordBoundary(TextPosition(offset: ctl.highlightPos - pos));
    //   var bottom = p.getWordBoundary(TextPosition(offset: pos - ctl.highlightPos + ctl.highlightCnt));
    //   print(top);
    //   print(bottom);
    //   canvas.drawRect(Rect.fromLTWH(0, top.end.toDouble(), size.width, bottom.end.toDouble()), highlight);

    //   // print(p.getLineBoundary(TextPosition(offset: ctl.highlightPos - pos)));
    //   // print(p.getLineBoundary(TextPosition(offset: ctl.highlightPos - pos + ctl.highlightCnt)));
    //   // print(bottom);
    // }

    pPer.paint(canvas, Offset(0, offsetY - perHeight));
    p.paint(canvas, Offset(0, offsetY));

    var perPos = pPer.text!.toPlainText().length;

    var maxPos = p.text!.toPlainText().length;
    ctl.perPos = pos - perPos;
    ctl.maxPos = pos + maxPos;

    var po = pos + p.getPositionForOffset(Offset(0, -offsetY)).offset;
    var perPo = pos - (pPer.text!.toPlainText().length - pPer.getPositionForOffset(Offset(pPer.width, pPer.height - (offsetY))).offset);

    if (pos != po) {
      var l = p.computeLineMetrics();
      ctl.setCntntPstn(po, offsetY: offsetY + l.first.height);

      // ctl.setCntntPstn(po);
    } else if (pos != perPo) {
      var l = pPer.computeLineMetrics();
      var tmppos = pos - (pPer.text!.toPlainText().length - pPer.getPositionForOffset(Offset(0, pPer.height - (offsetY))).offset);

      ctl.setCntntPstn(tmppos, offsetY: offsetY - (l.last.height));
      // ctl.setCntntPstn(tmppos);
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
    // _offsetY = 0;
    // if (onChange != null) {
    //   onChange!(v);
    // }
    // notifyListeners();
  }

  int get cntntPstn => _cntntPstn;

  setCntntPstn(int v, {double offsetY = 0}) async {
    cntntPstn = v;
    _offsetY = offsetY;
    if (onChange != null) {
      onChange!(v);
      // Future.delayed(Duration(milliseconds: 500), () async {
      // });
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
    onChange!(perPos);
  }

  next() {
    if (maxPos < contents.length - 1) {
      offsetY = 0;

      cntntPstn = maxPos;
      onChange!(maxPos);
    }
    // print(maxPos);
  }

  // void clearItems() {
  //   items.clear();
  //   notifyListeners();
  // }
}
