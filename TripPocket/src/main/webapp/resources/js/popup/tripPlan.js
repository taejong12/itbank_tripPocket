document.addEventListener("DOMContentLoaded", function () {
	
	// TourAPI4.0 검색
	window.fu_tripSearch = function(event){
		event.preventDefault();
		
		let keyword = document.getElementById("tripSearchKeyword").value.trim();
	    
	    let areaCode = document.getElementById("tripSearchAreaCode").value.trim();
	    
		 if (!keyword) {
	        alert("검색어를 입력해주세요.");
	        return;
	    }
	    
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
		    // 지역 코드
		    areaCode: areaCode,
		    // 응답메세지 형식
		    _type: "json" 
		});
		
		const api_url = baseUrl+"?"+queryParams.toString();
		
		fetch(api_url)
	    .then(response => {
	        if (!response.ok) {
	        	throw new Error("TourAPI4.0 응답 에러: " + response.status);
	        }
	        // JSON 데이터로 변환
	        return response.json();
	    })
	    .then(data => {
	    	const keyword_list = data.response.body.items.item;
	    	fu_keywordSearchList(keyword_list);
		})
	    .catch(error => {
	        console.error("TourAPI4.0 호출 중 오류 발생: ", error);
	    });
	}
	
	// 검색 리스트 출력
	window.fu_keywordSearchList = function(keyword_list){

		let html='';
		
		// keyword_list가 undefined거나 null이면 빈 배열로 설정
	    if (!keyword_list || !Array.isArray(keyword_list)) {
	        keyword_list = [];
	    }
	    
		if(keyword_list.length === 0){
			html += '<p class="text-center">검색 결과가 없습니다.</p>';
		} else{
			keyword_list.forEach(function(keyword, index){
			
				// 이미지 처리
				let imageSrc = keyword.firstimage2 ? keyword.firstimage2 : "no_image.png";
				
				// keyword 그냥 넘기면 에러 발생
				let keywordData = encodeURIComponent(JSON.stringify(keyword));
				
				html += '<div class="card" onclick="fu_tripSpaceChoice(\'' + keywordData + '\')">';
                html += '<img src="'+ imageSrc +'" alt="이미지 없음">';
                html += '<p class="card-title">'+keyword.title+'</p>';
                html += '<p class="card-title">주소:'+keyword.addr1+'</p>';
                html += '</div>';
                
			})
		}
		document.getElementById("tripSearchList").innerHTML = html;
		
	}
	
	// 선택한 장소를 부모 창에 전달하는 함수 (tripPlan -> palnDetail)
    window.fu_tripSpaceChoice = function(keywordData) {
    
	    let keyword = JSON.parse(decodeURIComponent(keywordData));
	    
        // 부모 창에서 선택한 DAY
        let tripDayDay = window.opener.tripDayDay;
        let tripDayDate = window.opener.tripDayDate;
        let tripPlanId = window.opener.tripPlanId;
        if (window.opener && typeof window.opener.fu_insertTripDay === "function") {
        	// palnDetail.jsp -> fu_insertTripDay
            window.opener.fu_insertTripDay(keyword, tripDayDay, tripDayDate, tripPlanId);
        }
        
        // 팝업 닫기
        window.close();
    };
	
	window.fu_closePopup = function(){
		window.close();
	};
});