import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """
---
2.0.5 (2022 04 26) 패치내역 :
1. 기본 폰트 사이즈를 20 으로 변경하였습니다. 폰트 최소 크기는 18 로 변경 하였습니다. 

2. 뷰어 페이지 로직을 새로 작성하였습니다. 
  - 어플 실행시 현재 보여져야 하는 위치 전후로 2000자 를 추출합니다. 
  - 추출한 글자는 단어 단위로 너비 와 높이 계산을 실행 합니다. 
  - 보통 첫 실행시 계산에 약 0.1 초 정도 소요 되며. 첫 계산 이후에는 평균 0.05 초 정도 계산 시간이 소요 됩니다. 
  - 이게 완벽하게 보여지는 너비를 계산 한것은 아니기 때문에. 오차가 일부 발생 합니다. 
  

3. 2번 로직 으로 인해. 기존 글자 단위로 개행된 부분이 단어 단위로 개행 되도록 수정 하였습니다. 
  - 기존엔 글자 단위로 개행이 이루워 졌습니다. 예 : [개/행된 부분이] 
  - 이번 수정 사항은 너비를 직접 계산 하여 처리 하기 때문에 단어 단위로 개행 처리가 가능 해졌습니다. 예 : [개행된 /부분이]

4. 스크롤시 그나마 조금 더 부드러워 졌습니다. 
  - 여전히 툭툭 끊기네요. 

5. 내서재 디자인을 수정 하였습니다. 

6. tts 엔진 오류 발생시 읽기 위치가 -0 이 되는 현상을 수정 하였습니다. 


2.0.4 (2022 04 25) 패치내역 :
1. 히스토리에 일자 기준으로 검색 할수 있도록 기능을 추가 했습니다. 

2. 내서재 UI 변경 
  - 파일이나 폴더를 길게 누르면 이동, 삭제, 파일 합치기 기능을 사용 할 수 있습니다. 
  - 파일 두개를 합치면 폴더로 만들 수 있습니다. 
  - 내서재 부분은 버그가 있을 수 있으니. 사용하시다가 문제가 있을경우 제보 부탁드립니다. 
  - 보통 버그는 드래그할때 생긴 반투명 아이콘이 안사라지고 계속 남아있게 됩니다. 

3. 아이콘 / 인트로 화면 수정. 

4. tts 재생시 알수없는 문제로 인해 현재 읽은 위치를 가져 오지 못한경우 읽은 위치가 0 으로 초기화 되는 현상 수정. 
  - 알수없는 문제로 현재 읽은 위치를 조회해 오지 못 할 경우 0.5 초 간격으로 5번 시도합니다. 
  - 5회 실패시 재생을 하지 않습니다. 

* 뷰어 페이지 관련
  - 현재 대대적으로 수정 중입니다. 
  - 조만간 좀더 부드럽고 보기 편하게 개편하도록 하겠습니다.
  - 원래 기획은 이번 패치에 추가해서 배포 하려고 했지만. 다양한 버그로 인해 다음 패치에 수정하도록 하겠습니다.

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
