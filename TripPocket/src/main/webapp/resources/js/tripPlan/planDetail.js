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
        let index = 1;
        
		// 고유한 kakao_map id 생성
        let kakaoMapId = "kakao_map_"+tripDayDay;
        html += "<li id='"+kakaoMapId+"' class='kakaoMap'></li>";
        
        html += "<li id='day-" + tripDayDay + "'>";
        html += "<strong>" + tripDay + "</strong>";
        html += "<ul class='tripDayList'>";
        
		// 해당 날짜의 tripDayDTO만 필터링
		const tripDayFilterList = tripDayList.filter(tripDayDTO => tripDayDTO.tripDayDay == tripDayDay);
        
        tripDayFilterList.forEach((tripDayDTO, i) => {
        	
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
            
            //http 에러 -> https 수정
			let imageUrl = tripDayDTO.tripDayImage;
			if (imageUrl && imageUrl.startsWith("http://")) {
			    imageUrl = imageUrl.replace("http://", "https://");
			}
            
            // 대체 이미지 경로
			const altImageSrc = contextPath+"/resources/img/logo/alt_image.png";
            // 이미지 처리
            const imageSrc = imageUrl ? imageUrl : altImageSrc;
            const contentIdUrl = contextPath+"/tripDestination/detail.do?contentId="+tripDayDTO.tripDayContentId;
            
	        html += '<a target="_blank" class="trip-destination-link" href="'+contentIdUrl+'">';
            html += "<span class='trip-day-index'>" + index + "</span>";
	        html += "<div class='trip-day-div'>";
	        html += "<img src='" + imageSrc + "' class='trip-day-img' alt='이미지 없음' onerror='this.onerror=null; this.src=\"" + altImageSrc+ "\";'>";
	        html += "<div class='trip-day-place-address-div'>";
	        html += "<span class='trip-day-place'>" + tripDayDTO.tripDayPlace + "</span>";
	        html += "<span class='trip-day-address'>" + tripDayDTO.tripDayAddress + "</span>";
	        html += "</div>";
	        html += "</div>";
	        html += '</a>';
	        html += "<button onclick=\"fu_deleteTripDay('" + tripDayDTO.tripDayId + "', '" +tripDayDay +"')\" class='trip-day-delete-btn'>삭제</button>";
	        html += "</li>";
	        
	        // 마지막 장소가 아니라면 거리 정보 div 삽입 (고유 id 부여)
            if (i < tripDayFilterList.length - 1) {
            	// 현재 i 장소 -> i+1 장소 이동 거리 표시
                let nextTripDayId = tripDayFilterList[i + 1].tripDayId;
                html += "<div class='distance-info' id='distance-info-" + nextTripDayId + "'>";
                html += "<span class='trip-day-arrow'>⇩</span>";
                html += "</div>";
            }
	        
            index++;
		});
		
        html += "</ul>";
        html += "<button class='plan-search-popup-btn' onclick=\"fu_openTripSearchPopup(" + tripDayDay + ", '" + tripDayDate + "', " + tripPlanId + ")\">장소추가(팝업)</button>";
        html += "</li>";

        // 날짜 +1일 증가
        start.setDate(start.getDate() + 1);
        tripDayDay++;
    }
    
	document.getElementById("trip-day-list").innerHTML = html;
	
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
    
    //http 에러 -> https 수정
	let imageUrl = keyword.firstimage;
	if (imageUrl && imageUrl.startsWith("http://")) {
	    imageUrl = imageUrl.replace("http://", "https://");
	}
    
    let tripDayData = {
    	tripDayDay: tripDayDay,
        tripDayPlace: keyword.title,
        tripDayAddress: keyword.addr1,
        tripDayDate: tripDayDate,
        tripDayImage: imageUrl,
        tripDayContentId: keyword.contentid,
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

		//http 에러 -> https 수정
		let imageUrl = keyword.firstimage;
		if (imageUrl && imageUrl.startsWith("http://")) {
		    imageUrl = imageUrl.replace("http://", "https://");
		}

        // 이미지 요소 생성
        let imgQuery = document.createElement("img");
        imgQuery.src = imageUrl ? imageUrl : contextPath+"/resources/img/logo/alt_image.png";
        imgQuery.alt = "이미지 없음";
        imgQuery.classList.add("trip-day-img");

		// 이미지 로딩 실패 시 대체 이미지로 변경
		imgQuery.onerror = function () {
			// 무한루프 방지
		    this.onerror = null;
		    this.src = contextPath + "/resources/img/logo/alt_image.png";
		};

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

		// 인덱스 번호 생성
		let indexSpan = document.createElement("span");
		indexSpan.classList.add("trip-day-index");
		
		let lastLi = tripDayQuery.lastElementChild;
		let newIndex = 1;
		
		if(lastLi){
			let lastIndex = lastLi.querySelector(".trip-day-index");
			if(lastIndex){
				newIndex = parseInt(lastIndex.textContent) + 1;
			}
		}
		
		indexSpan.textContent = newIndex;

		let distanceDiv;

		if(newIndex > 1){
			// 거리 정보 div 생성 
			distanceDiv = document.createElement("div");
		    distanceDiv.classList.add("distance-info");
			distanceDiv.id = "distance-info-" + tripDayId;
			
			// 화살표 span 생성
			let arrowSpan = document.createElement("span");
			arrowSpan.classList.add("trip-day-arrow");
			arrowSpan.textContent = "⇩";
	
			// span을 div 안에 추가
			distanceDiv.appendChild(arrowSpan);
		}

		const contentIdUrl = contextPath+"/tripDestination/detail.do?contentId="+keyword.contentid;

		// 관광지 링크 태그
		let tripDestinationLink = document.createElement("a");
		tripDestinationLink.classList.add("trip-destination-link");
        tripDestinationLink.href = contentIdUrl;
        tripDestinationLink.target= "_blank";
        
        tripDestinationLink.appendChild(indexSpan);
        tripDestinationLink.appendChild(imgPlaceAddrDiv);
		
        // 요소 추가
		tripDayIdQuery.appendChild(tripDestinationLink);
		tripDayIdQuery.appendChild(hiddenMapX);
		tripDayIdQuery.appendChild(hiddenMapY);
		tripDayIdQuery.appendChild(deleteButton);

		if(distanceDiv){
        	tripDayQuery.appendChild(distanceDiv);
        }

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
        remainingMarkers.forEach(obj => {
        	// (마커+@) 배열과 (라인+@) 배열이 따로 존재해서 getPosition(마커 객체에만 존재) 에서 에러발생 -> 조건문처리 
	        if (obj.marker && typeof obj.marker.getPosition === 'function') {
	    		bounds.extend(obj.marker.getPosition());
	  		}
		});
		
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
	    let delete_tripDayId = document.getElementById(tripDayId);
	    let delete_distanceId = document.getElementById("distance-info-"+tripDayId);
    
    	if (delete_tripDayId) {
    		delete_tripDayId.remove();
        }
        
    	if (delete_distanceId) {
    		delete_distanceId.remove();
        }
        
        const tripDayListQuery = document.querySelector("#day-" + tripDayDay + " .tripDayList");
	    const tripDayIdList = tripDayListQuery.querySelectorAll(".trip-day-id");
		
		// 인덱스 번호 재설정
	    tripDayIdList.forEach((tripDayIdQuery, index) => {
	        const tripDayIndex = tripDayIdQuery.querySelector(".trip-day-index");
	        if (tripDayIndex) {
	            tripDayIndex.textContent = index + 1;
	        }
	        
	        // 인덱스가 0이라면 (즉, 1번 장소) → 그 위에 있는 거리 div는 없어야 하므로 제거
		    if (index === 0) {
		        const tripDayId = tripDayIdQuery.id;
		        const distanceDiv = document.getElementById("distance-info-" + tripDayId);
		        if (distanceDiv) {
		            distanceDiv.remove();
		        }
		    }
	    });
    })
    .catch(error => {
        console.error("여행장소삭제 오류 발생:", error);
    });
}

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