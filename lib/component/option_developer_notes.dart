import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:package_info/package_info.dart';

class DeveloperNotesCtl extends GetxController {
  RxString version = "".obs;
  @override
  void onInit() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    version(info.version);
    // TODO: implement onInit
    super.onInit();
  }
}

class DeveloperNotes extends GetView<BoxCtl> {
  final ctl = Get.put(DeveloperNotesCtl());
  final String content = """
---
1.6.4 (2022 03 09) 패치내역 :
1. 전체화면 시 스크롤 기능을 제거 하였습니다. 가독성 향상을 위해 기능을 제거하였습니다.
2. 전체화면 시 마지막 라인을 숨기고. 페이지 넘기면 숨겨진 라인 부터 보이도록 하여 가독성을 향상 시켜 보았습니다.(기존엔 마지막 라인이 잘리는 현상이 있었습니다.)   
  - 최근 글자에 투명도가 적용되어 글자가 안보이는 치명적인 버그를 업데이트 한 적이 있습니다. 
  - 거기서 아이디어를 얻어. 전체화면시 마지막 문장을 숨겨 보았습니다.
  - 페이지 이동하면 숨겨놓은 라인부터 보이도록 하였습니다. 

  이렇게 하니까 페이지 넘길때 깜빡이는 느낌이 나는데 어떤거 같나요? 
  그냥 로딩시간이 좀 걸리는 구나 같은 느낌 인가요? 
  눈이 불편한 정도인가요?
  페이지 넘기는 애니매이션을 찾아서 넣는게 나을까요?

  리뷰나 메일로 알려 주세요. 

* 개발자 노트가 너무 길어졌습니다. 오래된 부분은 지우도록 하겠습니다. 

* 드디어 tts 문제 해결 방법을 검색하면 제가 제시한 해결책이 조금씩 검색이 되고 있습니다.
  불편을 겪는 사람들에게 어느정도 퍼지게 되면 제 어플에서는 바로가기 링크를 제거 할 예정입니다.

1.6.3 (2022 03 08) 패치내역 :
1. 여백 설정 기능 추가 하였습니다. 
 - 뷰어 페이지 우측 상단 화살표 버튼을 눌러 여백을 설정 할 수 있습니다. 
 - 원래 두손가락 제스처로 하려고 했지만. 제스처 기능을 넣으면 화면 스크롤 기능이 작동하지 않아. 버튼 형태로 변경 하였습니다. 
 

1.6.0 (2022 03 07) 패치내역 :
1. 전체 화면시 최대한 텍스트가 안잘리도록 수정. 
  - 최대한 상하 텍스트가 잘리지 않도록 상단(글꼴 크기) 하단(글꼴 크기 + (글꼴 높이 * 4)) 만큼 여백을 주고. 스크롤 처리 로직도 수정해 보았습니다. 
  하지만 이렇게 하더라도 잘리는 부분이 생길꺼 같습니다. 
  해상도 에 따라 다르게 보일 수도 있어요. 리뷰나 메일을 통해 폰 기종을 알려주세요. 

2. 백업/ 복구시 테마 데이터 가 적용 안되는 현상. 
  - 로직 확인해 보니 테마 정보를 구글드라이브에 저장하지 않고 있었습니다. 테마 정보도 구글드라이브에 저장되도록 수정 하였습니다. 

3. 내서재 메모,삭제 기능을 드래그/롱클릭 으로 처리 할 수 있도록 수정 하였습니다. 

4. 배경색, 폰트 색상 변경 기능 추가. 

5. TTS 읽던 위지에서 일시정지시 다시 해당 위치부터 읽도록 로직을 구성해 보았습니다. 

6. 5.9-1 버그 추가 작업 (tts 재생시 스크롤만 이동 하는 현상.)
  - 이 버그는 0.2 초 내에 읽기 동작이 6번 이상 반복 될경우 에러로 인식하고 정지 시키도록 수정 하였습니다. 
  - 스크롤 은 밑으로 조금 내려 가지만. 기존처럼 몇백 라인씩 내려가서 읽는 위치를 잃어 버리는 불편함을 없을듯 합니다. 


* 이번 패치는 사용자 데이터(컬러 정보) 두가지 가 추가 되었고. 수정 된 부분도 상당히 많습니다. 
  보통 이렇게 많이 수정하면 다른 버그가 발생할 확률이 증가 합니다. 
  사실 원래부터 버그가 좀 많긴 한거 같지만. 꾸준히 고도화 하다보면 나아질거라 생각 하고 있습니다. 
  버그 발견시 메일이나 리뷰로 남겨 주시기 바랍니다. 
  감사합니다.  

추후 작업 해야할 부분 : 
1. 폰트 추가 / 적용 기능 
2. 리모컨 기능 구현 가능 여부 확인. 

---
1.5.9 (2022 03 06) 패치내역 :
1. 엔진 초기화 오류시 tts 재생하면 읽지않고 스크롤만 밑으로 내려가게 되서 읽던 위치를 잃어버리를 치명적인 버그 수정. 
  - 이현상 tts 엔진을 알수없는 오류로 로딩하지 못하는 문제입니다. 에러 발생시 더이상 읽지 못하게 강제로 정지하도록 수정 하였습니다. 읽지 못하는 현상이 해결이 안된다면 껏다 켜야 할 수 도 있습니다.  
2. 기존엔 읽는 위치를 현재 스크롤 위치에서 최상단 + 한번에 읽는 라인수 기준으로 하이라이트를 표시했었 습니다. 최신 패치에서는 TTS 로 읽던 위치를 정확하게 표시하도록 수정 하였습니다. 1번 수정하다가 아이디어가 떠올라서 바로 수정 할 수 있었습니다. 

* 메일이나 리뷰로 버그를 제보해 주시면. 확인해서 최대한 빠른시일내에 수정 하도록 하겠습니다. 

---
1.5.8 (2022 03 05) 패치내역 :
1. 성능 개선. 성능이 아마 상당히 많이 개선 되었을꺼라 생각 합니다. 
  - 뷰어 페이지 에서 내용을 초당 수십번씩 새로고침 하고 있었습니다. 그냥볼때는 티가 안나는부분이라 제작 당시에는 몰랐지만. 스크롤 오류 해결하려고 여기저기 로그 를 찍다보니 발견하였습니다. 
2. 파일 열었을때. 페이지 이동방식을 기존 수동 방식이 아닌 스크롤 자체 기능을 사용해 보았습니다. 제발 이걸로 스크롤 오류가 사라졌으면 좋겠습니다.



""";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        // 1.4.3
        await Get.dialog(AlertDialog(
          title: Obx(() => Text("${ctl.version} 버전이 출시 되었습니다.")),
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
        controller.setting.update((val) {
          val!.lastDevVersion = ctl.version.value;
        });
        ctl.update();
      },
      title: Row(
        children: [
          Text("Developer notes".tr),
          SizedBox(width: 10),
          Obx(() {
            if (ctl.version.value == controller.setting.value.lastDevVersion) {
              return SizedBox();
            }
            return Icon(
              Icons.fiber_new,
              color: Colors.orange,
            );
          }),
        ],
      ),
    );
  }
}
