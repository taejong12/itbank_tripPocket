document.addEventListener("DOMContentLoaded", function () {
	
	let currentPage = 1; // 현재 페이지
	let totalPages = 1;  // 전체 페이지 수 (나중에 API에서 받아옴)
	let currentKeyword = "";
	let currentAreaCode = "";
	let numOfRows = 10;
	
	// 검색 실행
	window.fu_tripSearch = function(event){
		event.preventDefault();
		
		currentKeyword = document.getElementById("tripSearchKeyword").value.trim();
	    currentAreaCode = document.getElementById("tripSearchAreaCode").value.trim();
	    
		 if (!currentKeyword) {
	        alert("검색어를 입력해주세요.");
	        return;
	    }
	    
	    currentPage = 1;
	    document.getElementById("tripSearchList").innerHTML = "";
	    
	    fu_fetchKeywordData(currentPage, true);
	    
	}
	
	// TourAPI4.0 호출
	window.fu_fetchKeywordData = function(currentPage, isFirstLoad){
		const baseUrl = "http://apis.data.go.kr/B551011/KorService1/searchKeyword1";
		
		const queryParams = new URLSearchParams({
		    // 인증키
		    serviceKey: "auK54OSbuSQSRU47XvsyK+k1/bUV5J/bFfonKtJslfEtdD9aCDFG1FAinQtV5yO9pK8t81jyT9AZFRL/miCcFg==", 
		    // 서비스명
		    MobileApp: "AppTest", 
		    // OS 구분
		    MobileOS: "ETC", 
		    // 페이지번호
		    pageNo: currentPage,	
		    // 한페이지결과수
		    numOfRows: numOfRows, 
			// 목록구분
		    listYN: "Y",
		    // 정렬구분 (A=제목순, C=수정일순, D=생성일순)
		    arrange: "C",
		    // 관광타입 ID (문서확인)
		    //contentTypeId: 38,
		    // 요청키워드
		    keyword: currentKeyword,
		    // 지역 코드
		    areaCode: currentAreaCode,
		    // 응답메세지 형식
		    _type: "json"
		});
		
		const APIUrl = baseUrl+"?"+queryParams.toString();
		
		fetch(APIUrl)
	    .then(response => {
	        if (!response.ok) {
	        	throw new Error("TourAPI4.0 응답 에러: " + response.status);
	        }
	        // JSON 데이터로 변환
	        return response.json();
	    })
	    .then(data => {
	    	const keyworList = data.response.body.items.item;
	    	const totalCount = Number(data.response.body.totalCount) || 0;
	    	
	    	totalPages = Math.ceil(totalCount / numOfRows);
	    	
	    	console.log("totalPages: "+totalPages);
	    	console.log("currentPage: "+currentPage);
	    	console.log("totalCount: "+totalCount);
	    	console.log("numOfRows: "+numOfRows);
	    	
	    	// 더보기 버튼 처리
			const loadMoreBtn = document.getElementById("loadMoreBtn");
			
			if (currentPage < totalPages) {
				loadMoreBtn.style.display = "block";
			} else {
				loadMoreBtn.style.display = "none";
			}
			
	    	fu_keywordSearchList(keyworList, totalCount, isFirstLoad);
	    	
		})
	    .catch(error => {
	        console.error("TourAPI4.0 호출 중 오류 발생: ", error);
	    });
	}
	
	// 검색 리스트 출력
	window.fu_keywordSearchList = function(keyworList, totalCount, isFirstLoad){

		let html='';
		
		// keyworList가 undefined거나 null이면 빈 배열로 설정
	    if (!keyworList || !Array.isArray(keyworList)) {
	        keyworList = [];
	    }
	    
	    if (isFirstLoad){
		    html ='<div class="trip-search-result">검색 결과('+totalCount+'개)</div>';
		}	    
	    
		if(keyworList.length === 0){
			html += '<p class="trip-search-result-non">검색 결과가 없습니다.</p>';
		} else {
			keyworList.forEach(function(keyword, index){

				// 이미지 처리
				const imageSrc = keyword.firstimage2 ? keyword.firstimage2 : contextPath+"/resources/image/logo/alt_image.png";
				
				// keyword 그냥 넘기면 에러 발생
				const keywordData = encodeURIComponent(JSON.stringify(keyword));

                html += '<div class="trip-item">';
	            html += '<img src="' + imageSrc + '" alt="이미지 없음" onerror="this.onerror=null; this.src=\'' + contextPath + '/resources/image/logo/alt_image.png\';">';
	            html += '<div class="trip-info">';
	            html += '<div class="title">' + keyword.title + '</div>';
	            html += '<div class="addr">' + keyword.addr1 + '</div>';
	            html += '</div>';
	            html += '<button class="trip-select-btn" onclick="fu_tripSpaceSelect(\'' + keywordData + '\')">선택</button>';
	            html += '</div>';
			})
		}
		
		if (isFirstLoad) {
			// 최초 검색 출력
	        document.getElementById("tripSearchList").innerHTML = html;
	    } else {
	    	// 더 보기 출력
	        document.getElementById("tripSearchList").innerHTML += html;
	    }
	}
	
	// 더보기 버튼 이벤트
	document.getElementById("loadMoreBtn").addEventListener("click", function() {
		currentPage++;
		fu_fetchKeywordData(currentPage, false);
	});
	
	// 선택한 장소를 부모 창에 전달하는 함수 (tripPlan -> planDetail)
    window.fu_tripSpaceSelect = function(keywordData) {
    
	    let keyword = JSON.parse(decodeURIComponent(keywordData));
	    
        // 부모 창에서 선택한 DAY
        let tripDayDay = window.opener.tripDayDay;
        let tripDayDate = window.opener.tripDayDate;
        let tripPlanId = window.opener.tripPlanId;
        if (window.opener && typeof window.opener.fu_insertTripDay === "function") {
        	// planDetail.jsp -> fu_insertTripDay
            window.opener.fu_insertTripDay(keyword, tripDayDay, tripDayDate, tripPlanId);
        }
        
        // 팝업 닫기
        window.close();
    };
	
	// 팝업 닫기 버튼
	window.fu_closePopup = function(){
		window.close();
	};
});