
document.addEventListener("DOMContentLoaded", function () {
			
	window.fu_tripSearch = function(){
		
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
		    keyword: "시장",
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
	    	console.log(data);
	    	const items = data.response.body.items.item;
	    	console.log(items);
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
			items.forEach(function(item){
                html += '<div class="card">';
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
	}
	
});