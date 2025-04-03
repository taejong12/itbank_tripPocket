<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행지 선택 팝업창</title>
</head>
<link rel="stylesheet" href="${contextPath}/resources/css/popup/tripPlan.css">
<body>
	<input type="text" name="tripSearchKeyword" id="tripSearchKeyword" placeholder="검색어 입력">
	<button onclick="fu_tripSearch(event)">여행지 검색</button>
	
	<h2>검색 결과</h2>
	<div id="tripSearchList" class="card-container"></div>
	
	<button onclick="fu_closePopup()">닫기</button>
   
    <script src="${contextPath}/resources/script/popup/tripPlan.js"></script>
</body>
</html>