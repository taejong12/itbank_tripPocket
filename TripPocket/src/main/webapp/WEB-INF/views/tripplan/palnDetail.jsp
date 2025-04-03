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
<link rel="stylesheet" href="${contextPath}/resources/css/tripPlan/palnDetail.css">
</head>
<body id="tripDetailPage">

	<h1>${tripPlanDTO.tripPlanTitle}</h1>
	
	<ul id="dayList"></ul>
	
	<a class="plan-list" href="${contextPath}/trip/planList.do">목록</a>
	
	
	<script type="text/javascript">
		let contextPath = '${contextPath}';	
	
		document.addEventListener("DOMContentLoaded", function (){
			
			let startDate = '${tripPlanDTO.tripPlanStartDay}';
			let endDate = '${tripPlanDTO.tripPlanArriveDay}';
			let tripPlanId = '${tripPlanDTO.tripPlanId}';
			let tripDayList = [];
			
			// 장소 리스트
		    <c:forEach var="tripDay" items="${tripDayList}">
		        tripDayList.push({
		        	tripDayId: "${tripDay.tripDayId}",
		            tripDayDay: "${tripDay.tripDayDay}",
		            tripDayAdr: "${tripDay.tripDayAdr}",
		            tripDayImage: "${tripDay.tripDayImage}"
		        });
		    </c:forEach>
			
		 	// 날짜별 화면 출력
			fu_tripPeriod(startDate, endDate, tripPlanId, tripDayList);
		});
	</script>
	<script src="${contextPath}/resources/script/tripPlan/palnDetail.js"></script>
</body>
</html>