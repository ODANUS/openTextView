import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """

---
2.3.8 (2022 05 21)
1. 뷰어 높이 계산 알고리즘 수정.
  - 기존보다 높이 계산 정확도를 높여 보았습니다. 
  - 기존 버전보다 1~2 라인 정도 화면에 더 출력 될수 있습니다.

2. 뷰어 일반 화면에 배너 광고 를 추가 하였습니다. 
  - 전체 화면 으로 전환시 자동으로 광고가 제거 됩니다. 

3. 전체화면 기능을 모르시는 분을 위해 어플 실행시 1.8초 가량 설정된 단축키 레이아웃을 잠시 보여 주고 사라지게 하였습니다. 




2.3.7 (2022 05 19)

1. 다음 페이지 첫번째 줄좌표 가 빈 줄(엔터) 일 경우 해당 좌표를 건너 뛰도록 수정 
  - 볼륨키나 터치로 페이지 넘길때 빈줄로 시작하지 않습니다.

2. 기본 글꼴 높이를 1.8 로 수정 하였습니다. 

3. 단어 단위 개행 될때 우측 빈공간을 채우기 위해 화면너비 만큼 자간을 좀더 늘리도록 설정하도록 하였습니다. 

4. 대략 한두 글자로 인해 개행 될 경우 자간을 줄여서 한줄에 보이도록 수정 하였습니다. 
  - 3글자 이상 넘어가게 해봤는데. 자간이 너무 붙어서 보기 힘들더라고요. 2글자 분량 정도만 자간을 줄이게 하였습니다.

5. 전체화면 기본 설정값을 [상,하단] 을 같이 숨기는 것으로 변경 하였습니다. 

6. 다른 이름으로 저장 기능을 제거 하였습니다. 

7. 다른 이름으로 저장 대신 드라이브 에 업로드 / 다운로드 할 수 있도록 수정 하였습니다. 
  - 파일을 드라이브에 업/다운로드 시 파일 용량에 따라 시간이 소요 됩니다. 
  - 해당 시간동안 전면광고를 출력 하였습니다. 

8. 필터 입력시 실시간으로 데이터베이스에 저장되도록 수정 하였습니다. 
  

* 이번 패치는 가독성 개선부분에 집중해 보았습니다. 
  혹시 좀더 개선할 부분이 보인다면 메일이나 리뷰를 통해 알려 주시면 감사하겠습니다.


2.3.5 (2022 05 17)
1. 다른이름으로 텍스트 파일 저장시 광고를 명확하게 표기 하였습니다. 

2.3.4 (2022 05 16)

1. txt 파일 내보내기 기능을 추가 하였습니다. 
  - 내보내기 기능은 30 초 광고재생이 끝난뒤 내보내기가 가능 합니다. 
  - 여러 파일이 있다면 합치기 기능으로 파일을 하나로 합친뒤에 내보내기를 하는것도 좋을꺼 같네요. 
  - 더이상 볼 광고가 없을경우 내보내기는 작동하지 않습니다. 
  - 광고는 12 시간동안 최대 15 번만 시청할 수 있도록 제한 을 해 놓았습니다. 

2. 내보내기 기능 사용시 면책조항 을 추가 하였습니다. 

* 7초짜리 전면광고, 30 초짜리 리워드 광고.. 광고의 종류는 다양합니다.
  하지만 광고시간 은 제 의도대로 표출되지는 않습니다. 
  7초짜리 전면광고도 몇몇광고는 30 초 이상봐야지 닫기 버튼이 나옴니다. 또 어떤건 5초 만 봐도 되는 경우가 있기도 합니다.  
  이부분은 제가 컨트롤 할 수 있는 부분은 아닙니다. 양해 부탁드립니다. 

  제가 과도한 피부가 노출되는 광고는 전부 차단해 놓은 상태이지만. 혹시나 수위가 높은 광고가 표출되면 스샷과 합께 제보 부탁드립니다. 
  몇몇 광고는 제가 직접 차단을 해야 합니다. 현재 수십개 광고를 추가로 차단해 놓긴 했습니다. 
  텍스트 뷰어 특성상 연령에 상관없이 사용자가 있다보니 수위가 높은 광고는 차단 하고 있습니다. 

---

2.3.2 (2022 05 15)

1. 전체 화면 설정을 추가 했습니다. 
  - UI 설정 에 더블 탭시 전체화면을 설정 할수 있습니다. 
  - 하단 메뉴, 상하단 전부, 폰 상단 상태표시줄도 안보이게 숨길 수 있습니다. 


2.3.1 (2022 05 15)

1. 더블탭 전체화면 로직을 수정 하였습니다. 
  - 1회 하단 메뉴 / 재생버튼 숨기기 
  - 2회 상단 타이틀 영역 숨기기 
  - 3회 상하단 전부 표시 

2. 상업용 무료 폰트 추가
  - 배민 도현, 배민 을지로체, kopub 바탕 , kopub 돋음, 마루부리, 나눔 펜, 리디 바탕 

3. 위치이동  UI 수정. 

4. 아이폰에서도 볼륨버튼으로 페이지를 이동 할 수 있도록 수정 하였습니다. 

2.3.0 (2022 05 14)

1. flutter 3.0 올라가면서 [위치이동] 슬라이더 컨트롤 하려고 하면 페이지가 전환되는 버그가 생겼습니다. 
  - 드래그 로 페이지 전환 기능을 제거 하였습니다. 
  - 상단 탭 버튼을 이용해 주세요. 

2. 뷰어 를 스크롤 해서 이동 할때 틱틱 끊기 는 현상을 완화 시켰습니다. 
  - 몇주전에 뷰어 퍼포먼스 를 위해 단어별로 사이즈를 계산하여 저장하도록 알고리즘을 만들 었습니다. 
  - 문제는 제가 저장된 값제대로 활용을 못하고 있었습니다. 
  - 저장된 값이 있으면 계산을 다시 할 필요가 없는데도 불구하고 계속 다시 계산 하고 있었습니다.  
  - 퍼포먼스가 생각 보다 만족스럽지 못해서 로직 검토하다가 발견하였습니다. 

3. 폰트 사이즈나 높이, 등등 글자 크기에 영향이 있는 옵션 수정시 캐시를 다시 생성 하도록 수정. 


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
