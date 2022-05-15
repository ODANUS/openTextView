import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """

---
2.3.2 (2022 05 15)

1. 전체 화면 설정을 추가 했습니다. 
  - UI 설정 에 더블 탭시 전체화면을 설정 할수 있습니다. 
  - 하단 메뉴, 상하단 전부, 핸드폰 상단 상태표시줄도 안보이게 숨길 수 있습니다. 


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
