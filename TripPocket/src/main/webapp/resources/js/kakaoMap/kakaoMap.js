// 카카오 지도 함수
window.fu_kakao_map = function(mapId, positions){
	
	if(!(positions)){
		console.error("좌표가 존재하지 않음");
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

	// 마커 및 오버레이 초기화
	if (!tripDayMarkerMap[mapId]) {
		tripDayMarkerMap[mapId] = [];
	} else {
		tripDayMarkerMap[mapId].forEach(m => {
			// 마커 제거
			if (m.marker) m.marker.setMap(null);
			// 오버레이 제거
			if (m.overlay) m.overlay.setMap(null);
			// 선 제거
			if (m.line) m.line.setMap(null);
			// 거리 제거
            if (m.distanceLabel) m.distanceLabel.setMap(null);
		});
		tripDayMarkerMap[mapId] = [];
	}
	
	// 지도 영역 자동 조정
	const bounds = new kakao.maps.LatLngBounds();
	
	// 좌표 경로
	const linePath = [];
	
	positions.forEach((pos, index) => {
		// 마커 좌표
		const latlng = new kakao.maps.LatLng(pos.mapy, pos.mapx);
		bounds.extend(latlng);
		linePath.push(latlng);
		const marker = new kakao.maps.Marker({ position: latlng });
		
		// 지도에 마커 추가
		marker.setMap(map);
		
		// 순서 + 장소명 표시용 커스텀 오버레이 생성
	    const overlayContent = document.createElement('div');
	    overlayContent.className = 'custom-overlay';
	    
	    // 오버레이 css
	    overlayContent.style.background = "white";
	    overlayContent.style.border = "1px solid #666";
	    overlayContent.style.padding = "5px 8px";
	    overlayContent.style.fontSize = "13px";
	    overlayContent.style.color = "#000";
	    overlayContent.style.borderRadius = "6px";
	    overlayContent.style.boxShadow = "0 2px 6px rgba(0, 0, 0, 0.3)";
	    overlayContent.style.whiteSpace = "nowrap";
	    overlayContent.style.fontWeight = "bold";
	    overlayContent.style.textAlign = "center";
	    
	    // 오버레이 내용
	    overlayContent.innerHTML = index + 1+". "+ pos.tripDayPlace;

	    // 오버레이 설정
	    const overlay = new kakao.maps.CustomOverlay({
	        content: overlayContent,
	        position: latlng,
	     	// 마커 위쪽에 뜨게 조정
	        yAnchor: 2.5
	    });
	    
	    // 지도에 오버레이 추가
	    overlay.setMap(map);
		
		tripDayMarkerMap[mapId].push({
		    marker: marker,
		    overlay: overlay,
		    id: pos.tripDayId
		});
		
		// 거리 표시
        if (index > 0) {
        	// 이전 좌표
            const prev = positions[index - 1];
            const prevLatLng = new kakao.maps.LatLng(prev.mapy, prev.mapx);
            
            // 선 (Polyline)
            const line = new kakao.maps.Polyline({
                path: [prevLatLng, latlng],
                strokeWeight: 4,
                strokeColor: "#3399FF",
                strokeOpacity: 0.8,
                strokeStyle: "solid"
            });
            
            // 선 지도 표시
            line.setMap(map);
            
            // 거리 계산 (미터)
            const distance = getDistanceFromLatLon(
			    prevLatLng.getLat(), prevLatLng.getLng(),
			    latlng.getLat(), latlng.getLng()
			);
            
         	// 도보 기준 약 1분/67m
            const minutes = Math.round(distance / 67); 
         	
         	// 시간+분 으로 포맷
            const timeText = formatMinutesToTime(minutes);
         	
            const distanceDiv = document.createElement('span');
            distanceDiv.className = "distance-text";
            distanceDiv.innerText = (distance / 1000).toFixed(2) + "km / 약 " + timeText + "(도보 기준)";
            
            const distanceInfoId = document.getElementById("distance-info-" + pos.tripDayId);
            if (distanceInfoId) {
            	const existing = distanceInfoId.querySelector(".distance-text");
            	
            	if (existing) {
                    existing.remove();
                }
            	
            	distanceInfoId.appendChild(distanceDiv);
            }
            
            // 선도 저장해둬야 삭제 시 제거 가능
            tripDayMarkerMap[mapId].push({ line });
        }
    });
	
	// 모든 마커가 보이도록 영역 설정
	if (tripDayMarkerMap[mapId].length > 0) {
        map.setBounds(bounds);
    }
};

// 거리 계산 함수
window.getDistanceFromLatLon = function(lat1, lon1, lat2, lon2) {
    const R = 6371000; // 지구 반지름 (미터 단위)
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;

    const a = 
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
}

// 분(minute)을 받아서 "X시간 Y분" 형식의 문자열로 리턴
window.formatMinutesToTime = function(minutes) {
    const hours = Math.floor(minutes / 60);
    const remainMinutes = minutes % 60;

    let timeText = "";
    if (hours > 0) {
        timeText += hours + "시간 ";
    }
    timeText += remainMinutes + "분";

    return timeText;
}