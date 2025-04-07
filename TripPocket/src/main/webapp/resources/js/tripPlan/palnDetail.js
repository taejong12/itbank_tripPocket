// 날짜별 화면 출력
window.fu_tripPeriod = function(startDate, endDate, tripPlanId, tripDayList) {
    let start = new Date(startDate);
    let end = new Date(endDate);
    let html='';
    let tripDayDay = 1;
    
    // 지도 초기화할 정보 저장용
    let kakaoMapInitList = [];
		    
    while (start <= end) {
    	let year = start.getFullYear();
        let month = String(start.getMonth() + 1).padStart(2, '0');  // 월 (0부터 시작하므로 +1)
        let day = String(start.getDate()).padStart(2, '0'); // 일
        let tripDayDate = year + "-" + month + "-" + day;
        let tripDay = "DAY"+tripDayDay+"("+month+"월 "+day+"일)";
        
		// 고유한 kakao_map id 생성
        let kakaoMapId = "kakao_map_"+tripDayDay;
        html += "<div id='"+kakaoMapId+"' class='kakao_map'></div>";
        
        html += "<li id='day-" + tripDayDay + "'>";
        html += "<strong>" + tripDay + "</strong>";
        html += "<ul class='tripDayList'>";
        
     	// tripDayList에서 해당 tripDayDay에 맞는 데이터 추가
        tripDayList.forEach(tripDayDTO => {
		    if (tripDayDTO.tripDayDay == tripDayDay) {
		        html += "<li id='" + tripDayDTO.tripDayId + "' class='trip-day-id'>";
		        
		        // 지도 위치 정보 저장해두기
                if (tripDayDTO.tripDayMapx && tripDayDTO.tripDayMapy) {
                    kakaoMapInitList.push({
                    	tripDayId: tripDayDTO.tripDayId,
                        mapx: tripDayDTO.tripDayMapx,
                        mapy: tripDayDTO.tripDayMapy,
                        mapId: kakaoMapId,
                        tripDayPlace: tripDayDTO.tripDayPlace
                    });
                }
		        
		        html += "<div class='trip-day-div'>";
		        html += "<img src='" + tripDayDTO.tripDayImage + "' class='trip-day-img'>";
		        html += "<div class='trip-day-place-address-div'>";
		        html += "<span class='trip-day-place'>" + tripDayDTO.tripDayPlace + "</span>";
		        html += "<span class='trip-day-address'>" + tripDayDTO.tripDayAddress + "</span>";
		        html += "</div>";
		        html += "</div>";
		        html += "<button onclick=\"fu_deleteTripDay('" + tripDayDTO.tripDayId + "', '" +tripDayDay +"')\" class='trip-day-delete-btn'>삭제</button>";
		        html += "</li>";
		    }
		});

        html += "</ul>";
        html += "<button onclick=\"fu_openTripSearchPopup(" + tripDayDay + ", '" + tripDayDate + "', " + tripPlanId + ")\">장소추가(팝업)</button>";
        html += "</li>";

        // 날짜 +1일 증가
        start.setDate(start.getDate() + 1);
        tripDayDay++;
    }
    
	document.getElementById("dayList").innerHTML = html;
	
	// 지도 Id 별로 좌표 묶기
	window.groupMapId = {}; 
	
	// HTML 렌더링 이후에 지도 생성
	kakaoMapInitList.forEach(({ tripDayId, mapx, mapy, mapId, tripDayPlace }) => {
	    if (!groupMapId[mapId]) {
	        groupMapId[mapId] = [];
	    }
	    groupMapId[mapId].push({ tripDayId, mapx, mapy, tripDayPlace});
	});
	
	// mapId별로 한 번씩 fu_kakao_map 호출
	Object.entries(groupMapId).forEach(([mapId, positions]) => {
		// 배열 안에 값이 있는 경우
		if (positions.length > 0) {
	    	fu_kakao_map(mapId, positions);
	    }
	});
}
		
// 팝업창 열기
window.fu_openTripSearchPopup = function(tripDayDay, tripDayDate, tripPlanId) {
	
	window.tripDayDay = tripDayDay;
	window.tripDayDate = tripDayDate;
	window.tripPlanId = tripPlanId;
	let popup = window.open(contextPath+"/popup/tripSearch.do", "여행지 팝업창", "width=1000,height=600,scrollbars=yes");
}
		
