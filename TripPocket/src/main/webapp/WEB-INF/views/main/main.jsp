<%@page import="com.tripPocket.www.member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trip Pocket Intro</title>
<%
    String contextPath = request.getContextPath();
	Boolean isLogin = (Boolean) session.getAttribute("isLogin");
	MemberDTO member = (MemberDTO) session.getAttribute("member");
%>
</head>
<body onclick="closeMenu(event)">
    
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
        <c:if test="${isLogin == false || member == null }">
        	<div class="section content">
            <h1><a href="<%= contextPath%>/member/loginForm.do">Trip Pocket 시작하기</a></h1>
        </div>
        </c:if>
        
    </div>
   
</body>
</html>
