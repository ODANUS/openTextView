import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:open_textview/component/readpage_overlay.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:open_textview/model/model_isar.dart';

class CompTextReader extends GetView {
  CompTextReader({
    required this.contents,
    required this.setting,
    this.bPlay = false,
  }) {
    // print("----------->>>>>>>>----------");
  }

  SettingIsar setting;
  List<ContentsIsar> contents = [];

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
            var curPos = IsarCtl.pos;
            if (curPos <= 0 && d.delta.dy > 0) {
              return;
            }
            if (curPos >= IsarCtl.tctl.contentsMax - 2 && d.delta.dy < 0) {
              return;
            }

            IsarCtl.tctl.offsetY += d.delta.dy;
          },
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              key: Key(IsarCtl.lastHistory?.name ?? ""),
              size: Size(100, 100),
              painter: TextViewerPainter(
                  textViewerController: IsarCtl.tctl..pos = IsarCtl.pos,
                  contents: contens.map((e) => e.text).toList(),
                  style: IsarCtl.textStyle,
                  onChange: (idx) {
                    IsarCtl.pos = idx;
                  }),
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
    required List<String> contents,
    required this.style,
    required this.textViewerController,
    this.onChange,
  }) : super(repaint: textViewerController) {
    this.contentsMap = contents.asMap().map((k, v) => MapEntry(k, v));
    textViewerController.contentsMax = contents.length;
    textViewerController.onChange = onChange;

    // this.ctl = Get.put(TextViewerPainterCtl(initPos: initPos));
  }
  // late TextViewerPainterCtl ctl;
  TextViewerController textViewerController;
  late Map<int, String> contentsMap;
  TextStyle style;
  late double height;

  // bool bHighlight = false;
  // int highlightCnt = 0;

  Function(int)? onChange;

  Paint bg = Paint()..color = Colors.green;
  Paint highlight = Paint()..color = Colors.blueGrey.shade400;

  // void render(Canvas canvas, Size size) {
  //   print("--------------------------------");
  //   var pos = textViewerController.pos;
  //   print(pos);
  //   double offsetY = textViewerController.offsetY;
  //   var tmpcontents = contentsMap.values.join("\n");
  //   var perText = tmpcontents.substring(max(pos - 1000, 0), pos);
  //   var nextText = tmpcontents.substring(pos, min(pos + 1000, tmpcontents.length));

  //   print(tmpcontents.substring(pos, min(pos + 10, tmpcontents.length)));
  //   var pPer = TextPainter(
  //     text: TextSpan(text: perText, style: style),
  //     textDirection: TextDirection.ltr,
  //   )..layout(maxWidth: size.width);
  //   var perLines = pPer.computeLineMetrics();
  //   var maxPerHeight = pPer.height - size.height;
  //   double perHeight = 0.0;
  //   for (var line in perLines) {
  //     if (line.baseline > maxPerHeight) {
  //       // print("!!!!!${line.baseline} ${maxPerHeight}");
  //       var startPos = pPer.getPositionForOffset(Offset(line.left, line.baseline + line.descent)).offset;
  //       perText = perText.substring(startPos, perText.length);
  //       pPer = TextPainter(
  //         text: TextSpan(text: perText, style: style),
  //         textDirection: TextDirection.ltr,
  //       )..layout(maxWidth: size.width);
  //       perHeight = pPer.height;
  //       break;
  //     }
  //   }
  //   // print("@@@${perHeight}");
  //   String totalStr = "";
  //   TextPainter p = TextPainter(
  //     text: TextSpan(text: nextText, style: style),
  //     textDirection: TextDirection.ltr,
  //   )..layout(maxWidth: size.width);
  //   List<LineMetrics> lines = p.computeLineMetrics();
  //   for (var line in lines) {
  //     if (size.height < line.baseline + line.descent) {
  //       var currentPageEndIndex = p.getPositionForOffset(Offset(line.left, line.baseline - line.ascent)).offset;
  //       p = TextPainter(
  //         text: TextSpan(text: nextText.substring(0, currentPageEndIndex), style: style),
  //         textDirection: TextDirection.ltr,
  //       )..layout(maxWidth: size.width);
  //       // totalStr = perText + nextText.substring(0, currentPageEndIndex);

  //       break;
  //     }
  //   }

  //   // print(offsetY);
  //   p.paint(canvas, Offset(0, offsetY));
  //   pPer.paint(canvas, Offset(0, offsetY - perHeight));
  //   var po = pos + p.getPositionForOffset(Offset(0, -offsetY)).offset;
  //   var perPo = pos - pPer.getPositionForOffset(Offset(0, offsetY)).offset;
  //   if (pos != po) {
  //     setData(po, 0);
  //   } else if (pos != perPo) {
  //     setData(perPo, -(style.fontSize! + 2));
  //   }
  //   // print("po : $po");
  //   // print("perPo : $perPo");
  //   // print(" >>>> ${nextText}");
  //   // if (pos != po) {
  //   //   setData(po, 0);
  //   // }
  //   // print(tmpcontents.length);
  //   //
  //   // // print(perText);

  // }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    // canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), bg);
    var ctl = textViewerController;
    double offsetY = ctl.offsetY;
    int pos = ctl.pos;
    print("111111111111111111${DateTime.now()}");
    var perMap = perTextRender(contentsMap, pos, size);
    var nextMap = nextTextRender(contentsMap, pos, size);
    print("22222222222222222${DateTime.now()}");
    var mergeData = {...perMap, ...nextMap};

    var startOffset = offsetY - (perMap.isEmpty ? 0 : perMap.values.map((e) => e.height).reduce((v1, v2) => v1 + v2));

    int cur = 0;
    mergeData.forEach((key, value) {
      if (ctl.bHighlight && key >= ctl.highlightPos && key <= ctl.highlightPos + ctl.highlightCnt) {
        canvas.drawRect(Rect.fromLTWH(0, startOffset, value.size.width, value.size.height), highlight);
      }
      value.paint(canvas, Offset(0, startOffset));
      startOffset += value.height;

      if (startOffset <= 0) {
        cur = min(key + 1, contentsMap.length);
      }
    });

    ctl.perPos = perMap.isEmpty ? 0 : perMap.keys.first;
    ctl.minPos = cur;
    ctl.maxPos = nextMap.isEmpty ? contentsMap.length - 2 : min(nextMap.keys.last + 1, contentsMap.length);
    if (cur == ctl.maxPos) {
      ctl.maxPos++;
    }
    print("33333333333333333333${DateTime.now()}");
    if (pos != cur && mergeData[cur] != null) {
      if (pos < cur) {
        // print(ctl.offsetY + mergeData[cur - 1]!.height);
        setData(cur, 0); //ctl.offsetY - mergeData[cur]!.height);
      } else {
        double tmpOffset = -mergeData[cur]!.height + 2;
        if (cur == 0) {
          tmpOffset = 0;
        }
        setData(cur, tmpOffset);
      }
    }
  }

  setData(int pos, double offset) async {
    Future.delayed(Duration(microseconds: 1), () {
      textViewerController.offsetY = offset;
      textViewerController.pos = pos;
    });
  }

  Map<int, TextPainter> perTextRender(Map<int, String> m, int pos, Size size) {
    Map<int, TextPainter> rtn = {};
    double tmpHeight = 0;
    for (int i = pos - 1; i >= 0; i--) {
      var p = TextPainter(
        text: TextSpan(text: m[i], style: style),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);

      if (p.height > size.height) {
        TextPainter resizeP = TextPainter();
        for (var fs = 1; fs < 20; fs += 1) {
          resizeP = TextPainter(
            text: TextSpan(
                text: "${m[i]}",
                style: style.copyWith(
                  fontSize: style.fontSize! - fs,
                )),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: size.width);
          if (resizeP.height < size.height) {
            break;
          }
        }
        p = resizeP;
      }
      tmpHeight += p.height;
      if (tmpHeight > size.height) {
        break;
      }
      rtn[i] = p;
    }
    return SplayTreeMap<int, TextPainter>.from(rtn, (a, b) => a.compareTo(b));
  }

  Map<int, TextPainter> nextTextRender(Map<int, String> m, int pos, Size size) {
    Map<int, TextPainter> rtn = {};
    double tmpHeight = 0;
    for (int i = pos; i < m.length; i++) {
      var p = textViewerController.cache[i] != null
          ? textViewerController.cache[i]
          : (TextPainter(
              text: TextSpan(text: "${m[i]}", style: style),
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: size.width));
      if (p.height > size.height) {
        TextPainter resizeP = TextPainter();
        for (var fs = 1; fs < 20; fs += 1) {
          resizeP = TextPainter(
            text: TextSpan(
                text: "${m[i]}",
                style: style.copyWith(
                  fontSize: style.fontSize! - fs,
                )),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: size.width);
          if (resizeP.height < size.height) {
            break;
          }
        }
        p = resizeP;
      }
      tmpHeight += p.height;

      if (tmpHeight > size.height) {
        break;
      }
      rtn[i] = p;
    }

    return rtn;
  }

  // List<String> getSpiltText(String text, Size size, double tmpHeight) {
  //   final List<String> _pageTexts = [];
  //   var p = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     textDirection: TextDirection.ltr,
  //   )..layout(maxWidth: size.width);
  //   List<LineMetrics> lines = p.computeLineMetrics();

  //   double currentPageBottom = size.height - tmpHeight;
  //   int currentPageStartIndex = 0;
  //   int currentPageEndIndex = 0;

  //   for (int i = 0; i < lines.length; i++) {
  //     final line = lines[i];

  //     final left = line.left;
  //     final top = line.baseline - line.ascent;
  //     final bottom = line.baseline + line.descent;
  //     if (currentPageBottom < bottom) {
  //       currentPageEndIndex = p.getPositionForOffset(Offset(left, top)).offset;

  //       final pageText = text.substring(currentPageStartIndex, currentPageEndIndex);
  //       _pageTexts.add(pageText);

  //       currentPageStartIndex = currentPageEndIndex;
  //       currentPageBottom = top + size.height;
  //     }
  //   }

  //   final lastPageText = text.substring(currentPageStartIndex);
  //   _pageTexts.add(lastPageText);
  //   return _pageTexts;
  // }

  @override
  bool shouldRepaint(TextViewerPainter oldDelegate) {
    return true;
  }
}
