document.addEventListener("DOMContentLoaded", function () {
		
	document.getElementById("trip-destination-detail").innerHTML = "";
	
	//TourAPI4.0 호출
	window.fu_tripDestinationDetail = function(){
		
		const baseUrl = "http://apis.data.go.kr/B551011/KorService1/detailCommon1";
		
		const queryParams = new URLSearchParams({
		    // 인증키
		    serviceKey: "auK54OSbuSQSRU47XvsyK+k1/bUV5J/bFfonKtJslfEtdD9aCDFG1FAinQtV5yO9pK8t81jyT9AZFRL/miCcFg==", 
		    // 서비스명
		    MobileApp: "AppTest", 
		    // OS 구분
		    MobileOS: "ETC", 
		    // 기본 관광지 정보
		    defaultYN: "Y",
		    // 대표 이미지 URL
		    firstImageYN: "Y",
		    // 지역 코드 정보
		    areacodeYN: "Y",
		    // 대분류/중분류/소분류 코드
		    catcodeYN: "Y",
		    // 지번주소/도로명주소
		    addrinfoYN: "Y",
		    // 위도, 경도(mapX, mapY)
		    mapinfoYN: "Y",
		    // 관광지에 대한 설명글(overview)
		    overviewYN: "Y",
		    // 관광타입 ID (문서확인)
		    contentTypeId: 12,
		    // id
		    contentId: contentId,
		    // 응답메세지 형식
		    _type: "json"
		});
		
		const APIUrl = baseUrl+"?"+queryParams.toString();
		
		fetch(APIUrl)
	    .then(response => {
	        if (!response.ok) {
	        	throw new Error("TourAPI4.0 공통 정보 응답 에러: " + response.status);
	        }
	        // JSON 데이터로 변환
	        return response.json();
	    })
	    .then(data => {
	    	const content = data.response.body.items.item[0];
	    	fu_tripDestinationDetailHtml(content);
		})
	    .catch(error => {
	        console.error("TourAPI4.0 공통 정보 오류 발생: ", error);
	    });
	}
	
	// 관광지 상세페이지 출력
	window.fu_tripDestinationDetailHtml = function(content){

		// 대체 이미지 경로
		const altImageSrc = contextPath+"/resources/img/logo/alt_image.png";
		// 이미지 처리
		const imageSrc = content.firstimage ? content.firstimage : altImageSrc;
		
		let html='';
	    
		html ='<div class="trip-destination-title">'+content.title+'</div>';
        html += '<img src="' + imageSrc + '" alt="이미지 없음" onerror="this.onerror=null; this.src=\'' + altImageSrc + '\';">';
        
        html += '<div class="trip-info-table">';
        html += '<div class="trip-row"><span class="trip-label">홈페이지</span><span class="trip-value">' + content.homepage + '</span></div>';
        html += '<div class="trip-row"><span class="trip-label">주소</span><span class="trip-value">' + content.addr1 + ' ' + content.addr2 + '</span></div>';
        html += '<div class="trip-row"><span class="trip-label">우편번호</span><span class="trip-value">' + content.zipcode + '</span></div>';
        html += '</div>';

        html += '<div class="trip-overview-block">';
        html += '<div class="overview-title">개요</div>';
        html += '<div class="overview-content">' + content.overview + '</div>';
        html += '</div>';
	
		document.getElementById("trip-destination-detail").innerHTML = html;
	};
	
	fu_tripDestinationDetail();
});