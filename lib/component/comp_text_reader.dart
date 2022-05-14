import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompTextReader extends GetView {
  CompTextReader({
    required this.setting,
    this.bPlay = false,
  }) {}
  // CompTextReaderCtl ctl = Get.put(CompTextReaderCtl(con: IsarCtl.contents.text, style: IsarCtl.textStyle));

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
            if (curPos <= 0 && d.delta.dy > 0 && IsarCtl.tctl.offsetY > 50) {
              return;
            }
            if (curPos >= IsarCtl.tctl.contents.length - 2 && d.delta.dy < 0) {
              return;
            }
            IsarCtl.basyncOffset(true);
            var dy = d.delta.dy;
            var cnt = 1;
            if (d.delta.dy < 0 && d.delta.dy < -6) {
              dy = -8;
            }
            if (d.delta.dy > 0 && d.delta.dy > 6) {
              dy = 8;
            }
            for (var i = 0; i < cnt; i++) {
              IsarCtl.tctl.offsetY += dy;
            }
            IsarCtl.basyncOffset(false);
          },
          onPanUpdate: (d) {},
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              key: Key(IsarCtl.lastHistory?.name ?? ""),
              size: Size(100, 100),
              painter: TextViewerPainter(
                textViewerController: IsarCtl.tctl
                  ..contents = contens.text
                  ..style = IsarCtl.textStyle
                  ..cntntPstn = IsarCtl.cntntPstn
                  ..onChange = (idx) async {
                    // IsarCtl.basyncOffset(true);
                    // IsarCtl.basyncOffset(false);
                    // IsarCtl.cntntPstnAsync(idx);
                  },
                // style: IsarCtl.textStyle,
              ),
            ),
          ),
        ),
        ReadpageOverlay(
            bScreenHelp: false,
            touchLayout: setting.touchLayout,
            onFullScreen: () async {
              if (!IsarCtl.enableVolumeButton.value && Platform.isAndroid) {
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
              IsarCtl.basyncOffset(true);
              IsarCtl.tctl.back();
              IsarCtl.basyncOffset(false);
            },
            onNextpage: () {
              IsarCtl.basyncOffset(true);
              IsarCtl.tctl.next();
              IsarCtl.basyncOffset(false);
            }),
      ],
    );
  }
}

class TextViewerPainter extends CustomPainter {
  TextViewerPainter({
    required this.textViewerController,
  }) : super(repaint: textViewerController) {}

  TextViewerController textViewerController;

  Paint bg = Paint()..color = Colors.green;
  Paint highlight = Paint()..color = Colors.blueGrey.shade400;

