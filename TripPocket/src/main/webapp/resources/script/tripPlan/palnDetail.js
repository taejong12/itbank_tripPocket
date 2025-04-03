// 날짜별 화면 출력
window.fu_tripPeriod = function(startDate, endDate, tripPlanId, tripDayList) {
    let start = new Date(startDate);
    let end = new Date(endDate);
    let html='';
    let tripDayDay = 1;
		    
    while (start <= end) {
    	let year = start.getFullYear();
        let month = String(start.getMonth() + 1).padStart(2, '0');  // 월 (0부터 시작하므로 +1)
        let day = String(start.getDate()).padStart(2, '0'); // 일
        let tripDayDate = year + "-" + month + "-" + day;
        let tripDay = "DAY"+tripDayDay+"("+month+"월 "+day+"일)";
        
        html += "<li id='day-" + tripDayDay + "'>";
        html += "<strong>" + tripDay + "</strong>";
        html += "<ul class='tripDayList'>";
        
     	// tripDayList에서 해당 tripDayDay에 맞는 데이터 추가
        tripDayList.forEach(tripDayDTO => {
		    if (tripDayDTO.tripDayDay == tripDayDay) {
		        html += "<li id='" + tripDayDTO.tripDayId + "' class='trip-item'>";
		        html += "<div class='trip-item-container'>";
		        html += "<img src='" + tripDayDTO.tripDayImage + "' class='trip-item-img'>";
		        html += "<span class='trip-item-text'>" + tripDayDTO.tripDayAdr + "</span>";
		        html += "</div>";
		        html += "<button onclick=\"fu_deleteTripDay('" + tripDayDTO.tripDayId + "')\" class='trip-item-btn'>삭제</button>";
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
    let tripList = document.querySelector("#day-" + tripDayDay + " .tripDayList");
    
    let tripDayData = {
    	tripDayDay: tripDayDay,
        tripDayAdr: keyword.title,
        tripDayDate: tripDayDate,
        tripDayImage: keyword.firstimage2,
        tripPlanId: tripPlanId
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

        let listItem = document.createElement("li");
        listItem.setAttribute("id", tripDayId);
        listItem.classList.add("trip-item");

        // 이미지 요소 생성
        let img = document.createElement("img");
        img.src = keyword.firstimage2;
        img.classList.add("trip-item-img");

        // 주소 정보 요소 생성
        let span = document.createElement("span");
        span.textContent = keyword.title;
        span.classList.add("trip-item-text");

        // 컨테이너 div 생성
        let container = document.createElement("div");
        container.classList.add("trip-item-container");
        container.appendChild(img);
        container.appendChild(span);

        // 삭제 버튼 생성
        let deleteButton = document.createElement("button");
        deleteButton.textContent = "삭제";
        deleteButton.classList.add("trip-item-btn");
        deleteButton.setAttribute("onclick", "fu_deleteTripDay('" + tripDayId + "')");

        // 요소 추가
        listItem.appendChild(container);
        listItem.appendChild(deleteButton);

        if (tripList) {
            tripList.appendChild(listItem);
        }
        
    })
    .catch(error => {
        console.error("오류 발생:", error);
    });
}
		
// 장소 삭제
window.fu_deleteTripDay = function(tripDayId) {
 	
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