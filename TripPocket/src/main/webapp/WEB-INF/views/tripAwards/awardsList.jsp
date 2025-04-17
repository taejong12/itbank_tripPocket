<?xml version="1.0" encoding="UTF-8"?>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${contextPath}/resources/css/tripAwards/awardsList.css"></link>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
ArrayList<String> lists = new ArrayList<String>();
lists.add("awardsBest");
lists.add("awardsSearch");
session.setAttribute("awardsBest","awardsSearch");
%>
<html>
<head><title>session영역</title></head>
<body>
<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
<a href="SessionLocation.jsp">SessionLocation.jsp 바로가기</a>

</body>
</html>

<div class="awards-list-container">
	<h1>TripAwards 🏆 다양한 여행을 수상하는 TripPocket의 시상식입니다</h1>
	</div>
<form action="${pageContext.request.contextPath}/www/awards/awardsList.do" method="get">
  <input type="text" name="keyword" placeholder="검색어를 입력하세요" />
  <button type="submit">검색</button>
</form>
<div class="container">
        <!-- 검색창 -->
        <div class="search-box">
        <form action="${contextPath}/tripAwards/awardsSearch.do" method="get">
        <label for="category">수상 종류 선택: </label>
        <select name="category" id="category">
        <option value="firstAwards">firstAwards</option>
        <option value="secondAwards">SecondAwards</option>
        <option value="monthlyAwards">monthlyAwards</option>
        <option value="photoAwards">photoAwards</option>
        </select>
        <input type="submit" value="검색"/>
        </form>
        </div>
        
 <!-- awardsBest.jsp로 이동하는 링크 버튼 추가 -->
<div class="page-navigation">
<a class="nav-btn" href="${contextPath}/trip/awardsBest.do">🏆수상작 보기로 이동🏆</a>
 </div>
 
<a href="${pageContext.request.contextPath}/www/awards/awardsList.do">목록 보기</a>
  <!-- 썸네일 목록 -->
            <div class="thumbnail-container" id="thumbnailContainer">
    <c:forEach var="thumbnail" items="${thumbnailList}">
        <div class="thumbnail-item">
            <img src="${contextPath}/resources/images/${thumbnail.image}" />
            <p>${thumbnail.name}</p>
        </div>
    </c:forEach>
</div>
<script>
    window.addEventListener('DOMContentLoaded', () => {
        const container = document.getElementById('thumbnailContainer');
        const items = Array.from(container.getElementsByClassName('thumbnail-item'));

        // 무작위 섞기 (Fisher-Yates shuffle)
        for (let i = items.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [items[i], items[j]] = [items[j], items[i]];
        }

     
</script>
</div>
   </body>    
</html> 