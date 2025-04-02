<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행지 선택 팝업창</title>
</head>
<link rel="stylesheet" href="${contextPath}/resources/css/tripPlan/tripSearch.css">
<body>
	<input type="text" name="planSearchKeyword" id="planSearchKeyword" placeholder="검색어 입력">
	<button onclick="fu_tripSearch(event)">여행지 검색</button>

	
	<h2>검색 결과</h2>
	<div id="tripSearchList" class="card-container"></div>
	
	
	<button onclick="fu_closePopup()">닫기</button>
	<!-- JS 파일 불러오기 -->
   
    <%-- <script src="${contextPath}/resources/script/tripPlan/tripSearch.js"></script> --%>
    <script type="text/javascript">

	    document.addEventListener("DOMContentLoaded", function () {
	    			
	    	window.fu_tripSearch = function(event){
	    		event.preventDefault();
	    		
	    		let keyword = document.getElementById("planSearchKeyword").value.trim();
	    		
	    		 if (!keyword) {
	   		        alert("검색어를 입력해주세요");
	   		        return;
	   		    }
	    		
	    		
	    		console.log("keyword: "+keyword);
	    		const baseUrl = "http://apis.data.go.kr/B551011/KorService1/searchKeyword1";
	    		
	    		const queryParams = new URLSearchParams({
	    		    // 인증키
	    		    serviceKey: "auK54OSbuSQSRU47XvsyK+k1/bUV5J/bFfonKtJslfEtdD9aCDFG1FAinQtV5yO9pK8t81jyT9AZFRL/miCcFg==", 
	    		    // 서비스명
	    		    MobileApp: "AppTest", 
	    		    // OS 구분
	    		    MobileOS: "ETC", 
	    		    // 페이지번호
	    		    pageNo: 1,	
	    		    // 한페이지결과수
	    		    numOfRows: 12, 
	    			// 목록구분
	    		    listYN: "Y",
	    		    // 정렬구분 (A=제목순, C=수정일순, D=생성일순)
	    		    arrange: "C",
	    		    // 관광타입 ID (문서확인)
	    		    //contentTypeId: 38,
	    		    // 요청키워드
	    		    keyword: keyword,
	    		    // 응답메세지 형식
	    		    _type: "json"  // JSON 응답 요청
	    		});
	    		
	    		const url = baseUrl+"?"+queryParams.toString(); // .toString() 추가
	    		
	    		fetch(url)
	    	    .then(response => {
	    	        if (!response.ok) {
	    	            throw new Error("HTTP 오류! 상태 코드:" + response.status);
	    	        }
	    	        return response.json();
	    	    }) // JSON 데이터로 변환
	    	    .then(data => {
	    	    	const items = data.response.body.items.item;
	    	    	tourApiSearchKeyword1(items);
	    		}) // 변환된 데이터 사용
	    	    .catch(error => {
	    	        console.log("Tour API 호출 중 오류 발생:", error);
	    	        alert("Tour API 호출 중 오류가 발생했습니다.");
	    	    }); // 에러 처리
	    	}
	    	
	    	window.tourApiSearchKeyword1 = function(items){
	
	    		let html='';
	    		if(items.length == 0){
	    			html += '<p class="text-center">검색 결과가 없습니다.</p>';
	    		} else{
	    			items.forEach(function(item, index){
	    				
	    				html += '<div class="card" onclick="tripSpaceChoice(' + index + ')">';
	                    html += '<img src='+item.firstimage2+'>';
	                    html += '<p class="card-title">'+item.title+'</p>';
	                    html += '</div>';
	                    
	        			//html += '<p><strong>주소: </strong>'+item.addr1+'</p>';
	        			//html += '<p><strong>상세주소: </strong>'+item.addr2+'</p>';
	        			//html += '<p><strong>대표이미지(원본): </strong><img src='+item.firstimage+'></p>';
	        			//html += '<p><strong>GPS X좌표: </strong>'+item.mapx+'</p>';
	        			//html += '<p><strong>GPS Y좌표: </strong>'+item.mapy+'</p>';
	    			})
	    		}
	    		document.getElementById("tripSearchList").innerHTML = html;
	    		
		    	// 선택한 장소를 부모 창에 전달하는 함수
		        window.tripSpaceChoice = function(index) {
		            let selectedItem = items[index]; // 선택한 장소 정보
		            let tripDayDay = window.opener.tripDayDay; // 부모 창에서 선택한 DAY
		            let tripDayDate = window.opener.tripDayDate; // 부모 창에서 선택한 DAY
		            let tripPlanId = window.opener.tripPlanId;
		            if (window.opener && typeof window.opener.setTripLocation === "function") {
		                window.opener.setTripLocation(selectedItem, tripDayDay, tripDayDate, tripPlanId); // 부모 창에 장소 전달
		            }
		            window.close(); // 팝업 닫기
		        };
	    	}
	    	
	    	window.fu_closePopup = function(){
	    		window.close();
	    	};
	    });
    </script>
</body>
</html>