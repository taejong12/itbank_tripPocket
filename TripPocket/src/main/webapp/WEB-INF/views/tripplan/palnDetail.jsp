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
<link rel="stylesheet" href="${contextPath}/resources/css/kakao_map/kakao_map.css">
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0013492b2b76abad18e946130e719814"></script>
</head>
<body id="tripDetailPage">

	<h1>${tripPlanDTO.tripPlanTitle}</h1>
	
	<ul id="dayList"></ul>
	
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
		            tripDayMapx: "${tripDay.tripDayMapx}",
		            tripDayMapy: "${tripDay.tripDayMapy}"
		        });
		    </c:forEach>
			
		 	// 날짜별 화면 출력
			fu_tripPeriod(startDate, endDate, tripPlanId, tripDayList);
		});
	</script>
	<script src="${contextPath}/resources/js/tripPlan/palnDetail.js"></script>
	
	<!-- 카카오 지도 사용하기 -->
	<script type="text/javascript">
		// 카카오 지도 함수
		window.fu_kakao_map = function(mapId, positions){
			
			if(!(positions)){
				console.log("좌표가 존재하지 않음");
				return;
			}
			
			let kakao_map_id = document.getElementById(mapId); 
			
			// display 해제 (보이도록 설정)
			if(kakao_map_id.style.display = "none"){				
			    kakao_map_id.style.display = "block";
			}
			
			if(!kakao_map_id._map){				
			    // 지도 생성
				let options = {
					// 위도(mapy), 경도(mapx) 순서
					center: new kakao.maps.LatLng(positions[0].mapy, positions[0].mapx), 
					// 확대 레벨
					level: 3
				};
				kakao_map_id._map = new kakao.maps.Map(kakao_map_id, options);
			}

			let map = kakao_map_id._map;

			// 마커 초기화
			if (!tripDayMarkerMap[mapId]) {
				tripDayMarkerMap[mapId] = [];
			} else {
				tripDayMarkerMap[mapId].forEach(m => m.marker.setMap(null));
				tripDayMarkerMap[mapId] = [];
			}
			
			// 지도 영역 자동 조정
			const bounds = new kakao.maps.LatLngBounds();
			
			positions.forEach(pos => {
				// 마커 좌표
				const latlng = new kakao.maps.LatLng(pos.mapy, pos.mapx);
				bounds.extend(latlng);

				const marker = new kakao.maps.Marker({ position: latlng });
				
				// 지도에 마커 추가
				marker.setMap(map);
				
				tripDayMarkerMap[mapId].push({
				    marker: marker,
				    id: pos.tripDayId
				});
			});
			
			// 모든 마커가 보이도록 영역 설정
			if (tripDayMarkerMap[mapId].length > 0) {
		        map.setBounds(bounds);
		    }
			
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
				let latlng = mouseEvent.latLng; 
				console.log("클릭한 위치의 좌표:", latlng.getLat(), latlng.getLng());
			});
		};
	</script>
</body>
</html>