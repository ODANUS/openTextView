// https://www.google.com.pk/search?q=%EB%82%98%ED%98%BC%EC%9E%90%EB%A7%8C%EB%A0%88%EB%B2%A8%EC%97%85&&tbm=isch&ved=2ahUKEwiK5_jmqt_uAhWE4oUKHSH-DRYQ2-cCegQIABAA

// https://www.google.com/search?q=나혼자만 레벨업&tbm=isch&tbs=isz:m
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';

String covertStringToUnicode(String content) {
  String regex = "\\u";
  int offset = content.indexOf(regex) + regex.length;
  while (offset > -1 + regex.length) {
    int limit = offset + 4;
    String str = content.substring(offset, limit);
    if (str != null && str.isNotEmpty) {
      String code = String.fromCharCode(int.parse(str, radix: 16));
      content = content.replaceFirst(str, code, offset);
    }
    offset = content.indexOf(regex, limit) + regex.length;
  }
  return content.replaceAll(regex, "");
}

class Net {
  static Dio dio = Dio();
  static Future<List<String>> getImage(String keyword) async {
    // log("https://www.google.com/search?q=${keyword}&tbm=isch&tbs=isz:m");
    var ss = await dio.get(
        "https://www.google.com/search?q=${keyword}&tbm=isch&tbs=isz:m",
        options: Options(headers: {
          "user-agent":
              "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36"
        }));

    var data = ss.data.toString();
    // log(data);
    data = data.split("// Google Inc.").last;
    List<String> listData = data.split("https://");
    listData.removeAt(0);
    var imageurls = listData.map((e) {
      var idx = e.indexOf('"');
      if (idx >= 0) {
        try {
          return covertStringToUnicode("https://" + e.substring(0, idx))
              .toString();
        } catch (e) {}
      }
      return "";
    }).toList();
    // googleusercontent

    imageurls = imageurls.where((value) {
      if (value.contains("=CAU") ||
          value.contains(".png") ||
          value.contains(".jpg") ||
          value.contains(".webp") ||
          value.contains("googleusercontent") ||
          value.contains("jpeg") ||
          value.contains("&amp;s")) {
        return true;
      }
      return false;
    }).toList();

    return imageurls;
    // imageurls.forEach((element) {
    //   print(element);
    // });
  }
}
