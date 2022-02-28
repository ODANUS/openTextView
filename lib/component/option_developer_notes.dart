import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/readpage_overlay.dart';
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
1.5.2 (2022 02 28) 패치내역 :
1. tts 재생시 가끔 비정상 적으로 종료 되는 현상 수정 
2. tts 엔진 초기화 이후 바로 재생시 중얼 거리는 목소리로 출력 되는 현상 수정. 
  - 이 현상은 tts 엔진 문제로 판단 됩니다. 엔진 초기화 이후 0.9 초 딜레이 를 주었습니다 .
  - 재생시 중얼거리는 목소리 현상이 완화 된걸 확인 했지만. 다른폰은 어떤지 확인 이 안되다 보니. 여전히 중얼 거리는 목소리가 나오는경우 리뷰로 알려 주시기 바랍니다. 


1.5.1 (2022 02 28) 패치내역 :
1. 30 초 광고 제거 

1.4.8 (2022 02 06) 패치내역 : 
1. tts 재생중 다른 파일을 열경우 tts 가 중지 되도록 수정 . 

2. 라이브러리 페이지에 이미지 주소를 추가 했지만. 어떤 이유로 해당 이미지 주소가 사라진 경우 새로 이미지를 추가 할수 없던 버그 수정. 

3. 뷰어 페이지 에서 제목을 누를경우 해당 파일의 이미지가 앞으로 뜨게 됩니다. 빈공간을 누르면 사라지고. 이미지를 누르면 이미지를 변경 할 수 있습니다.
  - 독서 인증 용으로 만들어 보았지만. 뭔가 좀 허접해 보입니다. 왜 허접해 보이는지 이유를 모르겠습니다. 
  - 디자인 감각이 있으신 분은 리뷰로 왜 허접한지 알려주시면 수정 보완 하도록 하겠습니다. 
  - 근데 생각 해보면 제 어플 디자인 자체가 좀 허접 해 보입니다. 왜그런지 모르겠습니다. 
  - 디자인만 지금 세번째 바꾼건데. 발전이 없어 보입니다. 

4. 백업 / 복구시 제대로 복구 안되는 현상을 발견하여 수정 하였습니다. 

5. 히스토리 페이지도 이미지가 나오도록 수정 했습니다. 

6. 서재 / 히스토리 에서 리스트를 길게 누르시면 메모를 추가 할 수 있습니다. 

* 저번달에 추가한 기능이지만 모르시는 분이 계실꺼 같아서 언급 하고자 합니다. 
  epub 파일을 지원할수 있도록 기능을 추가 하였습니다. 
  epub 파일 을 선택하시면 epub 파일 을 텍스트로 변환해서 들을 수 있습니다. 

* 북마크 기능을 넣으려고 보니 손이 상당히 많이 가더라고요. 북마크 기능 필요 하신가요? 리뷰로 알려 주세요. 

  


1.4.5 (2022 02 04) 패치내역 : 
1. 페이지 이동 레이아웃을 설정 할 수 있도록 기능 을 추가 하였습니다. 

2. 클립보드/스크롤 을 켜고 끌 수 있도록 기능을 추가 하였습니다. 

3. tts 성능이 개선 되었습니다. 

4. tts 재생시 배터리 소모량이 3시간에 20 % 에서 4% 로 대로 낮췄습니다. (tts 엔진 제외)

5. 내서재 에서 이미지를 추가 할 수 있습니다. (한번이라도 열어본 파일만 가능 합니다.)

6. 데이터 처리 로직을 완전히 변경 하였습니다. 
  - 오래 쓰면 오래 쓸수록 어플 자체가 느려지는 현상이 발생하여.  데이터 베이스를 도입해 보았습니다. 

7. 히스토리에서 탭에서 우측 상단 다운로드 아이콘을 클릭하여 csv 로 내보낼 수 있습니다. 
  - 내보내기 종류 : 이미지,제목,읽은 위치,일자,읽은 퍼센트,총 권수,메모
  - 이미지, 권수 등은 최신 버전 이후부터 적용 됩니다. 
  - 전공서를 제외한 대부분 책은 약 16 만자 라고 합니다.  텍스트 파일 글자수 / 16만 을 하여 대충 권수를 표기 하게 됩니다. 
  - 이기능은 최신 버전부터 적용됩니다. 

* 이번 패치 로 인해 상당히 많은 부분 이 수정 되었습니다. 약 이틀동안 테스트를 했지만. 버그가 있을수 있습니다. 
  버그 발견시 리뷰로 해당 버그를 제보 해주시면 감사하겠습니다. 

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
