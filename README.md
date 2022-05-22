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
2.3.9 (2022 05 22)

1. 뷰어 높이 계산 알고리즘 수정. 

---
2.3.8 (2022 05 21)
1. 뷰어 높이 계산 알고리즘 수정.
  - 기존보다 높이 계산 정확도를 높여 보았습니다. 
  - 기존 버전보다 1~2 라인 정도 화면에 더 출력 될수 있습니다.

2. 뷰어 일반 화면에 배너 광고 를 추가 하였습니다. 
  - 전체 화면 으로 전환시 자동으로 광고가 제거 됩니다. 

3. 전체화면 기능을 모르시는 분을 위해 어플 실행시 1초 가량 설정된 단축키 레이아웃을 잠시 보여 주고 사라지게 하였습니다. 




---
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

---
2.3.5 (2022 05 17)
1. 다른이름으로 텍스트 파일 저장시 광고를 명확하게 표기 하였습니다. 


2.3.4 (2022 05 16)
1. txt 파일 내보내기 기능을 추가 하였습니다. 
2. 내보내기 기능 사용시 면책조항에 동의를 하도록 추가 하였습니다. 

---
2.3.2 (2022 05 15)
1. 전체 화면 설정을 추가 했습니다. 

---
2.2.7 (2022 05 14)

1. flutter 3.0 올라가면서 위치이동 슬라이드 컨트롤 하려고 하면 페이지가 전환되는 버그가 생겼습니다. 
  - 드래그 로 페이지 전환 기능을 제거 하였습니다. 
  - 상단 탭 버튼을 이용해 주세요. 

2. 뷰어 를 스크롤 해서 이동 할때 끊기 는 현상을 완화 시켰습니다. 

3. 폰트 사이즈나 높이, 등등 글자 크기에 영향이 있는 옵션 수정시 캐시를 다시 생성 하도록 수정. 
  
---
2.2.5 (2022 05 13)
1. OCR 버튼 (이미지 텍스트변환) 이 ZIP 으로 표기 되던 문제 수정. 
2. 리워드 광고 를 전면 광고로 교체 하였습니다. 
3. 이 어플에 기반이 되는 flutter 가 어제 3.0 을 발표 했습니다. 제 어플 엔진도 3.0 으로 업데이트 하였습니다. 

---
2.2.3 (2022 05 11)
1. 뷰어 페이지 높이값계산식 수정. 
2. 아이폰 tts 재생시 문장을 못읽고 멈추게 되면 5글자씩 건너뛰어 읽도록 기능 추가.

---
2.2.2 (2022 05 10)
1. 내서재 / 이미지 문자인식 페이지 진행 상황 글자를 좀더 크게 수정 하였습니다. 
2. PDF 전환 라이브러리를 최신 버전으로 업데이트 하였습니다. 
  - 일부 pdf 읽을때 에러 나는 현상 을 수정 한거 같습니다. 
3. 개발자 노트 상단에 유튜브 tts 샘플을 올려 드립니다. 
4. 오픈소스 라이선스 항목 수정. 


---
2.2.1 (2022 05 08)

1. 내서재 에서 파일 이나 폴더를 드래그 해서 상하 테두리와 가까워 지면 자동으로 스크롤 되도록 수정. 
2. 뷰어 쪽 스크롤 를 조금더 빠르게 할수 있게. 최대 스크롤 속도를 6 -> 8 로 수정 하였습니다. 
3. epub, zip 파일 변환시 확인 창 제거.
4. epub 텍스트 추출 시, 폰트 사이즈가 15 메가 이상이면 ocr 확인창 버튼 텍스트 수정. 


---

2.2.0 (2022 05 08)

1. 구글 인공지능 이미지 인식 을 beta4 로 변경 


---

2.1.9 (2022 05 08)

1. 압축 파일 안에 압축파일이 있을경우. 라이브러리에 파일명 으로 폴더를 만들어 압축을 해제 하도록 기능 변경. 
2. 뷰어가 캐싱하는 글자의 수를 1200 자 에서 2300 자로 늘렸습니다. 
  - 10인치이상의 태블릿에서 글자가 다 표현 안되는 경우가 있어서 추가 했습니다.
