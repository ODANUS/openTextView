# opentextview 오픈텍뷰 

## 설명 

openTextView 오픈텍스트뷰어 는 텍스트를 음성으로 변경 하여 들려주는 어플입니다. 

어플이 종료되어도 음성은 끊기지 않고 계속 실행 되는 것을 목표로 개발 하였습니다. 

한자, 일어 , 특수 문자 등을 무시하도록 필터 기능을 사용 할 수 있습니다. 

tts 설정 에서 여러줄 을 읽도록 설정할 수 있습니다.

[구글 플레이 링크](https://play.google.com/store/apps/details?id=com.khjde.opentextview)

---
## 기본 기능

| 작업 내역                                              | 완료 여부     
| -------                                               | :-------:  
| 필터                                                   | ✅         
| tts 옵션                                               | ✅       
| 검색                                                   | ✅        
| 파일 열기                                              | ✅        
| 파일 인코딩 자동 판단 기능                                | ✅        
| 백업/복구 기능                                           | ✅        
| 히스토리                                                 | ✅        
| 읽은 위치 저장 기능                                       | ✅        
| 위치 건너 뛰기 기능                                       | ✅        
| 어플이 종료 되어도 tts가 유지되게 하는 기능.                 | ✅        
| 오픈소스 라이선스 화면 구현                                | ✅
| 헤드셋 버튼 연동 기능                                     | ✅
| 다른 프로그램에서 음악/ 영상 플레이시 tts 정지 기능.          | ✅
| 백업시 파일로 저장하는 기능                               | ✅
| 구글 클라우드를 이용하여 설정 백업/ 복구 기능            | ✅
| epub 파일 지원                                                | ✅
| 독서 인증용으로 캡쳐 할 수 있도록 이미지, 책 제목 편집하여 팝업으로 띄우기 |  ✅
| 공지사항 버튼 추가                                                | ✅



---
## 요구사항 / 버그 제보 
아래 링크에서 접수 해주시기 바랍니다. 

[요구 / 버그 제보 링크](https://github.com/khjde1207/openTextView/issues)
| 버그 내역                                              | 완료 여부     
| -------                                               | :-------:  
| 파일을 열지 않은 상태에서 라인이동 하려고 할경우 화면이 회색으로 변경되는 현상. | ✅
| 파일 안열리는 현상.(특정 euc-kr 포멧. 자동 디코딩 실패시 euc kr 로 강제 디코딩. ) |  ✅


## 패치내역

---
1.9.6 (2022 04 13) 패치내역 :
1. 특정 epub -> txt 변환 알고리즘을 추가 했습니다. 
---
1.9.4 (2022 04 12) 패치내역 :
1. 어플 아이콘을 수정하였습니다. 
2. 어플 실행할때 하얀색 화면이 뜨는것 때문에 인트로 이미지 추가 하였습니다.

---
1.9.2 (2022 04 11) 패치내역 :
1. OCR 페이지 우측 상단에 가위버튼을 추가 하였습니다. (이미지 자르기)
  - 두페이지 로 나뉘어진 파일의 경우 우선 페이지를 좌우로 잘라 주시고 인식 해주시기 바랍니다. 
  - 그렇지 않을경우 두페이지의 단어가 중간중간 섞여 나오는걸 확인 하였습니다. 
  
---
1.9.1 (2022 04 10) 패치내역 :
1. 내서재 에서 확장자 기준으로 필터 할수 있게 기능을 추가 하였습니다. 

---
1.9.0 (2022 04 10) 패치내역 :
1. 뷰어 맨하단 글자가 가끔 깜빡이는 현상 완화. 

2. 뷰어,서재,설정, 히스토리 에 배경 이미지를 설정 할 수 있습니다.  
  - 뷰어 -> 톱니바퀴 -> UI 설정 에서 설정 가능합니다. 
  - 인터넷 에서 찾은 무료이미지 9 개를 추가 하였고. 투명도를 적절히 줘서 은은하게 표현 되도록 하였습니다. 
  - 투명도는 임의로 설정 이 가능합니다. 
  https://pixabay.com/ko/illustrations/search/%EC%A2%85%EC%9D%B4/

3. 과거 데이터 베이스를 연동 로직을 제거 하였습니다. 며칠 상황봐서 해당 라이브러리를 제거 하겠습니다. 

---
1.8.7 (2022 04 09) 패치내역 :
1. 분할 압축 단위를 500 -> 1000 으로 변경 하였습니다.  

---
1.8.6 (2022 04 09) 패치내역 :
1. 압축 해제시 자연정렬 알고리즘을 통해 파일 을 정렬한후 압축 해제를 하였습니다. 
2. ocr 페이지 또한 자연정렬 알고리즘을 통해 정렬 한뒤 이미지 인식을 하게 됩니다. 
---
1.8.1 (2022 04 09) 패치내역 :
1. 이미지가 500 장이 넘는 압축파일의 경우 분할 압축을 실행하여 500 장씩 나눠서 따로 저장하게 됩니다.
---
1.8.0 (2022 04 08) 패치내역 :

1. 개행 정리 로직추가 개선, 

2. 광고 흑화현상 개선. 

3. 내서재에 이미지 변환 , epub 변환 지원 한다고 써놓았습니다! 

---
1.7.9 (2022 04 08) 패치내역 :

1. 개행 정리 로직을 한줄 개행에서 두줄 개행으로 변경 하였습니다. 
  - 내서재 ui 가 보기 불편하여 버튼을 4개로 배치하고 다른이름으로 저장은 우선 제거 하였습니다. 
2. 30 초 광고 를 전면 보상형 광고(베타) -> 리워드 광고로 수정 했습니다. 

---
1.7.8 (2022 04 07) 패치내역 :
1. 첫번째 라인 으로 안가던 버그 수정. 
2. (베타) 개행 정리 기능을 추가 했습니다. 
3. (베타) epub 를 텍스트로 변경 하면서 2번 개행처리도 같이 진행 하도록 수정 해 보았습니다.
4. (베타) 인공지능 이미지 텍스트 인식 기능을 추가 하였습니다. 
5. 압축 파일 선택시 OCR 버튼이, epub 는 텍스트 변환 버튼이 나오도록 ui 를 수정 하였습니다. 
6. 변환 된 파일은 내보내기 기능으로 저장 할 수 있습니다. (5초 광고 추가 하였습니다.)

7. 몇몇 광고를 추가 하였습니다. 

---
1.7.7 (2022 04 04) 패치내역 :
1. 폰트 사이즈를 최대 40 까지 키울 수 있게 수정 하였습니다. 

---
1.6.12 (2022 04 02) 패치내역 :
1. 한번에 읽을 라인수 가 1 일경우 무한 루프 가 발생하는 현상 수정. 
2. 페이지 스크롤 시 데이터를 바로 저장하지 않고. 스크롤이 멈추고 0.4 초간 변동이 없을때만 데이터를 저장하도록 수정하여 버벅임 현상 완화  
3. tts 배터리 소모량 최적화
4. 스크롤 개선. 
   
---
1.6.12 (2022 04 02) 패치내역 :
1. epub 파일 텍스트로 추출 하는 로직 수정. 
  - 기존엔 제공되는 라이브 러리를 사용했지만. 자꾸 에러나서 압축 해제후 직접 처리 하였습니다. [다. ], [" ]쌍따옴표 스페이스바, [”]한글식 닫는 쌍따옴표 기준으로 개행 처리를 합니다. 이는 핸드폰 언어설정이 한글 일 경우에만 작동 합니다.
   

---
1.6.11 (2022 04 01) 패치내역 :
1. tts 재생시 하이라이트 위치값이 실제 음성과 상이 했던 문제 수정. 
2. ui 설정 하단에 닫기 버튼 추가. 
3. 스크롤 버벅임 현상 조금더 완화 했습니다. 

1.6.9 (2022 04 01) 패치내역 :

1. DB 를 변경 하였습니다. 

2. 뷰어 쪽을 기존에 제공되는 리스트 형태가 아닌 직접 그래픽 라이브러리를 사용하여 그렸습니다. 

3. 기존에 라인단위로 잘라서 스크롤 계산을 했지만. 글자단위로 잘라서 계산 하도록 수정 하였습니다. 
  - 이부분의 영향도가 상당히 크다보니 대부분 로직을 새로 작성 하였습니다. 
4. 설정 페이지에 UI 설정 하는 부분을 제거 하였습니다. 
5. Ui 설정은 뷰어 페이지 상단 톱니 바퀴 모양을 터치하여 수정 할 수 있습니다. 

6. 0~10 초 광고 추가. [내서재], [설정], [히스토리] 페이지 우측상단에 전면광고를 추가 하였습니다. 

7. 이미지 기능을 제거 했습니다. 이미지 검색이 안되는 경우가 잦고. 검색해서 등록한 이미지도 갑자기 사라지는 경우가 많아서 제거 했습니다.  

8. 그외 많은 부분을 변경하였습니다. 

---

1.6.8 (2022 03 17) 패치내역 :
1. 한문장이 너무 길어 화면을 넘어 가는 경우. 화면천체가 안보이는 현상수정.
  - 해당현상을 해소 하기 위해 한화면에 한문장만 보일경우 숨김 처리를 하지 않고 임의로 스크롤을 내리도록 수정 하였습니다. 이경우 문장 잘림 현상이 발생하게 됩니다. 
   
---
1.6.7 (2022 03 16) 패치내역 :
1. 나눔 명조 폰트를 추가 하였습니다. 
2. 서재 부분에 라인수/총라인수 가 아닌 글자 수 기준으로 몇권인지 표기해 보았습니다. 
3. 나눔고딕,나눔 명조 폰트를 ttf 대신 otf 로 추가 하였습니다. 폰트파일 용량이 약 50% 절약 되었습니다. 

---

1.6.6 (2022 03 15) 패치내역 :
1. 자간 설정 기능 추가 하였습니다. 뷰어 페이지 -> '>' 아이콘 클릭 -> Aa 아이콘 클릭(기존 폰트 설정 화면) 하여 자간 설정 을 할 수 있습니다. 
2. TTS 설정에 '알람 음성 안내 실행시 일시 정지' 기능을 추가 하였습니다. 
  - 기존엔 알람, 음성안내, 통화 구분없이 일괄 정지 했는데. 이번엔 세분화 해보았습니다.
3. 초기화 기능 추가. 
  - 기능이 점점 많아 지면서 설정 페이지 최하단에 초기화 기능을 추가 하였습니다. 
4. 내서재/히스토리 에서 퍼센트 외에 읽은 라인수/총라인수 를 표시 해 보았습니다. 

---

1.6.5 (2022 03 09) 패치내역 :
1. 텍스트 투명도 제거. 
2. 페이지 이동시 깜박거림 최소화

---
1.6.4 (2022 03 09) 패치내역 :
1. 전체화면 시 스크롤 기능을 제거 하였습니다. 
2. 전체화면 시 마지막 라인을 숨기고. 페이지 넘기면 숨겨진 라인 부터 보이도록 하여 가독성을 향상 시켜 보았습니다.(마지막 라인이 잘리는 현상이 있었습니다.) 

---
1.6.3 (2022 03 08) 패치내역 :
1. 여백 설정 기능 추가 하였습니다. 
 - 뷰어 페이지 우측 상단 화살표 버튼을 눌러 여백을 설정 할 수 있습니다. 
 - 원래 두손가락 제스처로 하려고 했지만. 제스처 기능을 넣으면 화면 스크롤 기능이 작동하지 않아. 버튼 형태로 변경 하였습니다. 
 
---
1.6.1 (2022 03 07) 패치내역 :
1. 글자색 투명도가 적용되서 업데이트 되는 현상 급히 수정. 
 - 글자색 적용은 다음 버전에서 처리 하겠습니다. 


---
1.6.0 (2022 03 07) 패치내역 :
1. 전체 화면시 최대한 텍스트가 안잘리도록 수정. 
  - 최대한 상하 텍스트가 잘리지 않도록 글꼴 크기 + 글꼴 높이 만큼 상하 여백을 주고. 스크롤 처리 로직도 수정해 보았습니다. 하지만 이렇게 하더라도 잘리는 부분이 생길꺼 같습니다. 해상도 에 따라 다르게 보일 수도 있어요. 리뷰나 메일을 통해 폰 기종을 알려주세요. 

2. 백업/ 복구시 테마 데이터 가 적용 안되는 현상. 
  - 로직 확인해 보니 테마 정보를 구글드라이브에 저장하지 않고 있었습니다. 테마 정보도 구글드라이브에 저장되도록 수정 하였습니다. 

3. 내서재 메모,삭제 기능을 드래그/롱클릭 으로 처리 할 수 있도록 수정 하였습니다. 

4. 배경색, 폰트 색상 변경 기능 추가. 

5. 5.9-1 버그 추가 작업 (tts 재생시 스크롤만 이동 하는 현상.)



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


---
1.5.6 (2022 03 04) 패치내역 :
1. 전체 화면 터치 반전 레이아웃 추가.  
2. x86 장치 에서 실행 되도록 빌드 옵션 추가. 
3. 페이지 이동지 오프셋 없이 한페이지씩 이동하도록 수정. 



---

1.5.5 (2022 03 03) 패치내역 :
1. 다른 플레이어 재생시 일지 정지 체크 해제 해도 일지 정지 되는 현상 수정. 
2. 다른 플레이어 재생시 일지 정지 된 이후. 기존 읽었던 문장 위치 가 아닌 그 전 에 읽었던 문장 위치 에서 시작하던 버그 수정. 



---
1.5.4 (2022 03 01) 패치내역 :
1. 파일 열때 비정상 종료 현상 패치 
 - flutter 버전을 최신 버전으로 올렸더니 해결 되었습니다. 이걸로 해결 안됐으면 멘붕 왔을꺼에요.

1.5.2 (2022 02 28) 패치내역 :
1. tts 재생시 가끔 비정상 적으로 종료 되는 현상 수정 
2. tts 엔진 초기화 이후 바로 재생시 중얼 거리는 목소리로 출력 되는 현상 수정. 
  - 이 현상은 tts 엔진 문제로 판단 됩니다. 엔진 초기화 이후 0.9 초 딜레이 를 주었습니다 .
  - 재생시 중얼거리는 목소리 현상이 완화 된걸 확인 했지만. 다른폰은 어떤지 확인 이 안되다 보니. 여전히 중얼 거리는 목소리가 나오는경우 리뷰로 알려 주시기 바랍니다. 

1.5.1 (2022 02 28) 패치내역 :
1. 30 초 광고 제거 

1.4.7 (2022 02 06) 패치내역 : 
1. tts 재생중 다른 파일을 열경우 tts 가 중지 되도록 수정 . 

2. 라이브러리 페이지에 이미지 주소를 추가 했지만. 어떤 이유로 해당 이미지 주소가 사라진 경우 새로 이미지를 추가 할수 없던 버그 수정. 

3. 뷰어 페이지 에서 제목을 누를경우 해당 파일의 이미지가 앞으로 뜨게 됩니다. 빈공간을 누르면 사라지고. 이미지를 누르면 이미지를 변경 할 수 있습니다.
  
4. 백업 / 복구시 제대로 복구 안되는 현상을 발견하여 수정 하였습니다. 

5. 히스토리 페이지도 이미지가 나오도록 수정 했습니다. 

6. 서재 / 히스토리 에서 리스트를 길게 누르시면 메모를 추가 할 수 있습니다. 

* 저번달에 추가한 기능이지만 모르시는 분이 계실꺼 같아서 언급 하고자 합니다. 
  epub 파일을 지원할수 있도록 기능을 추가 하였습니다. 
  epub 파일 을 선택하시면 epub 파일 을 텍스트로 변환해서 들을 수 있습니다. 

* 북마크 기능을 넣으려고 보니 손이 상당히 많이 가더라고요. 북마크 기능 필요 하신가요? 리뷰로 알려 주세요. 

---
1.4.5 (2022 02 04) 패치내역 : 
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
---
1.4.2 (2022 01 18) 패치내역 : 
1. 히스토리 를 csv 로 내보내는 기능을 추가 했습니다. 

---
1.4.1 (2022 01 15) 패치내역 : 
1. 내서재 에서 검색 기능을 추가 하였습니다. 
2. 필터에서 특수문자를 못넣는 경우가 발생하여. 붙여넣기 버튼을 추가 하였습니다. 
---
1.4.0 (2022 01 07) 패치내역 : 

1. 풀 스크린 일경우에만 터치/볼륨키로 페이지 이동이 가능하도록 수정. 
  - 사용하다 보니 재생버튼누르다가 스크롤 이동되는 경우가 잦아서 수정 하였습니다. 

2. 앱 아이콘을 변경하였습니다. 기존건 뭔가 너무 딱딱한 느낌이 들어서 좀 부드러운 느낌을 주도록 수정해 보았습니다. 

3. 설정 페이지 상단바 우측에 팝업 형태 의 광고 버튼 추가. 무음 광고 입니다. 가끔씩 봐주시면 개발자에게 아마 큰 도움이 될듯합니다.

4. 어플 공유 / 리뷰 달기 를 설정 페이지 상단바로 위치를 이동 하였습니다. 

5. 테마 버튼을 라디오 버튼으로 변경 하였습니다. 

6. 글꼴 높이를 설정 할 수 있도록 수정 하였습니다. 

7. 히스토리 를 페이지로 형태로 변경 하였습니다. 
  - 엑셀로 히스토리 를 다운받아 읽은책 관리하려고 만들었지만 download 폴더 파일 만들기가 아직 잘 안되고 있습니다. 조만간 해당 부분이 해결되면 csv 로 내보내기 기능을 추가 하도록 하겠습니다. 

8. tts 기능 수정. 
  - 가끔 tts 가 렉걸리는 현상이 발생되어 구조를 수정 해 보았습니다. 





---
1.3.9 (2021 12 13) 패치내역 : 
1. tts 재생시 가끔 비정상 종료 되는 오류 개선 (완벽하게 고쳐진건지 모르겠습니다.)
2. flutter 에서 키패드가 한번이라도 떠야지 볼륨키 입력받을수 있습니다. 전체 화면 진입 할때 키패드를 0.2초정도 잠깐 띄워서 볼륨키 입력을 받도록 처리 하였습니다.

---

---
1.3.8 (2021 12 10) 패치내역 : 
1. flutter 3.8 버전이 새로 배포 되었습니다. 
 - flutter 3.8 로 새로 빌드하면  실행 속도 가 빨라 졌다고 해서 추가 수정 없이 빌드만 다시 했습니다. 

2. 서재 부분은 폴더 를 추가 하도록 하고 싶은데. flutter file_picker getDirectoryPath() 를 써서 권한 을 받아도 읽기 권한 이 적용이 안됩니다. 
사용자 분들중 개발자가 계시면 조언좀 부탁 드립니다. 
---
---
1.3.7 (2021 12 10) 패치내역 : 
1. 설정 복구시 해당 파일이 내서재에 없을경우 에러나는 현상 해결 
---

---
1.3.6 (2021 12 09) 패치내역 : 

1. 폰트 설정 기능 추가.

2. 상하좌우 영역을 터치하여 이전 / 다음 페이지로 이동 하는 기능 추가. 

3. 중앙 부분 더블 클릭 하여 전체 화면으로 변경하는 기능 추가. 

구현 가능 여부 확인 해야 하는 부분 : 
1. 볼륨키로 페이지 이동 ( 하는 법을 몰라서 찾아봐야함.)
2. 서재 기능 개선 (SDK30 부터는 폴더 읽기 기능이 작동하지 않아. 방법을 찾아봐야함)

---
---
1.3.5 (2021 11 29) 패치내역 : 

1. 스크롤 중에 새 파일을 열 경우 스크롤 오류가 발생했던 버그 수정. 

2. 서재 정렬 기능에 파일을 열었던 순으로 정렬 하는 기능 추가. 

추가 : 가끔 재생 버튼 누르면 어플이 종료되는 현상이 있습니다. 막상 수정하려고 보면 현상 재현이 안되고 있습니다. 혹시 사용자 분들중에 재현방법을 아시면 리뷰 나 메일로 제보 부탁드립니다. 

---
---
1.3.4 (2021 11 26) 패치내역 : 

1. 서재 정렬 기능 추가. 

2. 설정에 어플 공유 / 리뷰 쓰기 버튼 추가.

---
---
1.3.2 (2021 11 07) 패치내역 : 

1. 서재와 설정에 배너광고를 하나씩 추가 하였습니다. 
    - 뷰어 쪽에는 광고가 추가 되지 않습니다. 제가 제일 많이 사용하는 어플 인 만큼. 사용하기 불편한 수준의 광고는 넣지 않을 예정입니다. 

2. 처음 설치후 파일 열고 어플을 껏다 켜야 내서재가 나오는 버그를 수정 하였습니다. 
    - 어제 핸드폰 포멧 하고 발견 하였습니다.

---
1.2.7 (2021 10 22) 패치내역 : 

1. 재생중 한번에 읽을 줄단위 설정시 중복해서 읽게 되는 현상 수정. 


---
1.2.6 (2021 10 14) 패치내역 : 

1. 화면이 꺼지지 않도록 수정 하였습니다. 

---
1.2.5 (2021 10 13) 패치내역 : 

1. 헤드셋 버튼 지원 
2. 자동 종료 기능 추가 하였습니다. 

---
1.2.4 (2021 10 11) 패치내역 : 

1.인덱스 계산 오류로 마지막줄 안읽는 버그 수정


3. 히스토리 삭제를 편하게 할수 있도록 수정. 

4. 스크롤 시 퍼센트 고정 현상 개선. 


---
1.1.9 (2021 10 09) 패치내역 : 

1. 서재에 진행 상황을 % 로 표기 하도록 수정 하였습니다. 
2. 파일 오픈할때 tts 정지 시키도록 수정. 

---
1.1.8 (2021 10 09) 패치내역 : 

1. UI 를 변경하였습니다. . 
2. 서재 기능을 추가 하고. 기존 파일 여는 시스템을 제거 하였습니다.
3. OCR 기능 을 제거 하였습니다. 
4. 데이터 구조 를 변경 하였습니다. 
5. 백업 / 복구를 구글 드라이브로 할 수 있게 수정 하였습니다. 
6. 전체 로직을 새로 작성 하였습니다. 

- 지원 예정 : 
1. 이미지 뷰어 기능을 추가 할 예정 입니다. 
2. 이미지 뷰어에서 ocr 을 사용할 수 있도록 기능을 제작할 예정입니다. 

이미지를 원활 히 볼 수 있도록 관련 기능을 정리 중에 있습니다. 

---
1.1.7 (2021 09 25) 패치내역 : 

1. 시스템 기본 tts 엔진설정을 사용하도록 수정 하였습니다. 
2. 파일 여는 설명을 추가하였습니다. 

---
1.1.6 (2021 08 27) 패치내역 : 

1. 일시 정지 상태에서 다른 텔레그램 등의 사운드 점유가 일어난뒤 풀리면 tts 가 재생되는 현상 수정. 
2. 가끔 스크롤 먹통 현상을 해결하기위해 사용자가 스크롤하는 시점에는 읽기 위치 동기화 되지 않도록 수정. 

---
1.1.5 (2021 07 28) 패치 내역 : 

1. 모든 팝업에 애니매이션 적용. 
2. 필터 사용 시 좀더 편하게 사용할수 있도록 ui 수정. 
3. 히스토리 검색 기능 추가. 
4. 캐시 삭제시 좌우로 드래그 하여 삭제 할수 있도록 수정. 
5. 길게 눌러 문장 복사 기능 추가 
6. ocr 속도 개선 (페이지당 0.2 초 정도 개선됨.)
7. 상단에 헤더 추가. 기존 좌측 하단에 있는 + 버튼 대신 헤더에 해당 기능을 넣음. 
