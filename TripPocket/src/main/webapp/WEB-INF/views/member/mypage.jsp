<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trip Pocket Intro</title>
<style>
    /* 스타일 시작 */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        overflow-x: hidden;
        font-family: 'Noto Sans', sans-serif;
    }

    header {
        width: 99.2%;
        height: 80px;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 2;
        padding: 0 20px;
        box-sizing: border-box;
        animation: slideDown 2.5s ease-out;
    }

    header .logo {
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        color: white;
        text-decoration: none;
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
        background-image: url('back_sky.png');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        opacity: 1;
        z-index: -1;
    }

    .background-overlay {
        position: relative;
        z-index: 1;
        background-color: rgba(255, 255, 255, 0.3);
    }

    .content {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        text-align: center;
        padding-bottom: 100px;
        padding-top: 80px;
        animation: fadeIn 2s ease-in;
    }

    .main {
        padding: 20px;
        box-sizing: border-box;
        color: white;
    }

    .main p {
        font-size: 28px;
    }

    .main h1 {
        font-size: 48px;
    }

    .section {
        padding: 80px;
        box-sizing: border-box;
        color: white;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        animation: fadeInUp 1s ease-out;
    }

    .section h1 {
        font-size: 28px;
        animation: fadeInUp 1.5s ease-out;
    }

    .section img {
        max-width: 100%;
        height: auto;
        border-radius: 10px;
        animation: zoomIn 1s ease-in;
    }
    
    .section p {
        font-size: 18px;
        animation: fadeInUp 2s ease-out;
    }

    .section a {
        color: white;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 5px;
        transition: transform 0.3s ease, font-size 0.3s ease;
        font-size: 28px;
    }

    .section a:hover {
        transform: scale(1.1);
        font-size: 48px;
    }

    footer {
        width: 100%;
        background-color: rgba(255, 255, 255, 0.3);
        color: black;
        text-align: center;
        padding: 20px;
        position: relative;
        bottom: 0;
        left: 0;
        animation: slideUp 1s ease-out;
    }

    .side-menu {
        width: 300px;
        height: 100%;
        background-color: #f8f9fa;
        color: black;
        position: fixed;
        top: 0;
        right: -300px;
        z-index: 3;
        transition: right 0.3s ease;
        display: flex;
        flex-direction: column;
        padding: 20px;
        box-sizing: border-box;
        box-shadow: -5px 0 5px -5px #333;
    }

    .side-menu.show {
        right: 0;
    }

    .side-menu ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .side-menu li {
        margin: 20px 0;
        position: relative;
    }

    .side-menu a {
        color: #343a40;
        text-decoration: none;
        font-size: 18px;
        padding: 10px 0;
        display: block;
        transition: color 0.3s ease;
    }

    .side-menu a:hover {
        color: #007bff;
    }

    .side-menu .submenu {
        display: none;
        padding-left: 20px;
    }

    .side-menu .submenu li {
        margin: 10px 0;
    }

    .side-menu .submenu a {
        color: #6c757d;
        font-size: 16px;
    }

    .side-menu .submenu a:hover {
        color: #007bff;
    }

    .side-menu .close-btn {
        align-self: flex-start;
        cursor: pointer;
        font-size: 24px;
        margin: 10px 0 20px 0;
        color: #343a40;
    }

    .dark-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 2;
        display: none;
    }

    .dark-overlay.show {
        display: block;
    }

    @keyframes slideDown {
        from { top: -80px; }
        to { top: 0; }
    }

    @keyframes slideUp {
        from { bottom: -80px; }
        to { bottom: 0; }
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes zoomIn {
        from { transform: scale(0.8); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }
    /* 스타일 끝 */
</style>
</head>
<body onclick="closeMenu(event)">
    <header>
        <a href="#" class="logo">Trip Pocket</a> <!-- 메인페이지로 이동 -->
        <div class="burger" onclick="toggleMenu(event)">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </header>
    <div class="dark-overlay" id="darkOverlay" onclick="closeMenu(event)"></div>
    <div class="side-menu" id="sideMenu" onclick="stopPropagation(event)">
        <div class="close-btn" onclick="toggleMenu(event)">X</div>
        <ul>
            <li><a href="#">로그인/회원가입</a></li> <!-- 로그인 페이지로 이동 -->
            <li><a href="#" onclick="toggleSubmenu(event, 'mypage-submenu')">마이페이지</a>
                <ul class="submenu" id="mypage-submenu">
                    <li><a href="#">내 정보</a></li> <!-- 내 정보 페이지로 이동 -->
                    <li><a href="#">나의 여행 계획</a></li> <!-- 나의 여행 계획 페이지로 이동 -->
                    <li><a href="#">이용내역</a></li> <!-- 이용내역 페이지로 이동 --> 
                    <li><a href="#">카드등록</a></li> <!-- 카드등록 페이지로 이동 -->
                </ul>
            </li>
            <li><a href="#">여행 계획 세우기</a></li> <!-- 여행 계획 세우기로 이동 -->
            <li><a href="#" onclick="toggleSubmenu(event, 'share-submenu')">여행 공유하기</a>
                <ul class="submenu" id="share-submenu">
                    <li><a href="#">나의 여행 글 쓰기</a></li> <!-- 나의 여행 글 쓰기 페이지로 이동 -->
                    <li><a href="#">다른 사용자들의 여행 후기</a></li><!-- 다른 사용자들의 여행리스트 페이지로 이동 -->
                </ul>
            </li>
            <li><a href="#" onclick="toggleSubmenu(event, 'product-submenu')">여행상품</a> <!-- 여행상품 추가 -->
                <ul class="submenu" id="product-submenu">
                    <li><a href="#">숙소</a></li> <!-- 숙소 페이지로 이동 -->
                    <li><a href="#">항공권</a></li> <!-- 항공권 페이지로 이동 -->
                </ul>
            </li>
        </ul>
    </div>
    <div class="background-overlay">
        <div class="main content">
            <p>계획부터 예약까지, 여행이 쉬워지는</p>
            <h1>나를 아는 여행, Trip Pocket</h1>
        </div>
       <div class="section content">
          <h1>원하는 것만 하는 나만의 특별한 여행, 가능할까요?</h1>
          <h2><img src="cherryflower.png" alt="계획세우는 이미지"></h2>
          <h1>나만을 위한 맞춤형 여행</h1>
          <p>
              여행 준비가 번거로우신가요?<br>
              Trip Pocket과 함께라면 쉽고 간편하게 일정을 계획하고 수정할 수 있습니다.<br>
              이제는 스트레스 없이 완벽한 여행을 즐겨보세요.
          </p>
      </div>
        <div class="section content">
          <h1>내가 가려는 그곳, 여행지로서 매력이 있나요?</h1>
          <h2><img src="cherryflower.png" alt="여행지 보드 이미지"></h2>
          <h1>궁금한 정보를 한눈에</h1>
          <p>
              다른 사람과 쉽게 공유해 보세요!<br>
              Trip Pocket과 함께라면 여행 준비가 더 즐거워집니다!
          </p>
      </div>
         <div class="section content">
          <h1>나의 숙소 결제, 지금 괜찮을까요?</h1>
          <h2><img src="cherryflower.png" alt="숙소이미지"></h2>
          <h1>일정에 맞는 숙소 금액을 한눈에 확인하세요</h1>
          <p>
              여행 중 가장 중요한 숙소!<br>
              Trip Pocket으로 한눈에 숙소 금액을 비교하고, 최적의 결정을 내리세요.<br>
              합리적인 가격으로 편안한 숙소를 예약해 보세요.
          </p>
      </div>
       <div class="section content">
          <h1>나의 항공권, 적당한 가격일까?</h1>
          <h2><img src="cherryflower.png" alt="항공이미지"></h2>
          <h1>항공권 가격, 지금이 적당해요</h1>
          <p>
              항공권 가격이 너무 비싸서 고민이신가요?<br>
                Trip Pocket으로 최적의 항공권 가격을 확인하고 예약하세요.<br>
                다양한 항공사와 경로를 비교하여 가장 합리적인 가격을 찾을 수 있습니다.
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
        // 스크립트 시작
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

        function toggleSubmenu(event, submenuId) {
            event.stopPropagation();
            var submenu = document.getElementById(submenuId);
            submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
        }

        document.addEventListener('scroll', function() {
            var sections = document.querySelectorAll('.section, .main');
            sections.forEach(function(section) {
                var rect = section.getBoundingClientRect();
                if (rect.top < window.innerHeight && rect.bottom > 0) {
                    section.classList.add('visible');
                } else {
                    section.classList.remove('visible');
                }
            });
        });

        // Trigger scroll event on page load to show sections in view
        window.addEventListener('load', function() {
            document.dispatchEvent(new Event('scroll'));
        });
        // 스크립트 끝
    </script>
</body>
</html>