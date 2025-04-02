<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trip Pocket Intro</title>
<%
    String contextPath = request.getContextPath();
%>
<style>
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        overflow-x: hidden; /* 가로 스크롤을 숨김 */
        font-family: 'Noto Sans', sans-serif;
    }

    header {
        width: 99.2%;
        height: 80px; /* 헤더 높이 조정 */
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 2;
        padding: 0 20px; /* 좌우 패딩 조정 */
        box-sizing: border-box; /* 패딩 포함 박스 사이즈 */
    }

    header .logo {
        font-size: 24px;
        font-weight: bold;
    }

    header .burger {
        display: inline-block;
        cursor: pointer;
    }

    header .burger span {
        display: block;
        width: 25px;
        height: 3px;
        margin: 5px;
        background: white;
        transition: all 0.3s ease;
    }

    body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: url('<%= request.getContextPath() %>/resources/img/back_sky.png');
        background-size: cover; /* 이미지 크기를 화면에 맞춤 */
        background-position: center; /* 이미지 위치를 가운데로 */
        background-repeat: no-repeat; /* 이미지 반복을 안함 */
        background-attachment: fixed; /* 배경 이미지 고정 */
        opacity: 1; /* 불투명도 설정 */
        z-index: -1; /* 배경 이미지를 뒤로 */
    }

    .background-overlay {
        position: relative;
        z-index: 1; /* 섹션을 배경 이미지 위로 */
        background-color: rgba(255, 255, 255, 0.3); /* 반투명 흰색 배경 */
    }

    .content {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh; /* 각 섹션의 최소 높이를 100vh로 설정 */
        text-align: center;
        padding-bottom: 100px; /* 각 섹션의 아래에 패딩을 추가 */
        padding-top: 80px; /* 헤더 아래 공간 확보 */
    }

    .main {
        padding: 20px;
        box-sizing: border-box;
        color: white; /* 텍스트 색상을 흰색으로 변경 */
    }

    .main p {
        font-size: 28px; /* p 태그의 글자 크기를 더 키움 */
    }

    .main h1 {
        font-size: 48px; /* h1 태그의 글자 크기를 더 키움 */
    }

    .section {
        padding: 40px;
        box-sizing: border-box;
        color: white; /* 텍스트 색상을 흰색으로 변경 */
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh; /* 각 섹션의 최소 높이를 100vh로 설정 */
    }

    .section h1 {
        font-size: 28px; /* h1 태그의 글자 크기를 키움 */
    }

    .section img {
        max-width: 100%;
        height: auto;
        border-radius: 10px;
    }
    
    .section p {
       font-size: 18px;
    }

    .section a {
        color: white;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 5px;
        transition: transform 0.3s ease, font-size 0.3s ease; /* 애니메이션 효과 */
        font-size: 28px; /* 기본 글자 크기 */
    }

    .section a:hover {
        transform: scale(1.1); /* 마우스 오버 시 크기 확대 */
        font-size: 48px; /* 마우스 오버 시 글자 크기 확대 */
    }

    footer {
        width: 100%;
        background-color: rgba(255, 255, 255, 0.3); /* 반투명 흰색 배경 */
        color: black;
        text-align: center;
        padding: 20px;
        position: relative;
        bottom: 0;
        left: 0;
    }

    /* 사이드 메뉴 스타일 */
    .side-menu {
        width: 300px;
        height: 100%;
        background-color: white; /* 사이드 메뉴 배경 색상 */
        color: black;
        position: fixed;
        top: 0;
        right: -300px; /* 초기 위치를 화면 밖으로 설정 */
        z-index: 3;
        transition: right 0.3s ease;
        display: flex;
        flex-direction: column;
        padding: 20px;
        box-sizing: border-box;
    }

    .side-menu.show {
        right: 0; /* 사이드 메뉴를 화면 안으로 이동 */
    }

    .side-menu a {
        color: black;
        text-decoration: none;
        margin: 15px 0; /* a 태그들 간의 간격 설정 */
        font-size: 18px;
    }

    .side-menu .close-btn {
        align-self: flex-start;
        cursor: pointer;
        font-size: 24px;
        margin: 10px 0 20px 0; /* X 버튼과 아래 a 태그와의 간격 설정 */
    }

    /* 어두운 배경 스타일 */
    .dark-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* 어두운 배경 색상 */
        z-index: 2;
        display: none; /* 초기에는 보이지 않음 */
    }

    .dark-overlay.show {
        display: block; /* 사이드 메뉴가 열릴 때 보이도록 설정 */
    }