3. 기본 폰트 사이즈를 26 으로 변경하였습니다. 

---

2.1.6 (2022 05 06) 패치내역 :
1. kss 를 이용한 개행정리 기능 추가. 

---

2.1.5 (2022 05 06) 패치내역 :
1. 개행 정리 부분 수정. 

---
2.1.4 (2022 05 06) 패치내역 :

1. 태블릿 같이 화면이 큰 디바이스에서 내서재 디자인이 깨지는 현상 수정. 

2. 아이폰 출시를 위해 안드로이드와 아이폰 tts 작동 로직을 일부 분리 해 놓았습니다. 

---
2.1.3 (2022 05 03) 패치내역 :
1. 화면 방향이 변경 될 경우 전체 페이지를 다시 새로 고침 하도록 수정 하였습니다.
2. 설정에 백그라운드 작업 권한 사용 할 수 있도록 기능 추가.
3. tts 설정에 기본속도를 표시 하도록 하였습니다. 

---
2.1.2 (2022 05 02) 패치내역 :
1. TTS 설정 슬라이드바 이동시 렉걸리는 현상 수정 하였습니다. 
2. 단어 단위 개행으로 변경하면서 tts 리딩시 하이라이트가 몇글자 부족하게 채워지는 현상 수정. 

3. 화면 방향이 변경 될 수 있도록 수정. 

---
2.1.1 (2022 04 30) 패치내역 :

1. 페이지 이동 로직 을 수정 했습니다. 
2. 페이지 검색 로직을 수정 했습니다. 

---
2.0.8 (2022 04 28) 패치내역 :

1. 내서재 에서 파일추가 안해도 로딩 화면이 계속 떠있는 버그 수정. 

2. 파일 용량 표기 하도록 수정

3. 파일명 변경시 읽던 위치가 유지 되지 않던 현상 수정. 

4. 내서재 UI 수정 . 
  - 아이콘 을 수정해 보았습니다. 

5. 특정 PDF 오픈시 비정상 종료 되던 현상 수정. 
---
2.0.6 (2022 04 27) 패치내역 :

1. 내서재 에서 파일 추가시 로딩 화면 표시되도록 수정. 

2. 어플 스크린을 세로 로 고정 하였습니다. 

3. pdf -> text 기능을 추가 했습니다. 

4. 내서재 디자인 수정해 보았습니다.

---
2.0.5 (2022 04 26) 패치내역 :
1. 기본 폰트 사이즈를 20 으로 변경하였습니다. 폰트 최소 크기는 18 로 변경 하였습니다. 

2. 뷰어 페이지 로직을 새로 작성하였습니다. 

3. 2번 로직 으로 인해. 기존 글자 단위로 개행된 부분이 단어 단위로 개행 되도록 수정 하였습니다. 

4. 스크롤시 그나마 조금 더 부드러워 졌습니다. 

5. 내서재 디자인을 수정 하였습니다. 

6. tts 엔진 오류 발생시 읽기 위치가 -0 이 되는 현상을 수정 하였습니다. 

---
2.0.3 (2022 04 19) 패치내역 :
1. 히스토리에 일자 기준으로 검색 할수 있도록 기능을 추가 했습니다. 
2. 내서재 UI 변경 
3. 아이콘 / 인트로 화면 수정. 
4. tts 재생시 알수없는 문제로 인해 현재 읽은 위치를 가져 오지 못한경우 읽은 위치가 0 으로 초기화 되는 현상 수정. 

---
1.9.9 (2022 04 15) 패치내역 :
1. 갤럭시 스토어를 위해 설정에 우측 상단 리뷰 버튼을 설치한 스토어에 따라 다르게 표현 하도록 수정 하였습니다. 

2. epub 내부에 폰트가 내장 되어 있는경우 해당 폰트로 이미지로 만든뒤 ocr 처리를 하도록 수정 하였습니다. 

3. 내서재에 이미지 파일이 감지되면 지우도록 수정 하였습니다. 

4. epub 가 변환 실패한 파일은 경고 문구를 띄우도록 하였습니다.
  
5. epub , zip 파일 변환 시, 파일명에 날자,시간을 제거 하였습니다. 
  
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


---
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
