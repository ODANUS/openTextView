import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            key: Key(IsarCtl.lastHistory?.name ?? ""),
            size: Size(100, 100),
            painter: TextViewerPainter(
              textViewerController: IsarCtl.tctl
                ..bMultiScreen = setting.bMultiScreen && (context.isSmallTablet || context.isLargeTablet || context.isTablet || context.isLandscape)
                ..contents = contens.text
                ..style = IsarCtl.textStyle
                ..cntntPstn = IsarCtl.cntntPstn
                ..onChange = (idx) async {},
            ),
          ),
        ),
        Obx(() => ReadpageOverlay(
            onVerticalDragUpdate: (DragUpdateDetails d) async {
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
              cnt += dy.abs() ~/ 8;
              if (d.delta.dy < 0 && d.delta.dy < -8) {
                dy = -8;
              }
              if (d.delta.dy > 0 && d.delta.dy > 8) {
                dy = 8;
              }
              for (var i = 0; i < cnt; i++) {
                IsarCtl.tctl.offsetY += dy;
                await Future.delayed(5.milliseconds);
              }
              IsarCtl.basyncOffset(false);
            },
            bScreenHelp: IsarCtl.bScreenHelp.value,
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

              if (setting.fullScreenType == 0 && !IsarCtl.bfullScreen.value) {
                IsarCtl.bfullScreen(true);
                return;
              }
              if (setting.fullScreenType == 1 && !IsarCtl.bfullScreen.value) {
                IsarCtl.bfullScreen(true);
                IsarCtl.btitleFullScreen(true);
                return;
              }
              if (setting.fullScreenType == 2 && !IsarCtl.bfullScreen.value) {
                IsarCtl.bfullScreen(true);
                IsarCtl.btitleFullScreen(true);
                await SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.manual,
                  overlays: [],
                );
                return;
              }

              if (IsarCtl.bfullScreen.value) {
                IsarCtl.bfullScreen(false);
                IsarCtl.btitleFullScreen(false);
                await SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.manual,
                  overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
                );
                // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                return;
              }
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
            })),
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
  String lastData = "";
  List<TextSpan> spans = [];

  String leftLastData = "";
  String rightLastData = "";
  List<TextSpan> leftSpans = [];
  List<TextSpan> rightSpans = [];

  List<TextSpan> strToSpans(PosData data, Size size) {
    var ctl = textViewerController;
    return data.contents
        .split("\n")
        .asMap()
        .map((idx, e) {
          if (e.trim().isEmpty) {
            return MapEntry(
                idx,
                TextSpan(
                  text: "\n",
                  style: ctl._style,
                ));
          }

          var tmpP = TextPainter(
            text: TextSpan(
              text: e,
              style: ctl._style,
            ),
            textDirection: TextDirection.ltr,
          )..layout();
          var curWidth = tmpP.width;
          // var curWidth = data.lineWidths[idx];

          if (curWidth >= size.width) {
            //* 0.98
            return MapEntry(
                idx,
                TextSpan(
                  text: "$e\n",
                  style: ctl._style?.copyWith(letterSpacing: -((size.width) / curWidth) - 0.1),
                ));
          }
          if (idx < data.lineWidths.length && curWidth > size.width * 0.8 && curWidth <= size.width * 0.92) {
            return MapEntry(
                idx,
                TextSpan(
                  text: "$e\n",
                  style: ctl._style?.copyWith(letterSpacing: (size.width / curWidth)),
                ));
          }

          return MapEntry(
              idx,
              TextSpan(
                text: "$e\n",
                style: ctl._style,
              ));
        })
        .values
        .toList();
  }

  void render(Canvas canvas, Size size) {
    var ctl = textViewerController;
    var pos = ctl.cntntPstn;

    double offsetY = textViewerController.offsetY;
    // ------------ per ------------
    var perData = ctl._getPerText(size);
    ctl.perPosData = perData;
    // var pper = TextPainter(
    //   text: TextSpan(text: perData.contents + "-", style: ctl._style),
    //   textDirection: TextDirection.ltr,
    // )..layout();

    if (ctl.bMultiScreen) {
      var dataLeft = ctl._getNextText(Size(size.width * 0.49, size.height));
      var dataRight = ctl._getNextText(Size(size.width * 0.49, size.height), pos: dataLeft.nextPos);
      ctl.nextPosData = dataRight;

      if (leftLastData != dataLeft.contents) {
        leftSpans = strToSpans(dataLeft, Size(size.width * 0.49, size.height));
        leftLastData = dataLeft.contents;
      }
      var pLeft = TextPainter(
          text: TextSpan(
            children: leftSpans,
          ),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: size.width * 0.49);
      if (ctl.bHighlight) {
        var curHighlightPos = max(ctl.highlightPos - (pos), 0);
        var curHighlightCnt = max(ctl.highlightPos - (pos) + ctl.highlightCnt, 0);
        curHighlightCnt += dataLeft.newlineCnt;

        var tb = pLeft.getBoxesForSelection(TextSelection(baseOffset: curHighlightPos, extentOffset: curHighlightCnt));
        tb.forEach((e) {
          var r = e.toRect();
          var rect = Rect.fromLTRB(r.left, r.top + offsetY, r.right, r.bottom + offsetY);
          // rect = Rect.fromLTRB(rect.left, rect.top, r.right, rect.bottom);
          rect = Rect.fromLTRB(rect.left, rect.top, size.width * 0.49, rect.bottom);
          canvas.drawRect(rect, highlight);
        });
      }
      pLeft.paint(canvas, Offset(0, offsetY));
      if (rightLastData != dataRight.contents) {
        rightSpans = strToSpans(dataRight, Size(size.width * 0.49, size.height));
        rightLastData = dataRight.contents;
      }
      var pRight = TextPainter(
          text: TextSpan(
            children: rightSpans,
          ),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: size.width * 0.49);
      pRight.paint(canvas, Offset(size.width * 0.51, 0));

      canvas.drawLine(
        Offset(size.width * 0.495, 0),
        Offset(size.width * 0.495, size.height),
        Paint()..color = (ctl._style?.color ?? Colors.white).withOpacity(0.4),
      );
      if (offsetY < -ctl.avgHeight) {
        ctl.setCntntPstn(dataLeft.nextLine, offsetY: 0);
      }
      if (offsetY > ctl.avgHeight) {
        ctl.setCntntPstn(perData.lastLine, offsetY: 0);
      }
    } else {
      var data = ctl._getNextText(size);
      ctl.nextPosData = data;
      var start = DateTime.now();

      if (lastData != data.contents) {
        spans = strToSpans(data, size);
        lastData = data.contents;
      }

      var p = TextPainter(
        text: TextSpan(
          children: spans,
          // text: data.contents,
          // style: ctl._style,
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

  // double avgWidth = 0.0;
  double avgHeight = 0.0;
  double newLineheight = 0.0;

  bool bMultiScreen = false;

  TextStyle? _style = TextStyle(fontSize: 25);

  TextStyle? _laststyle = TextStyle();

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
    return data;
  }

  PosData _getNextText(Size size, {int? pos}) {
    // cntntPstn
    var nextText = "";
    PosData rtnNextData;
    if (pos == null) {
      nextText = contents.substring(cntntPstn, min(cntntPstn + 2200, contents.length));
      rtnNextData = _clcText(nextText, size, cntntPstn, bnext: true);
    } else {
      nextText = contents.substring(pos, min(pos + 2200, contents.length));
      rtnNextData = _clcText(nextText, size, pos, bnext: true);
    }
    // var nextText = contents.substring(0, 20);

    for (var i = 0; i < 4; i++) {
      if (rtnNextData.nextPos < contents.length) {
        var nextStr = contents.substring(rtnNextData.nextPos, min(rtnNextData.nextPos + 1, contents.length));
        if (nextStr.trim().isEmpty) {
          rtnNextData.nextPos++;
        }
      }
    }

    return rtnNextData;
  }

  PosData _clcText(String _str, Size size, int basePos, {bool bnext = false}) {
    var nextArr = _str.split("\n").map((e) => e.split(" ")).toList();
    var rtnStr = "";

    var tleng = 0;
    var lineWidth = 0.0;
    var lastWidth = 0.0;

    // var _avgHeight = avgHeight;
    var lineHeight = avgHeight; //avgHeight * 0.8;

    var bBreak = false;

    var nextLine = 0;
    var newlineCnt = 0;
    List<double> lineWidths = [];
    for (var i = 0; i < nextArr.length; i++) {
      var newLine = nextArr[i];

      lineWidth = 0;
      if (newLine.isEmpty || newLine.first.isEmpty) {
        lineHeight += newLineheight;
      } else {
        lineHeight += avgHeight;
      }
      if (bBreak || lineHeight >= size.height) {
        break;
      }

      for (var y = 0; y < newLine.length; y++) {
        var word = newLine[y];
        var wordLen = word.length + 1;

        lastWidth = (cacheMap[word]?[0] ?? cacheMap[" "]![0]);
        lastWidth += cacheMap[" "]![0];
        lineWidth += lastWidth;

        if (lineWidth > (size.width + (cacheMap[" "]![0] * 2))) {
          word = "\n${word.trimLeft()}";

          lineWidths.add(lineWidth - lastWidth);
          lineWidth = lastWidth;
          if (lastWidth > size.width) {
            lineHeight += avgHeight * ((lastWidth ~/ size.width) + 1);
          } else {
            lineHeight += avgHeight;
          }
          newlineCnt++;

          if (nextLine == 0) {
            nextLine = tleng;
          }

          if (lineHeight > size.height) {
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
      lineWidths.add(lineWidth - lastWidth);
    }

    lineWidths.add(0.0);

    var data = PosData();

    // data.perPos = max(basePos - tleng, 0);
    data.basePos = basePos;
    data.nextPos = basePos + tleng;
    data.nextLine = basePos + nextLine;
    data.lastLine = basePos + (tleng - rtnStr.split("\n").last.length);
    data.newlineCnt = newlineCnt;
    data.lineWidths = lineWidths;
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
    if (kDebugMode) avgHeight = 0.0;
    if (kDebugMode) newLineheight = 0.0;

    if (_laststyle?.fontSize != _style?.fontSize ||
        _laststyle?.height != _style?.height ||
        _laststyle?.letterSpacing != _style?.letterSpacing ||
        _laststyle?.fontFamily != _style?.fontFamily) {
      cacheMap.clear();
      avgHeight = 0.0;
      newLineheight = 0.0;
      if (_style != null) {
        _laststyle = _style!.copyWith();
      }
    }
    if (avgHeight == 0.0) {
      avgHeight = (TextPainter(text: TextSpan(text: "A", style: _style), textDirection: TextDirection.ltr)..layout()).height;
    }
    if (newLineheight == 0.0) {
      newLineheight = ((TextPainter(
                      text: TextSpan(children: [
                        TextSpan(text: "A", style: _style),
                        TextSpan(text: "\n", style: _style),
                      ]),
                      textDirection: TextDirection.ltr)
                    ..layout())
                  .height -
              avgHeight) *
          max(0.35, ((_style?.height ?? 1.8) - 1 - 1).abs());
    }

    if (contents.isEmpty || cntntPstn > contents.length) {
      return;
    }

    String str = contents.substring(max(cntntPstn - 3200, 0), min(cntntPstn + 3200, contents.length));
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
  List<double> lineWidths = [];

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        // "perPos": perPos,
        "basePos": basePos,
        "nextPos": nextPos,
        "nextLine": nextLine,
        "lastLine": lastLine,
        "contents": contents,
        "newlineCnt": newlineCnt,
        "lineWidths": lineWidths,
      };
}
