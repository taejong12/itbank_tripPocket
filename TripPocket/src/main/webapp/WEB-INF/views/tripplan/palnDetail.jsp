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
	<ul id="dayList"></ul>
	
	<a class="plan-list" href="${contextPath}/trip/planList.do">목록</a>
	
	
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function (){
			
			let startDate = '${tripPlanDTO.tripPlanStartDay}';
			let endDate = '${tripPlanDTO.tripPlanArriveDay}';
			let tripPlanId = '${tripPlanDTO.tripPlanId}';
			
			let tripDayList = [];
			
		    <c:forEach var="tripDay" items="${tripDayList}">
		        tripDayList.push({
		        	tripDayId: "${tripDay.tripDayId}",
		            tripDayDay: "${tripDay.tripDayDay}",
		            tripDayAdr: "${tripDay.tripDayAdr}",
		            tripDayImage: "${tripDay.tripDayImage}"
		        });
		    </c:forEach>
			
			// 여행 기간
			tripPeriod(startDate, endDate, tripPlanId, tripDayList);
		});
	
		window.tripPeriod = function(startDate, endDate, tripPlanId, tripDayList) {
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
	                    html += "<li>";
	                    html += "<img src='" + tripDayDTO.tripDayImage + "' width='50'> ";
	                    html += tripDayDTO.tripDayAdr;
	                    html += "</li>";
	                }
	            });
		       
	            html += "</ul>";
		        html += "<button onclick=\"openTripSearchPopup(" + tripDayDay + ", '" + tripDayDate + "', " + tripPlanId + ")\">장소추가(팝업)</button>";
		        html += "</li>";

		        // 날짜 +1일 증가
		        start.setDate(start.getDate() + 1);
		        tripDayDay++;
		    }
		    
    		document.getElementById("dayList").innerHTML = html;
		}
		
		window.openTripSearchPopup = function(tripDayDay, tripDayDate, tripPlanId) {
			
			window.tripDayDay = tripDayDay;
			window.tripDayDate = tripDayDate;
			window.tripPlanId = tripPlanId;
			let popup = window.open("${contextPath}/popup/tripSearch.do", "여행지 팝업창", "width=1000,height=600,scrollbars=yes");
		}
		
		// 부모 창에서 장소 정보를 추가하는 함수
	    window.setTripLocation = function(item, tripDayDay, tripDayDate, tripPlanId) {
		    let tripList = document.querySelector("#day-" + tripDayDay + " .tripDayList");
		    let listItem = document.createElement("li");
		    listItem.innerHTML = '<img src="' + item.firstimage2 + '" width="50"> ' + item.title;
		    tripList.appendChild(listItem);
		    
		 	// 요청할 데이터 준비
		    let tripDayData = {
		    	tripDayDay: tripDayDay,
		        tripDayAdr: item.title,
		        tripDayDate: tripDayDate,
		        tripDayImage: item.firstimage2,
		        tripPlanId: tripPlanId
		    };
		 	
		 	// fetch API 사용하여 서버에 데이터 전송
		    fetch("${contextPath}/trip/insertTripDay.do", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/json"
		        },
		        body: JSON.stringify(tripDayData)
		    })
		    .then(response => {
		        if (!response.ok) {
		            throw new Error("서버 응답 실패");
		        }
		        return response.text(); // 서버 응답 텍스트 반환
		    })
		    .then(result => {
		        console.log("저장 결과:", result);

		    })
		    .catch(error => {
		        console.error("오류 발생:", error);
		    });
		}
	</script>
</body>
</html>