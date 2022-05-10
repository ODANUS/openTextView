import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """
---
2.2.2 (2022 05 10)
1. 내서재 / 이미지 문자인식 페이지 진행 상황 글자를 좀더 크게 수정 하였습니다. 
2. PDF 전환 라이브러리를 최신 버전으로 업데이트 하였습니다. 
  - 일부 pdf 읽을때 에러 나는 현상 을 수정 한거 같습니다. 

3. 개발자 노트 상단에 유튜브 tts 샘플을 올려 드립니다. 
  - 영상은 유나, 소라 tts 음성입니다. 
  - SE2 로 녹화 하였습니다. 녹화 기능, tts, 운동 어플 3개를 동시에 켠 상태라 버벅임이 있습니다. (싼가격에 산 폰이라서요..)

  - 아직 심사 통과는 안된 상황입니다. 현재 6번 정도 반려 났습니다. 
  - 제 멘탈도 6번 정도 털렸습니다.ㅠㅠ 
  - 제 다른영상 보시면 오버워치 한조로 연속 5킬 한것도 있습니다. 최초이자 마지막 최고 플레이였습니다. 

4. 오픈소스 라이선스 항목 수정. 


---
2.2.1 (2022 05 08)

1. 내서재 에서 파일 이나 폴더를 드래그 해서 상하 테두리와 가까워 지면 자동으로 스크롤 되도록 수정. 
2. 뷰어 쪽 스크롤 를 조금더 빠르게 할수 있게. 최대 스크롤 속도를 6 -> 8 로 수정 하였습니다. 
3. epub, zip 파일 변환시 확인 창 제거.
  - 확인 문구가 너무 길어서 구글 번역으로 제대로 번역이 안되서 제거 하였습니다. 
  - 참고로 오픈텍뷰는 74 개국 언어 로 번역되어 있습니다. 번역만 되어 있습니다. 해외 사용자는 없네요. 

4. epub 텍스트 추출 시, 폰트 사이즈가 15 메가 이상이면 ocr 확인창 버튼 텍스트 수정. 
  - 기존엔 닫기, 확인 버튼이였지만. epub->text, Epub->Image->OCR 로 변경 하였습니다. 
  - 일부 epub 의 경우 특수문자를 위한 폰트가 내장 되어 있어서 오히려 ocr 로 돌릴때 폰트 처리가 안되어 내용이 깨지는 현상이 발견되었습니다. 

---
2.2.0 (2022 05 08)

1. 구글 인공지능 이미지 인식 을 beta4 로 변경 
  - 인식률이 상당히 좋아 졌습니다. 점점 인식률좋아 지는것 같습니다! 


""";

  @override
  Widget build(BuildContext context) {
    return IsarCtl.rxSetting((ctx, setting) {
      return StreamBuilder<PackageInfo>(
        stream: PackageInfo.fromPlatform().asStream(),
        builder: ((context, snapshot) {
          if (snapshot.data == null) return SizedBox();

          return ListTile(
            onTap: () async {
              // 1.4.3
              await Get.dialog(AlertDialog(
                title: Text("${snapshot.data!.version} 버전이 출시 되었습니다."),
                content: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          launchUrlString("https://www.youtube.com/watch?v=uBhiGBPOl4I");
                        },
                        child: Text("https://www.youtube.com/watch?v=uBhiGBPOl4I")),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(content),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("confirm".tr))
                ],
              ));

              IsarCtl.putSetting(setting..lastDevVersion = snapshot.data!.version);
            },
            title: Row(
              children: [
                Text("Developer notes".tr),
                SizedBox(width: 10),
                snapshot.data!.version == setting.lastDevVersion
                    ? SizedBox()
                    : Icon(
                        Icons.fiber_new,
                        color: Colors.orange,
                      ),
              ],
            ),
          );
        }),
      );
    });
  }
}
