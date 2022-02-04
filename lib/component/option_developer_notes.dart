import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/box_ctl.dart';
import 'package:open_textview/component/readpage_overlay.dart';

class DeveloperNotes extends GetView<BoxCtl> {
  final String content = """
1. 페이지 이동 레이아웃을 설정 할 수 있도록 기능 을 추가 하였습니다. 

2. 클립보드/스크롤 을 켜고 끌 수 있도록 기능을 추가 하였습니다. 

3. tts 성능이 개선 되었습니다. 

4. tts 재생시 배터리 소모량이 3시간에 20 % 에서 4% 로 대로 낮췄습니다. (tts 엔진 제외)

5. 내서재 에서 이미지를 추가 할 수 있습니다. (한번이라도 열어본 파일만 가능 합니다.)

6. 데이터 처리 로직을 완전히 변경 하였습니다. 
  - 오래 쓰면 오래 쓸수록 어플 자체가 느려지는 현상이 발생하여.  데이터 베이스를 도입해 보았습니다. 

7. 히스토리에서 탭에서 우측 상단 다운로드 아이콘을 클릭하여 csv 로 내보낼 수 있습니다. 
  - 내보내기 종류 : 이미지,제목,읽은 위치,일자,읽은 퍼센트,총 권수
  - 이미지, 권수 등은 최신 버전 이후부터 적용 됩니다. 
  - 전공서를 제외한 대부분 책은 약 16 만자 라고 합니다.  텍스트 파일 글자수 / 16만 을 하여 대충 권수를 표기 하게 됩니다. 
  - 이기능은 최신 버전부터 적용됩니다. 

* 이번 패치 로 인해 상당히 많은 부분 이 수정 되었습니다. 약 이틀동안 테스트를 했지만. 버그가 있을수 있습니다. 
  버그 발견시 리뷰로 해당 버그를 제보 해주시면 감사하겠습니다. 

""";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // 1.4.3
        Get.dialog(AlertDialog(
          title: Text("1.4.4 버전이 출시 되었습니다."),
          content: SingleChildScrollView(
            child: Text(content),
          ),
        ));
      },
      title: Text("Developer notes".tr),
    );
  }
}
