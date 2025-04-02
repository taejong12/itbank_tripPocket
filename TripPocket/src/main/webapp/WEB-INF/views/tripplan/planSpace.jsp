<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>날짜별 계획 세우기</title>
</head>
<body>
	
	<ul id="tagList"></ul>
	
	<script type="text/javascript">
	
		// 사용 예시
		let startDate = "2025-04-03";
		let endDate = "2025-04-05";
		generateTags(startDate, endDate);
	
		function generateTags(startDate, endDate) {
		    let start = new Date(startDate);
		    let end = new Date(endDate);
		    let tags = [];
		    
		    let dayCount = 1;
		    while (start <= end) {
		        let month = start.getMonth() + 1;  // 월 (0부터 시작하므로 +1)
		        let day = start.getDate();  // 일
		        
		        let date = "DAY"+dayCount+"("+month+"월 "+day+"일)";
		        tags.push(date);
		        
		        // 날짜 +1일 증가
		        start.setDate(start.getDate() + 1);
		        dayCount++;
		    }
		    
		    let html='';
		    
		    tags.forEach(tag => {
		    	
		    	html += '<li>'+tag+'</li>';
		    	html += '<li><button onclick="openTripSearchPopup()">장소추가(팝업)</button></li>';
		    	
			});
		    
    		document.getElementById("tagList").innerHTML = html;
		}
	
		function openTripSearchPopup() {
			let popup = window.open("${contextPath}/popup/tripSearch.do", "여행지 팝업창", "width=800,height=600,scrollbars=yes");
		
			// 팝업 객체가 존재하면 바로 `setAddressCallback`을 설정
			/* if (popup) {
				popup.setAddressCallback = window.setAddressCallback;
			} */
		}
		
	</script>
</body>
</html>