<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<body>
  <header>
        <a href="${contextPath }/main.do" class="logo">Trip Pocket</a> <!-- 메인페이지로 이동 -->
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
			<c:choose>
				<c:when test="${isLogin == true && member != null}">
					<div class="profile-container">
						<div>
	                        <p>${member.memberNickname}님</p>
	                        <p>${member.memberEmail}</p>
	                    </div>
	                    <img src="${contextPath}/resources/img/profile/basic.png">
	                </div>
					<li>
						<a href="#" onclick="toggleSubmenu(event, 'mypage-submenu')">마이페이지</a>
		                <ul class="submenu" id="mypage-submenu">
		                    <li><a href="${contextPath }/member/mypage.do">내 정보</a></li> <!-- 내 정보 페이지로 이동 -->
		                     <li><a href="${contextPath}/trip/planList.do">여행 계획 일정만들기</a></li> <!-- 여행 계획 세우기로 이동 -->
		                </ul>
	            	</li>
            	</c:when>
        		<c:otherwise>
        			<li><a href="${contextPath}/member/loginForm.do">로그인/회원가입</a></li>
        		</c:otherwise>
            </c:choose> <!-- 로그인 페이지로 이동 -->
            
			<li>
				<a href="${contextPath}/tripDestination/list.do">관광지</a>
			</li>
            <li><a href="#" onclick="toggleSubmenu(event, 'share-submenu')">여행 블로그</a>
                <ul class="submenu" id="share-submenu">
                    <li><a href="${contextPath }/share/myShare.do">나의 여행 글 쓰기</a></li> <!-- 나의 여행 글 쓰기 페이지로 이동 -->
                    <li><a href="${contextPath }/share/shareList.do">다른 사용자들의 여행 후기</a></li><!-- 다른 사용자들의 여행리스트 페이지로 이동 -->
                </ul>
            </li>
            <li>
				<a href="${contextPath}/event/random.do">랜덤으로 만나는 특별한 여행지</a>
			</li>
            <c:if test="${isLogin == true && member != null }">
        		 <li><a href="${contextPath }/member/logout.do">로그아웃</a></li>
        	</c:if>
        </ul>
    </div>
</body>
</html>