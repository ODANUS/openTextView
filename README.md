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
