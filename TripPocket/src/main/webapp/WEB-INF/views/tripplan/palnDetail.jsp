<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행 계획 상세페이지</title>
</head>
<body>
	<c:forEach var="tripDay" items="${tripDayList}">
		<ul>
			<li>Day: ${tripDay.trip_day_day}</li>
			<li>장소: ${tripDay.trip_day_adr}</li>
		</ul>
	</c:forEach>
	
	<a href="${contextPath}/trip/planList.do">목록</a>
</body>
</html>