  void render(Canvas canvas, Size size) {
    var ctl = textViewerController;
    var pos = ctl.cntntPstn;

    double offsetY = textViewerController.offsetY;
    // ------------ per ------------
    var perData = ctl._getPerText(size);
    var pper = TextPainter(
      text: TextSpan(text: perData.contents + "-", style: ctl._style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    // ------------ next ------------
    var data = ctl._getNextText(size);

    var p = TextPainter(
      text: TextSpan(
        text: data.contents,
        style: ctl._style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    if (ctl.bHighlight) {
      var curHighlightPos = max(ctl.highlightPos - (pos), 0);
      var curHighlightCnt = max(ctl.highlightPos - (pos) + ctl.highlightCnt, 0);
      curHighlightCnt += data.newlineCnt;

      var tb = p.getBoxesForSelection(TextSelection(baseOffset: curHighlightPos, extentOffset: curHighlightCnt));
      tb.forEach((e) {
        var r = e.toRect();
        var rect = Rect.fromLTRB(r.left, r.top + offsetY, r.right, r.bottom + offsetY);
        // rect = Rect.fromLTRB(rect.left, rect.top, r.right, rect.bottom);
        rect = Rect.fromLTRB(rect.left, rect.top, size.width, rect.bottom);
        canvas.drawRect(rect, highlight);
      });
    }
    p.paint(canvas, Offset(0, offsetY));

    if (offsetY < -ctl.avgHeight) {
      ctl.setCntntPstn(data.nextLine, offsetY: 0);
    }
    if (offsetY > ctl.avgHeight) {
      ctl.setCntntPstn(perData.lastLine, offsetY: 0);
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
    return true;
  }

  @override
  bool shouldRepaint(TextViewerPainter oldDelegate) {
    return true;
  }
}

class TextViewerController extends ChangeNotifier {
  double _offsetY = 0;

  int _cntntPstn = 0;
  String _contents = "";

  int lastPos = -999;

  PosData perPosData = PosData();
  PosData nextPosData = PosData();

  bool bHighlight = false;
  int highlightPos = 0;
  int highlightCnt = 0;

  double avgWidth = 0.0;
  double avgHeight = 0.0;

  TextStyle? _style = TextStyle(fontSize: 14);

  Function(int)? onChange;

  set contents(String v) {
    _contents = v;
    cacheWord();
  }

  String get contents => _contents;

  set cntntPstn(int v) {
    _cntntPstn = v;

    cacheWord();
  }

  set style(TextStyle? v) {
    if (v == null) {
      return;
    }
    if (_style?.fontSize != v.fontSize ||
        _style?.height != v.height ||
        _style?.letterSpacing != v.letterSpacing ||
        _style?.fontFamily != v.fontFamily) {
      cacheMap.clear();
      cacheWord();
    }
    _style = v;
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

  back() {
    if (onChange != null) {
      onChange!(perPosData.basePos);
    }
    offsetY = 0;
    cntntPstn = perPosData.basePos;
  }

  next() {
    if (nextPosData.nextPos < contents.length - 1) {
      if (onChange != null) {
        onChange!(nextPosData.nextPos);
      }
      offsetY = 0;
      cntntPstn = nextPosData.nextPos;
    }
  }

  Map<String, List<double>> cacheMap = Map<String, List<double>>();

  PosData _getPerText(Size size) {
    PosData data = PosData();
    for (var i = 1; i < 2200; i++) {
      var perText = contents.substring(max(cntntPstn - i, 0), cntntPstn);
      var tmpData = _clcText(perText, size, max(cntntPstn - i, 0));

      if (tmpData.nextPos < cntntPstn || cntntPstn - i < 0) {
        break;
      }
      data = tmpData;
    }
    perPosData = data;
    return data;
  }

  PosData _getNextText(Size size) {
    // cntntPstn
    var nextText = contents.substring(cntntPstn, min(cntntPstn + 2200, contents.length));
    // var nextText = contents.substring(0, 20);
    nextPosData = _clcText(nextText, size, cntntPstn);

    return nextPosData;
  }

  PosData _clcText(String _str, Size size, int basePos) {
    var nextArr = _str.split("\n").map((e) => e.split(" ")).toList();
    var rtnStr = "";

    var tleng = 0;
    var lineWidth = 0.0;
    var lastWidth = 0.0;
    var lineHeight = avgHeight;

    var bBreak = false;

    var nextLine = 0;
    var newlineCnt = 0;

    for (var i = 0; i < nextArr.length; i++) {
      var newLine = nextArr[i];

      lineWidth = 0;
      lineHeight += avgHeight;

      if (bBreak || lineHeight + avgHeight > size.height) {
        break;
      }
      for (var y = 0; y < newLine.length; y++) {
        var word = newLine[y];
        var wordLen = word.length + 1;

        lastWidth = (cacheMap[word]?[0] ?? cacheMap[" "]![0]);
        lastWidth += cacheMap[" "]![0];
        lineWidth += lastWidth;

        if (lineWidth > size.width) {
          word = "\n${word.trimLeft()}";
          lineWidth = lastWidth;
          if (lastWidth > size.width) {
            lineHeight += avgHeight * (lastWidth ~/ size.width + 2);
          } else {
            lineHeight += avgHeight;
          }
          newlineCnt++;

          if (nextLine == 0) {
            nextLine = tleng;
          }

          if (lineHeight > (size.height - avgHeight)) {
            bBreak = true;
            break;
          }
        }
        rtnStr += "$word ";
        // if (y == 0) {
        // } else {
        //   rtnStr += "$word ";
        // }
        tleng += wordLen;
      }
      if (nextLine == 0) {
        nextLine = tleng;
      }
      if (i < nextArr.length - 1) {
        rtnStr += "\n";
      }
    }
    var data = PosData();
    // data.perPos = max(basePos - tleng, 0);
    data.basePos = basePos;
    data.nextPos = basePos + tleng;
    data.nextLine = basePos + nextLine;
    data.lastLine = basePos + (tleng - rtnStr.split("\n").last.length);
    data.newlineCnt = newlineCnt;
    if (data.nextPos - data.lastLine <= 1) {
      data.lastLine--;
    }
    if (data.lastLine < 0) {
      data.lastLine = 0;
    }
    data.contents = rtnStr;

    return data;
  }

  cacheWord() {
    if (contents.isEmpty || cntntPstn > contents.length) {
      return;
    }

    String str = contents.substring(max(cntntPstn - 2200, 0), min(cntntPstn + 2200, contents.length));
    var nextArr = str.split("\n").map((e) => e.split(" ")).toList();
    Map<String, int> count = {};
    var painter = TextPainter(text: TextSpan(text: " ", style: _style), textDirection: TextDirection.ltr)..layout();
    cacheMap[" "] = [painter.width, painter.height];

    for (var line in nextArr) {
      for (var word in line) {
        if (cacheMap[word] == null) {
          var painter = TextPainter(text: TextSpan(text: word, style: _style), textDirection: TextDirection.ltr)..layout();
          cacheMap[word] = [painter.width, painter.height];
          count["${painter.width},${painter.height}"] = (count["${painter.width},${painter.height}"] ?? 0) + 1;
        }
      }
    }

    var thevalue = 0;
    String thekey = "";

    count.forEach((k, v) {
      if (v > thevalue) {
        thevalue = v;
        thekey = k;
      }
    });
    if (count.isNotEmpty) {
      avgWidth = double.parse(thekey.split(",").first);
      avgHeight = double.parse(thekey.split(",").last);
    }

    // var endDate = DateTime.now();
    // print("end cache ${endDate}  :: ${endDate.difference(startDate).inMilliseconds}");
  }
}

class PosData {
  // int perPos = 0;
  int basePos = 0;
  int nextPos = 0;
  int nextLine = 0;
  int lastLine = 0;
  int newlineCnt = 0;
  String contents = "";

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        // "perPos": perPos,
        "basePos": basePos,
        "nextPos": nextPos,
        "nextLine": nextLine,
        "lastLine": lastLine,
        "contents": contents,
        "newlineCnt": newlineCnt,
      };
}
