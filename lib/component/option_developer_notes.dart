import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """

---
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
