import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';

// 34.7MB -> 52.4MB

class DeveloperNotes extends GetView {
  final String content = """

---
1.9.1 (2022 04 10) 패치내역 :
1. 내서재 에서 확장자 기준으로 필터 할수 있게 기능을 추가 하였습니다. 
  - epub 변환, 인공지능 문자 인식 기능 추가 하면서 내서재가 상당히 복잡해 진거 같아 추가 하였습니다. 

* 추가:
1. 이제 뷰어 쪽이랑 내 서재 쪽은 완성도가 어느정도 올라갔다고 판단됩니다. 
2. 한동안 패치는 히스토리 부분 으로 진행될 예정입니다. 

---
1.9.0 (2022 04 10) 패치내역 :
1. 뷰어 맨하단 글자가 가끔 깜빡이는 현상 완화. 
  - 뷰어 부분은 좌표 계산 부터 많은 부분을 직접 구현했습니다. 
  - 뷰어쪽 대부분 버그는 제가 좌표계산을 잘못한 문제 입니다. ㅠㅠ 
  - 버그 발견시 제보 부탁드립니다. 

2. 뷰어,서재,설정, 히스토리 에 배경 이미지를 설정 할 수 있습니다.  
  - 뷰어 -> 톱니바퀴 -> UI 설정 에서 설정 가능합니다. 
  - 인터넷 에서 찾은 무료이미지 9 개를 추가 하였고. 투명도를 적절히 줘서 은은하게 표현 되도록 하였습니다. 
  - 투명도는 임의로 설정 이 가능합니다. 

3. 과거 데이터 베이스를 연동 로직을 제거 하였습니다. 며칠 상황봐서 해당 라이브러리를 제거 하겠습니다. 

---
1.8.7 (2022 04 09) 패치내역 :

1. 분할 압축 단위를 500 -> 1000 으로 변경 하였습니다.  

1.8.6 (2022 04 09) 패치내역 :
1. 압축 해제시 자연정렬 알고리즘을 통해 파일 을 정렬한후 압축 해제를 하였습니다. 
2. ocr 페이지 또한 자연정렬 알고리즘을 통해 정렬 한뒤 이미지 인식을 하게 됩니다. 

1.8.1 (2022 04 09) 패치내역 :
1. 이미지가 500 장이 넘는 압축파일의 경우 분할 압축을 실행하여 500 장씩 나눠서 따로 저장하게 됩니다. 
  - 중간에 오류가 발생할 경우 다시 대기 해야 하는 상황이 생겨 분할 하여 처리 하도록 수정 하였습니다. 
  - 500개 이미지는 은 대략 1분 40 초 처리 분량 입니다. 

1.8.0 (2022 04 08) 패치내역 :
1. 개행 정리 로직추가 개선, 
  - 한줄의 시작이 " 일 경우 엔터 처리. 한줄에 " 로 시작한경우 그줄의 [다.] 개행은 무시 
  - ocr 읜 경우 ["] 쌍따옴표가 인식이 안되는 경우가 있어서 [말하기] 의 시작과 끝을 구분해서 개행하지는 않습니다. 

2. 광고 흑화현상 개선. 
  - 처음 어플이 실행 되면 모든 광고를 로드 해오는데. 시간이 지나면 해당 광고 는 페기 되는거 같습니다. 
  - 미리 로드 하지 않고 광고를 보여줄때 로드 하도록 수정 하였습니다. 

3. 내서재에 이미지 변환 , epub 변환 지원 한다고 써놓았습니다! 

---

1.7.9 (2022 04 08) 패치내역 :

1. 개행 정리 로직을 한줄 개행에서 두줄 개행으로 변경 하였습니다. 
  - 내서재 ui 가 보기 불편하여 버튼을 4개로 배치하고 다른이름으로 저장은 우선 제거 하였습니다. 

2. 30 초 광고 를 전면 보상형 광고(베타) -> 리워드 광고로 수정 했습니다. 
  - 광고의 경우 개발자가 테스트 한다고 막 클릭할수가 없습니다.ㅠㅠ 
  - 개발용 광고로 테스트 하면 흑화현상이 없는데. 실제 광고로 하면 가끔 흑화 현상이 나오네요..ㅠㅠ 
  - ad 사이트 보니 전면 광고에 "베타" 라고 적혀 있어서 리워드 로 바꿔 보았습니다. 




---
1.7.8 (2022 04 07) 패치내역 :
1. 첫번째 라인 으로 안가던 버그 수정. 
2. (베타) 개행 정리 기능을 추가 했습니다. 
  -   쌍따옴표, 한글 쌍따옴표, [다.] 물음표, 느낌표, 홀따옴표 등등 19 가지 기준으로 개행을 실행합니다.
3. (베타) epub 를 텍스트로 변경 하면서 2번 개행처리도 같이 진행 하도록 수정 해 보았습니다.
4. (베타) 인공지능 이미지 텍스트 인식 기능을 추가 하였습니다. 
  - 인공지능이라 하니 뭔가 있어 보입니다. 
  - 근데 진짜 인공지능이 맞습니다. 물론 제가 만든건 아니고요. 구글 에서 만든 거에요. 
  - 한국어, 영어, 일본어, 중국어 를 지원합니다. 추후 구글에서 언어를 추가 하면 저도 추가하도록 하겠습니다. 
  - 그냥 쓰려고 했더니 용량이 140 메가 정도로 증가해서 안면익식, 번역기능 등 불필요한 학습데이터 제거 하였습니다. 그래도 19 메가 정도 증가 했네요. 
5. 압축 파일 선택시 OCR 버튼이, epub 는 텍스트 변환 버튼이 나오도록 ui 를 수정 하였습니다. 
6. 변환 된 파일은 내보내기 기능으로 저장 할 수 있습니다. (5초 광고 추가 하였습니다.)

7. 몇몇 광고를 추가 하였습니다. 
  - 1~5 초 이내 로 처리되는 로직은 전면광고 (1~7초) 를 띄우게 됩니다. (광고 시청중에도 백그라운드에서 로직이 처리 됩니다.)
  - ocr 의 경우 대략 1초당 6개 이미지를 처리 하기 때문에. 60 장이내는 전면광고. 60 장 이상은 30 초 리워드 광고를 띄우게 됩니다. 
  - 광고가 뜨는 중에도 백그라운드에서 로직을 처리 합니다. 
  - 광고는 맞지만 로딩화면 으로 사용하고 있다고 생각 해주시면 좋을꺼 같습니다.
  - 광고를 로딩 화면으로 사용하는건 제가 생각 하는 합리적인 광고 표현 방식이라 생각합니다. 

8. 인식률은 이미지 퀄리티에 따라 달라 지기 때문에 리사이즈 된 이미지 보다는 원본 이미지 를 사용 하시기 바랍니다. 
  - 리사이즈된 이미지도 어느정도 잘 나오더라고요. 저도 적용해 보고 좀 놀랐습니다. 


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