</style>

</head>
<body onclick="closeMenu(event)">
    <header>
        <div class="logo">Trip Pocket</div>
        <div class="burger" onclick="toggleMenu(event)">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </header>
    <div class="dark-overlay" id="darkOverlay" onclick="closeMenu(event)"></div>
    <div class="side-menu" id="sideMenu" onclick="stopPropagation(event)">
        <div class="close-btn" onclick="toggleMenu(event)">X</div>
        <a href="#">로그인/회원가입</a>
        <a href="#">마이페이지</a>
        <a href="#">여행 계획 세우기</a>
        <a href="#">여행 공유하기</a>
        <a href="#">숙소</a>
    </div>
    <div class="background-overlay">
        <div class="main content">
            <p>계획부터 예약까지, 여행이 쉬워지는</p>
            <h1>나를 아는 여행, Trip Pocket</h1>
        </div>
        <div class="section content">
            <h1>원하는 것만 하는 나만의 특별한 여행, 가능할까요?</h1>
            <h2><img src="<%= contextPath %>/resources/img/cherryflower.png" alt="계획세우는 이미지"></h2>
            <h1>나만을 위한 맞춤형 여행</h1>
            <p>
                여행 준비가 번거로우신가요?<br>
                Trip Pocket과 함께라면 쉽고 간편하게 일정을 계획하고 수정할 수 있습니다.<br>
                이제는 스트레스 없이 완벽한 여행을 즐겨보세요.
            </p>
        </div>
        <div class="section content">
            <h1>내가 가려는 그곳, 여행지로서 매력이 있나요?</h1>
            <h2><img src="<%= contextPath %>/resources/img/cherryflower.png" alt="여행지 보드 이미지"></h2>
            <h1>궁금한 정보를 한눈에</h1>
            <p>
                다른 사람과 쉽게 공유해 보세요.<br>
                Trip Pocket과 함께라면 여행 준비가 더 즐거워집니다!
            </p>
        </div>
        <div class="section content">
            <h1>나의 숙소 결제, 지금 괜찮을까요?</h1>
            <h2><img src="<%= contextPath %>/resources/img/cherryflower.png" alt="숙소이미지"></h2>
            <h1>일정에 맞는 숙소 금액을 한눈에 확인하세요</h1>
            <p>
                여행 중 가장 중요한 숙소!<br>
                Trip Pocket으로 한눈에 숙소 금액을 비교하고, 최적의 결정을 내리세요.<br>
                합리적인 가격으로 편안한 숙소를 예약해 보세요.
            </p>
        </div>
        <div class="section content">
            <h1><a href="#">Trip Pocket 시작하기</a></h1>
        </div>
    </div>
    <footer>
        <p>&copy; 2025 Trip Pocket. All rights reserved.</p>
    </footer>
    <script>
        function toggleMenu(event) {
            event.stopPropagation();
            var sideMenu = document.getElementById("sideMenu");
            var darkOverlay = document.getElementById("darkOverlay");
            sideMenu.classList.toggle("show");
            darkOverlay.classList.toggle("show");
        }

        function closeMenu(event) {
            var sideMenu = document.getElementById("sideMenu");
            var darkOverlay = document.getElementById("darkOverlay");
            if (sideMenu.classList.contains("show")) {
                sideMenu.classList.remove("show");
                darkOverlay.classList.remove("show");
            }
        }

        function stopPropagation(event) {
            event.stopPropagation();
        }
    </script>
</body>
</html>
