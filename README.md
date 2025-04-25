<h1 align="center">Trip Pocket</h1>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ea5685c9-3eee-4f53-8e66-effb38b4fa0b" width="300"/>
</p>

<p align="center">여행의 모든 순간을 간편하게</p>
<p align="center"><strong>나를 아는 여행, Trip Pocket</strong></p>
<p align="center">내 마음대로, 나만의 특별한 여행</p>

---

### 🔗 도메인 주소
- [trippocket.duckdns.org](http://trippocket.duckdns.org)

---

### 👨‍💻 프로젝트 팀원
- 유태종
- 김범룡
- 최건
- 이지현

---

### 🎯 주제 선정
**프로젝트명: Trip Pocket**

국민여행 조사에 따르면, 
2024년에는 국내 여행 기준
국내 휴가여행 계획자 비율: 82%
국내 여행 시장 규모 -> 약 29조 8,600억 원
여행 경험률 94.8% -> 약 4,900만명
여행 횟수 290,500,000회 -> 1인당 평균 여행 횟수 약 5.93회
여행 일수 460,200,000일 -> 1인당 평균 여행 일수 약 9.4일
여행 지출액 385,000,000,000원 -> 1인당 평균 여행 지출액 약 78만 6천원

2024 국내 여행 트렌드: R.O.U.T.E.
 
문화체육관광부와 한국관광공사는 2024년 국내 여행 트렌드를 'R.O.U.T.E.'로 제시했습니다. 
이는 개인화된 여행 경험을 중시하는 방향으로, 다음과 같은 테마로 구성되어 있습니다.​

Relax: 쉼이 있는 여행

One-point: 원포인트 여행

Unique: 나만의 명소 여행

Technology: 스마트 기술 기반 여행

Everyone: 모두에게 열린 여행

사용자가 **나만의 여행 일정**을 쉽게 작성할 수 있도록 하고,  
관광지 정보를 **공공데이터(TourAPI)** 와 연계하여 제공하며,  
다른 사용자와 계획을 **공유**할 수 있는 기능을 구현합니다.

👉 개인 맞춤형 여행 계획을 쉽게 **작성**, **저장**, **공유**할 수 있는 웹사이트 개발이 목표입니다.

---

### 🔍 참고 사이트  
- 트리플: [https://triple.guide/intro](https://triple.guide/intro)  
- TourAPI 4.0: [https://api.visitkorea.or.kr/](https://api.visitkorea.or.kr/)  
- 공공데이터 활용 예시:  
  - [YouTube 예시 1](https://www.youtube.com/watch?v=KnDQ4ysqyMI&t=67s)  
  - [YouTube 예시 2](https://www.youtube.com/watch?v=FJo4iXZ4bt4)  
  - [YouTube 예시 3](https://www.youtube.com/watch?v=yHWLyOShRCM&t=136s)

---

### 🛠 사용 기술
- Java 11
- Spring Framework 4.1.1
- JSP
- Oracle (ojdbc8)
- MyBatis

---

### ⚙ 개발 도구
- STS3 (Spring Tool Suite 3)
- SQL Developer
- Tomcat 9
- Maven

---

### 📅 프로젝트 기간
- 2025.03.31 ~ 2025.04.25

---

### 🧭 스토리보드
<img src="https://github.com/user-attachments/assets/a1fe81a2-e786-4a37-8ff2-c8d71cbfd61c" width="600" alt="Trip Pocket 스토리보드"/>

---

### 🗂 WBS (Work Breakdown Structure)
[🔗 WBS 스프레드시트 보기](https://docs.google.com/spreadsheets/d/e/2PACX-1vSGk6rWZbM7f4B8FllXBJr7r3vIunj4LSrDQ8NfP6oxkaVTLaUT_jiq3yyinkiYvw55qejFqRs8-3En/pubhtml?gid=1115838130&single=true)

---

### 🗃 DB 설계
[🔗 DB 스프레드시트 보기](https://docs.google.com/spreadsheets/d/e/2PACX-1vSGk6rWZbM7f4B8FllXBJr7r3vIunj4LSrDQ8NfP6oxkaVTLaUT_jiq3yyinkiYvw55qejFqRs8-3En/pubhtml?gid=1763198525&single=true)

---

### <img src="https://github.com/user-attachments/assets/d6f45ab4-5cd7-44f8-a2e8-5e4628672acb" width="28" alt="Trip Pocket 스토리보드"/> PRESENTATION
[🔗 나를 아는 여행, Trip Pocket](https://docs.google.com/presentation/d/1uCutOPhXCcy04D7ggRay7AeAQddHk7tDvJ9lEynVMes/edit#slide=id.p6)

---

### ✨ 주요 기능
🧑‍💼 회원 관리
- 로그인
- 회원가입
- 회원가입 이메일 인증
- 아이디 / 비밀번호 찾기
- 로그인 유지 / 인터셉터 (쿠키, 세션)
- 회원 정보 수정 및 탈퇴
- 회원 프로필 사진 변경

  
🧳 여행 계획
- 여행 계획 목록
- 여행 계획 작성
- 여행 날짜별 장소 선택
- 블로그에서 여행 계획 불러오기 / 수정 / 삭제


🔍 관광지 정보 및 검색
- TourAPI 4.0 검색 적용
- 여행 검색 팝업 (TourAPI 연동)
- 관광지 목록 / 검색 / 상세 조회
  

🗺 지도 기능 (Kakao Map API)
- 지도 표시, 마커, 커스텀 오버레이
- LatLngBounds, Polyline 등 활용


🏠 메인 및 이벤트
- 메인 페이지
- 이벤트 페이지 (관광지 페이지 연동)


📝 블로그
- 블로그 목록 / 작성
- 블로그 검색 / 정렬
- 블로그 상세 / 마이 페이지 (조회수, 공유수 포함)


💬 댓글 기능
- 상세 페이지 댓글 작성 / 수정 / 삭제


---

<p align="center"><strong>Thank you for reading 🙏</strong></p>
