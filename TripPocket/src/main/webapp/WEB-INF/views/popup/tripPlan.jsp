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
	<select id="tripSearchAreaCode">
		<option value="" selected>전체</option>
		<option value="1">서울</option>
		<option value="2">인천</option>
		<option value="3">대전</option>
		<option value="4">대구</option>
		<option value="5">광주</option>
		<option value="6">부산</option>
		<option value="7">울산</option>
		<option value="8">세종특별자치시</option>
		<option value="31">경기도</option>
		<option value="32">강원특별자치도</option>
		<option value="33">충청북도</option>
		<option value="34">충청남도</option>
		<option value="35">경상북도</option>
		<option value="36">경상남도</option>
		<option value="37">전북특별자치도</option>
		<option value="38">전라남도</option>
		<option value="39">제주특별자치도</option>
	</select>
	<button onclick="fu_tripSearch(event)">여행지 검색</button>
	
	<h2>검색 결과</h2>
	<div id="tripSearchList" class="card-container"></div>
	
	<button onclick="fu_closePopup()">닫기</button>
   
    <script src="${contextPath}/resources/js/popup/tripPlan.js"></script>
</body>
</html>