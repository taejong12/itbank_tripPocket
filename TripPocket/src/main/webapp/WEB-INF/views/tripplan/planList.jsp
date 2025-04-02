<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행계획세우기</title>
</head>
<body>
	<div>여행 계획 리스트</div>
			<c:forEach var="tripPlan" items="${tripPlanList}">
			<%-- <a href="${contextPath}/trip/planDetail.do?tripPlanId=${tripPlan.tripPlanId}">	</a> --%>
				<ul>
					<li>날짜기간</li>
					<li>출발: ${tripPlan.tripPlanStartDay}</li>
					<li>도착: ${tripPlan.tripPlanArriveDay}</li>
					<li>제목: ${tripPlan.tripPlanTitle}</li>						
				</ul>
			</c:forEach>
	
	<a href="${contextPath}/trip/planDateSet.do">여행계획추가</a>
	
</body>
</html>