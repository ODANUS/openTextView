# opentextview 오픈텍뷰 

## 설명 

openTextView 오픈텍스트뷰어 는 텍스트를 음성으로 변경 하여 들려주는 어플입니다. 

어플이 종료되어도 음성은 끊기지 않고 계속 실행 되는 것을 목표로 개발 하였습니다. 

한자, 일어 , 특수 문자 등을 무시하도록 필터 기능을 사용 할 수 있습니다. 

tts 설정 에서 여러줄 을 읽도록 설정할 수 있습니다.

[구글 플레이 링크](https://play.google.com/store/apps/details?id=com.khjde.opentextview)

---
1.1.6 (2021 08 27) 패치내역 : 

1. 일시 정지 상태에서 다른 텔레그램 등의 사운드 점유가 일어난뒤 풀리면 tts 가 재생되는 현상 수정. 
2. 가끔 스크롤 먹통 현상을 해결하기위해 사용자가 스크롤하는시전에는 읽기 위치 동기화 되지 않도록 수정. 

---
1.1.5 (2021 07 28) 패치 내역 : 

1. 모든 팝업에 애니매이션 적용. 
2. 필터 사용 시 좀더 편하게 사용할수 있도록 ui 수정. 
3. 히스토리 검색 기능 추가. 
4. 캐시 삭제시 좌우로 드래그 하여 삭제 할수 있도록 수정. 
5. 길게 눌러 문장 복사 기능 추가 
6. ocr 속도 개선 (페이지당 0.2 초 정도 개선됨.)
7. 상단에 헤더 추가. 기존 좌측 하단에 있는 + 버튼 대신 헤더에 해당 기능을 넣음. 

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
| OCR 기능 추가.                                           | ✅
| 백업시 파일로 저장하는 기능                               | ✅
| 구글 클라우드를 이용하여 설정 백업/ 복구 기능            | 진행중


---
## 요구사항 / 버그 제보 
아래 링크에서 접수 해주시기 바랍니다. 

[요구 / 버그 제보 링크](https://github.com/khjde1207/openTextView/issues)
| 버그 내역                                              | 완료 여부     
| -------                                               | :-------:  
| 파일을 열지 않은 상태에서 라인이동 하려고 할경우 화면이 회색으로 변경되는 현상. | ✅
| 파일 안열리는 현상.(특정 euc-kr 포멧. 자동 디코딩 실패시 euc kr 로 강제 디코딩. ) |  ✅


---
## 기부 
이미지 / 아이콘 / 필터 옵션 / 아이디어 를 올려주시면 검토후 추가 해 보겠습니다. 

[링크](https://github.com/khjde1207/openTextView/issues)

---
## 추가
아직 초기 단계라 버그도 많고 기능도 많이 부족합니다. 많은 제보 바랍니다. 
