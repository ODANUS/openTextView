import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_textview/isar_ctl.dart';
import 'package:package_info/package_info.dart';

// 9223372036854775807/160000
// 57646075230342.35
class DeveloperNotes extends GetView {
  final String content = """
---
1.6.9 (2022 03 32) 패치내역 :
1. DB 를 변경 하였습니다. 
  - 영향도가 상당히 클꺼라 예상됩니다. 만약 패치 이후 히스토리복구가 안될경우 리뷰나 메일로 알려 주시기 바랍니다. 

2. 뷰어 쪽을 기존에 제공되는 리스트 형태가 아닌 직접 그래픽 라이브러리를 사용하여 그렸습니다. 
  - 안정성이 향상 되지 않았을까 기대해 봅니다. 스크롤시 부드럽지 않습니다...ㅜㅜ 

3. 기존에 라인단위로 잘라서 스크롤 계산을 했지만. 글자단위로 잘라서 계산 하도록 수정 하였습니다. 
  - 이부분의 영향도가 상당히 크다보니 대부분 로직을 새로 작성 하였습니다. 

4. 설정 페이지에 UI 설정 하는 부분을 제거 하였습니다. 

5. Ui 설정은 뷰어 페이지 상단 톱니 바퀴 모양을 터치하여 수정 할 수 있습니다. 

6. 0~10 초 광고 추가. [내서재], [설정], [히스토리] 페이지 우측상단에 전면광고를 추가 하였습니다. 
  - 보통 5초짜리 광고가 뜨는거 같습니다. 가끔 5초 넘는광고도 나오는거 같습니다. 

7. 이미지 기능을 제거 했습니다. 이미지 검색이 안되는 경우가 잦고. 검색해서 등록한 이미지도 갑자기 사라지는 경우가 많아서 제거 했습니다.  

8. 그외 많은 부분을 변경하였습니다. 


1.6.8 (2022 03 17) 패치내역 :
1. 한문장이 너무 길어 화면을 넘어 가는 경우. 화면천체가 안보이는 현상수정.
  - 해당현상을 해소 하기 위해 한화면에 한문장만 보일경우 숨김 처리를 하지 않고 임의로 스크롤을 내리도록 수정 하였습니다. 이경우 문장 잘림 현상이 발생하게 됩니다. 
   
1.6.7 (2022 03 16) 패치내역 :
1. 나눔 명조 폰트를 추가 하였습니다. 
2. 서재 부분에 라인수/총라인수 가 아닌 글자 수 기준으로 몇권인지 표기해 보았습니다. 
3. 나눔고딕,나눔 명조 폰트를 ttf 대신 otf 로 추가 하였습니다. 폰트파일 용량이 약 50% 절약 되었습니다. 


1.6.6 (2022 03 15) 패치내역 :
1. 자간 설정 기능 추가 하였습니다. 뷰어 페이지 -> '>' 아이콘 클릭 -> Aa 아이콘 클릭(기존 폰트 설정 화면) 하여 자간 설정 을 할 수 있습니다. 
2. TTS 설정에 '알람 음성 안내 실행시 일시 정지' 기능을 추가 하였습니다. 
  - 기존엔 알람, 음성안내, 통화 구분없이 일괄 정지 했는데. 이번엔 세분화 해보았습니다.
3. 초기화 기능 추가. 
  - 기능이 점점 많아 지면서 설정 페이지 최하단에 초기화 기능을 추가 하였습니다. 
4. 내서재/히스토리 에서 퍼센트 외에 읽은 라인수/총라인수 를 표시 해 보았습니다. 

공지 : 제가 만든 어플이 현재 여러개 있습니다. 
  최근에 [내주식 알리미] 라는 어플에서 데이터베이스 오류가 발생하였습니다. 
  문제는 오픈텍뷰도 같은 데이터베이스 로직을 사용하고 있습니다. 
  오픈텍뷰도 혹시나 오류가 날 수 있으니. 백업을 자주 해주시기바랍니다. 

  최근에 2048(아직 출시는 안했습니다.) 게임을 제작 하였습니다.
  2048 에 새로운 데이터베이스를 도입해보았는데. 실시간 저장도 빠르게 실행되고.
  데이터도 안전하게 들어 가는것까지 확인이 되었습니다. 
  조금더 테스트 해보고 안정성이 검증되면 오픈텍뷰도 데이터베이스를 교체하도록 하겠습니다. 


1.6.5 (2022 03 09) 패치내역 :
1. 텍스트 투명도 제거. 
2. 페이지 이동시 깜박거림 최소화

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