// 부모 창에서 장소 정보를 추가하는 함수(팝업 -> 장소 추가)
window.fu_insertTripDay = function(keyword, tripDayDay, tripDayDate, tripPlanId) {
    let tripDayQuery = document.querySelector("#day-" + tripDayDay + " .tripDayList");
    let kakaoMapId = "kakao_map_"+tripDayDay;
    
    let tripDayData = {
    	tripDayDay: tripDayDay,
        tripDayPlace: keyword.title,
        tripDayAddress: keyword.addr1,
        tripDayDate: tripDayDate,
        tripDayImage: keyword.firstimage2,
        tripPlanId: tripPlanId,
        tripDayMapx: keyword.mapx,
        tripDayMapy: keyword.mapy
    };
 	
    fetch(contextPath+"/trip/insertTripDay.do", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(tripDayData)
    })
    .then(response => {
        if (!response.ok) {
        	 throw new Error("여행장소추가 응답 중 에러: " + response.status);
        }
        return response.json();
    })
    .then(map => {

        // 저장된 tripDayId 가져오기
        let tripDayId = map.tripDayId;

        let tripDayIdQuery = document.createElement("li");
        tripDayIdQuery.setAttribute("id", tripDayId);
        tripDayIdQuery.classList.add("trip-day-id");

        // 이미지 요소 생성
        let imgQuery = document.createElement("img");
        imgQuery.src = keyword.firstimage2;
        imgQuery.classList.add("trip-day-img");

		// 장소 + 주소 div 생성 (장소 + 주소 정보 포함)
		let placeAddressDiv = document.createElement("div");
		placeAddressDiv.classList.add("trip-day-place-address-div");
				
		// 장소 이름
		let placeSpan = document.createElement("span");
		placeSpan.textContent = keyword.title;
		placeSpan.classList.add("trip-day-place");

		// 주소 정보
		let addressSpan = document.createElement("span");
		addressSpan.textContent = keyword.addr1;
		addressSpan.classList.add("trip-day-address");

		// 장소 + 주소 -> div
		placeAddressDiv.appendChild(placeSpan);
		placeAddressDiv.appendChild(addressSpan);

        // (이미지 + (장소+주소)) div 생성 (이미지 + (장소+주소) 포함)
		let imgPlaceAddrDiv = document.createElement("div");
		imgPlaceAddrDiv.classList.add("trip-day-div");
		imgPlaceAddrDiv.appendChild(imgQuery);
		imgPlaceAddrDiv.appendChild(placeAddressDiv);
        
        // mapx, mapy 값을 히든 인풋으로 추가
		let hiddenMapX = document.createElement("input");
		hiddenMapX.type = "hidden";
		hiddenMapX.name = "mapx";
		hiddenMapX.value = keyword.mapx;
		
		let hiddenMapY = document.createElement("input");
		hiddenMapY.type = "hidden";
		hiddenMapY.name = "mapy";
		hiddenMapY.value = keyword.mapy;
        
        // 삭제 버튼 생성
        let deleteButton = document.createElement("button");
        deleteButton.textContent = "삭제";
        deleteButton.classList.add("trip-day-delete-btn");
        deleteButton.setAttribute("onclick", "fu_deleteTripDay('" + tripDayId + "', '" + tripDayDay + "')");


        // 요소 추가
		tripDayIdQuery.appendChild(imgPlaceAddrDiv);
		tripDayIdQuery.appendChild(hiddenMapX);
		tripDayIdQuery.appendChild(hiddenMapY);
		tripDayIdQuery.appendChild(deleteButton);

        if (tripDayQuery) {
            tripDayQuery.appendChild(tripDayIdQuery);
        }
        
        if (!groupMapId[kakaoMapId]) {
		    groupMapId[kakaoMapId] = [];
		}
        
        groupMapId[kakaoMapId].push({ tripDayId:tripDayId, mapx: keyword.mapx, mapy: keyword.mapy, tripDayPlace: keyword.title });
        
        // mapId별로 한 번씩 fu_kakao_map 호출
		Object.entries(groupMapId).forEach(([mapId, positions]) => {
		    // 배열 안에 값이 있는 경우
			if (positions.length > 0) {
		    	fu_kakao_map(mapId, positions);
		    }
		});
       
    })
    .catch(error => {
        console.error("오류 발생:", error);
    });
}
		
// 장소 삭제
window.fu_deleteTripDay = function(tripDayId, tripDayDay) {
 	
 	const kakaoMapId = "kakao_map_"+tripDayDay;
 	
 	// 마커 및 오버레이 제거
    if (tripDayMarkerMap[kakaoMapId]) {
        tripDayMarkerMap[kakaoMapId] = tripDayMarkerMap[kakaoMapId].filter(obj => {
	        if (String(obj.id) === String(tripDayId)) {
	        
	        	// 마커 제거
	            obj.marker.setMap(null);
	            
	            // 오버레이 제거
	            if (obj.overlay) {
			        obj.overlay.setMap(null);
			    }
			    
	            // 리스트에서도 제거
	            return false;
	        }
	        return true;
	    });
    }
    
	// 남아있는 마커 기준으로 bounds 다시 계산 -> 영역 재설정
    const remainingMarkers = tripDayMarkerMap[kakaoMapId];
    
    if (remainingMarkers.length > 0) {
        const bounds = new kakao.maps.LatLngBounds();
        remainingMarkers.forEach(obj => bounds.extend(obj.marker.getPosition()));
        const map = document.getElementById(kakaoMapId)._map;
        if (map) {
            map.setBounds(bounds);
        }
    } else {
    
	    // 마커가 0개면 지도 숨기기
	    const kakaoMapIdDiv = document.getElementById(kakaoMapId);
	    
	    if (kakaoMapIdDiv) {
	        kakaoMapIdDiv.style.display = "none";
	    }
	}
 	
 	if (groupMapId[kakaoMapId]) {
 		groupMapId[kakaoMapId] = groupMapId[kakaoMapId].filter(
 			item => String(item.tripDayId) !== String(tripDayId)
 		);
 		
 		// 삭제 후 배열이 비었으면 아예 제거
	    if (groupMapId[kakaoMapId].length === 0) {
	        delete groupMapId[kakaoMapId];
	    } else {
	    	fu_kakao_map(kakaoMapId, groupMapId[kakaoMapId]);
	    }
 	}
 	
    fetch(contextPath+"/trip/deleteTripDay.do", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(tripDayId) 
    })
    .then(response => {
        if (!response.ok) {
        	throw new Error("여행장소삭제 응답 중 에러: " + response.status);
        }
        return response.text();
    })
    .then(result => {

	    // 삭제된 요소를 화면에서 제거
	    let delete_li = document.getElementById(tripDayId);
    
    	if (delete_li) {
    		delete_li.remove();
        }
    })
    .catch(error => {
        console.error("여행장소삭제 오류 발생:", error);
    });
}