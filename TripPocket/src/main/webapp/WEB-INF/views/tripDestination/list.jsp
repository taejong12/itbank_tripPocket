<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 

<div id="trip-destination-list"></div>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
		let contextPath = "${contextPath}";
		let currentPage = 1; // 현재 페이지
		let totalPages = 1;  // 전체 페이지 수 (나중에 API에서 받아옴)
		let currentAreaCode = "${areaCode}";
		let numOfRows = 12;
		
	    document.getElementById("trip-destination-list").innerHTML = "";
	    
		// TourAPI4.0 호출
		window.fu_tripDestinationList = function(pageNo){
			currentPage = pageNo;
			
			const baseUrl = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1";
			
			const queryParams = new URLSearchParams({
			    // 인증키
			    serviceKey: "auK54OSbuSQSRU47XvsyK+k1/bUV5J/bFfonKtJslfEtdD9aCDFG1FAinQtV5yO9pK8t81jyT9AZFRL/miCcFg==", 
			    // 서비스명
			    MobileApp: "AppTest", 
			    // OS 구분
			    MobileOS: "ETC", 
			    // 페이지번호
			    pageNo: pageNo,	
			    // 한페이지결과수
			    numOfRows: numOfRows, 
				// 목록구분
			    listYN: "Y",
			    // 정렬구분 (A=제목순, C=수정일순, D=생성일순)
			    arrange: "C",
			    // 관광타입 ID (문서확인) 12=관광지
			    contentTypeId: 12,
			    // 지역 코드
			    areaCode: currentAreaCode,
			    // 응답메세지 형식
			    _type: "json"
			});
			
			const APIUrl = baseUrl+"?"+queryParams.toString();
			
			fetch(APIUrl)
		    .then(response => {
		        if (!response.ok) {
		        	throw new Error("TourAPI4.0 관광지 응답 에러: " + response.status);
		        }
		        // JSON 데이터로 변환
		        return response.json();
		    })
		    .then(data => {
		    	const tripDestinationList = data.response.body.items.item;
		    	const totalCount = Number(data.response.body.totalCount) || 0;
		    	
		    	totalPages = Math.ceil(totalCount / numOfRows);
		    	
		    	fu_tripDestinationListHtml(tripDestinationList, totalCount);
		    	
			})
		    .catch(error => {
		        console.error("TourAPI4.0 관광지 호출 중 오류 발생: ", error);
		    });
		}
		
		// 관광지 리스트 출력
		window.fu_tripDestinationListHtml = function(tripDestinationList, totalCount){
	
			let html='';
			
			// tripDestinationList가 undefined거나 null이면 빈 배열로 설정
		    if (!tripDestinationList || !Array.isArray(tripDestinationList)) {
		    	tripDestinationList = [];
		    }
		    
		    const areaCodeMap = {
	    		"": "전체","0": "전체","1": "서울","2": "인천","3": "대전","4": "대구",
	    		"5": "광주","6": "부산","7": "울산","8": "세종","31": "경기","32": "강원","33": "충북",
	    		"34": "충남","35": "경북","36": "경남","37": "전북","38": "전남","39": "제주"
			};

    		let areaName = areaCodeMap[currentAreaCode] || "전체";
			
			html ='<div class="trip-destination-region">'+areaName+' ('+totalCount+'개)</div>';
		    
			html += '<div class="trip-destination-list-grid">';
			if(tripDestinationList.length === 0){
				html += '<p class="trip-destination-region-non">목록이 없습니다.</p>';
			} else {
				tripDestinationList.forEach(function(destination, index){
					
					// 대체 이미지 경로
					const altImageSrc = contextPath+"/resources/image/logo/alt_image.png";
					// 이미지 처리
					const imageSrc = destination.firstimage2 ? destination.firstimage2 : altImageSrc;
					// 그냥 넘기면 에러 발생
					const destinationData = encodeURIComponent(JSON.stringify(destination));
	
	                html += '<div class="trip-destination-div">';
	                html += '<img src="' + imageSrc + '" alt="이미지 없음" onerror="this.onerror=null; this.src=\'' + altImageSrc + '\';">';
		            html += '<div class="trip-destination-info">';
		            html += '<div class="trip-place">' + destination.title + '</div>';
		            html += '<div class="trip-address">' + destination.addr1 + '</div>';
		            html += '</div>';
		            html += '</div>';
				});
			}
			html += '</div>';
			
			html += '<div class="trip-destination-pagination">';
			
			const pagesPerGroup = 10; // 한 번에 보여줄 페이지 수
			const currentGroup = Math.ceil(currentPage / pagesPerGroup);
			const startPage = (currentGroup - 1) * pagesPerGroup + 1;
			let endPage = currentGroup * pagesPerGroup;
			if (endPage > totalPages) endPage = totalPages;

			// 이전 버튼
			if (startPage > 1) {
			    html += '<button class="page-btn" onclick="fu_tripDestinationList(' + (startPage - 1) + ')">&laquo; 이전</button>';
			}
			
			// 페이지 번호 버튼
			for (let i = startPage; i <= endPage; i++) {
				html += '<button class="page-btn ' + (i === currentPage ? 'active' : '') + '" onclick="fu_tripDestinationList(' + i + ')">' + i + '</button>';
			}
			
			// 다음 버튼
			if (endPage < totalPages) {
			    html += '<button class="page-btn" onclick="fu_tripDestinationList(' + (endPage + 1) + ')">다음 &raquo;</button>';
			}
			
			html += '</div>';
			
			document.getElementById("trip-destination-list").innerHTML = html;
		};
		
		fu_tripDestinationList(currentPage);
		
	});
</script>
