<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 

<link rel="stylesheet" href="${contextPath}/resources/css/tripPlan/planDetail.css">
<link rel="stylesheet" href="${contextPath}/resources/css/kakaoMap/kakaoMap.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0013492b2b76abad18e946130e719814" ></script>

<h1 class="trip-plan-title">${tripPlanDTO.tripPlanTitle}</h1>

<ul id="trip-day-list"></ul>

<a class="plan-list" href="${contextPath}/trip/planList.do">목록</a>

<script type="text/javascript">
	let contextPath = '${contextPath}';
	
	// 마커 리스트
	window.tripDayMarkerMap = [];

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
	            tripDayPlace: "${tripDay.tripDayPlace}",
	            tripDayAddress: "${tripDay.tripDayAddress}",
	            tripDayImage: "${tripDay.tripDayImage}",
	            tripDayContentId: "${tripDay.tripDayContentId}",
	            tripDayMapx: "${tripDay.tripDayMapx}",
	            tripDayMapy: "${tripDay.tripDayMapy}"
	        });
	    </c:forEach>
	 	
    	// 날짜별 화면 출력
		fu_tripPeriod(startDate, endDate, tripPlanId, tripDayList);
	});
	
</script>
<script src="${contextPath}/resources/js/tripPlan/planDetail.js"></script>

<!-- 카카오 지도 스크립트-->
<script src="${contextPath}/resources/js/kakaoMap/kakaoMap.js"></script>
