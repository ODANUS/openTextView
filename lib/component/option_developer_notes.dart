import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """
---
2.0.2 (2022 04 15) 패치내역 :
1. tts 재생시 하이라이트 표시 하게 수정 하였습니다. 

2.0.1 (2022 04 15) 패치내역 :
1. 스크롤을 천천히 내리면 스크롤이 안되고 제자리에서 흔들리는 현상 수정. 

2.0.0 (2022 04 15) 패치내역 :
1. 텍스트 뷰어 부분 개선 작업. 
  - 사실 개선 시도는 몇주 전부터 이틀 간격으로 계속 시도 했었습니다. 
  - 하나 수정 하면 다른하나가 문제 생겨서 수정하고 계속 수정만 하다가 멘탈 흔들리면 다시 복구 해놨었습니다. 
  - 이번엔 어느정도 쓸만하게 변경한거 같습니다. 

2. 갤럭시 스토어 에서 설치시 리뷰 를 누를경우 갤럭시 스토어로 이동 되도록 수정. 

3. 아이폰 개발 준비 하면서 사용하지 않는 라이브러리 제거. 

4. 개발자 노트 내용 길어져서 기존 내용 삭제. 

5. 오픈소스 라이선스 항목 다시 작성. 

6. epub 개행 로직 수정. 



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
                content: SingleChildScrollView(
                  child: Text(content),
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
