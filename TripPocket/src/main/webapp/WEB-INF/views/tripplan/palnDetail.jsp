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
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0013492b2b76abad18e946130e719814"></script>
</head>
<body id="tripDetailPage">

	<h1>${tripPlanDTO.tripPlanTitle}</h1>
	
	
	<div id="kakao_map" style="width:100%;height:400px;"></div>
	
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
	
	<!-- 카카오 지도 사용하기 -->
	<script type="text/javascript">
	
		window.fu_kakao_map = function(mapx, mapy){
			
			console.log("mapx: "+mapx);
			console.log("mapy: "+mapy);
			 let container = document.getElementById('kakao_map'); 
		     let options = {
		    		// 위도(mapy), 경도(mapx) 순서
		    	    center: new kakao.maps.LatLng(mapy, mapx), 
		      // 확대 레벨
		         level: 3
		     };
		
		     let map = new kakao.maps.Map(container, options);
		     
		  	 // 마커 좌표
		     let markerPosition  = new kakao.maps.LatLng(mapy, mapx);
	
		     let marker = new kakao.maps.Marker({
		         position: markerPosition
		     });
		     
		  	// 지도에 마커 추가
		     marker.setMap(map);
		  	
		     kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		         var latlng = mouseEvent.latLng; 
		         console.log("클릭한 위치의 좌표:", latlng.getLat(), latlng.getLng());
		     });
		};
	</script>
</body>
</html>