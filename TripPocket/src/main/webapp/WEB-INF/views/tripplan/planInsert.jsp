<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>날짜/지역 정하기</title>
<link rel="stylesheet" href="${contextPath}/resources/css/tripPlan/planInsert.css">
</head>
<body>
	<form name="planInsert">
		<div>
			제목:<input type="text" name="tripPlanTitle">
		</div>
		<div>		
			설명:<input type="text" name="tripPlanContent">
		</div>
		<div>
			여행출발일:<input type="date" name="tripPlanStartDay">
		</div>
		<div>
			여행도착일:<input type="date" name="tripPlanArriveDay">
		</div>
		<button onclick="fu_planInsert(event)">선택완료</button>
	</form>
	
	<script>
		// JavaScript 변수로 저장
	    let contextPath = "${contextPath}";
	</script>
	<script src="${contextPath}/resources/js/tripPlan/planInsert.js"></script>
</body>
</html>