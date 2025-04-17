<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%
    String contextPath = request.getContextPath();
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TripAwards</title>
    <link rel="stylesheet" href="<%= contextPath %>/resources/css/tripAwards/awardsBest.css">
</head>

<body>
<div class="awards-list-container">
</div>
    <h1>TripAwards 🏆 다양한 여행을 수상하는 TripPocket의 시상식입니다</h1>
    <a href="${pageContext.request.contextPath}/www/awards/awardsbest.do">수상작 보기</a>

    <!-- 1. First Awards -->
    <h2>🏆 1등 수상</h2>
    <c:forEach var="tripAwards" items="${firstAwardsList}">
        <div id="tripAwards_${tripAwards.tripAwardsId}" class="plan-box-wrapper">
        </div>
            <a href="${contextPath}/trip/awardsBest.do?tripAwardsId=${tripAwards.tripAwardsId}" class="awards-box"></a>
         <div class="awards-row5"><span class="plan-label">기사 번호</span><span class="plan-period">${tripAwards.tripArticleno}</span></div>
         <div class="awards-row6"><span class="plan-label">제목</span><span class="plan-title">${tripAwards.title}</span></div>
         <div class="awards-row7"><span class="plan-label">이미지 파일 번호</span><span class="plan-period">${tripAwards.tripImgfileno}</span></div>
         <div class="awards-row8"><span class="plan-label">내용</span><span class="plan-title">${tripAwards.tripContent}</span></div>
       
         <button class="delete-btn" onclick="fu_deleteTripAwards('${tripAwards.tripAwardsId}')">삭제</button>
    </c:forEach>

    <!-- 2. Second Awards -->
    <h2>🥈 2등 수상</h2>
    <c:forEach var="tripAwards" items="${secondAwardsList}">
        <div id="tripAwards_${tripAwards.tripAwardsId}" class="plan-box-wrapper">
            <a href="${contextPath}/trip/awardsBest.do?tripAwardsId=${tripAwards.tripAwardsId}" class="awards-box"></a>
                <div class="awards-row5"></div><span class="plan-label">기사 번호</span><span class="plan-period">${tripAwards.tripArticleno}</span></div>
                <div class="awards-row6"><span class="plan-label">제목</span><span class="plan-title">${tripAwards.title}</span></div>
                <div class="awards-row7"><span class="plan-label">이미지 파일 번호</span><span class="plan-period">${tripAwards.tripImgfileno}</span></div>
                <div class="awards-row8"><span class="plan-label">내용</span><span class="plan-title">${tripAwards.tripContent}</span></div>
          
            <button class="delete-btn" onclick="fu_deleteTripAwards('${tripAwards.tripAwardsId}')">삭제</button>
       
    </c:forEach>

    <!-- 3. Photo Awards -->
    <h3>📸 사진 수상</h3>
    <c:forEach var="tripAwards" items="${photoAwardsList}">
        <div id="tripAwards_${tripAwards.tripAwardsId}" class="plan-box-wrapper">
            <a href="${contextPath}/trip/awardsBest.do?tripAwardsId=${tripAwards.tripAwardsId}" class="awards-box"></a>
                <div class="awards-row5"><span class="plan-label">기사 번호</span><span class="plan-period">${tripAwards.tripArticleno}</span></div>
                <div class="awards-row6"><span class="plan-label">제목</span><span class="plan-title">${tripAwards.title}</span></div>
                <div class="awards-row7"><span class="plan-label">이미지 파일 번호</span><span class="plan-period">${tripAwards.tripImgfileno}</span></div>
                <div class="awards-row8"><span class="plan-label">내용</span><span class="plan-title">${tripAwards.tripContent}</span></div>
            <button class="delete-btn" onclick="fu_deleteTripAwards('${tripAwards.tripAwardsId}')">삭제</button>
        </div>
    </c:forEach>

    <!-- 4. Monthly Awards -->
    <h4>📅 월간 수상</h4>

        <div id="tripAwards_${tripAwards.tripAwardsId}" class="plan-box-wrapper"></div>
            <a href="${contextPath}/trip/awardsBest.do?tripAwardsId=${tripAwards.tripAwardsId}" class="awards-box"></a>
                <div class="awards-row1"><span class="plan-label">기사 번호</span><span class="plan-period">${tripAwards.tripArticleno}</span></div>
                <div class="awards-row2"><span class="plan-label">제목</span><span class="plan-title">${tripAwards.title}</span></div>
                <div class="awards-row7"><span class="plan-label">이미지 파일 번호</span><span class="plan-period">${tripAwards.tripImgfileno}</span></div>
                <div class="awards-row8"><span class="plan-label">내용</span><span class="plan-title">${tripAwards.tripContent}</span></div>
                <button class="delete-btn" onclick="fu_deleteTripAwards('${tripAwards.tripAwardsId}')">삭제</button>
