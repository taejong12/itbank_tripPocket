let hasPicked = false; // 랜덤 여행지를 한 번 뽑았는지 여부
let isLoading = false; // 요청 진행 여부

const regionDescriptions = { // 지역별 타이틀 문구
	"서울": "전통과 현대가 공존하는 감성 도시!",
    "인천": "바다와 먹거리가 어우러진 매력적인 항구!",
    "대전": "느긋한 여유 속에 과학과 자연이 숨 쉬는 곳!",
    "대구": "뜨거운 열정과 독특한 먹거리가 넘치는 도시!",
    "광주": "예술과 문화의 향기가 퍼지는 감성 여행지!",
    "부산": "푸른 바다와 야경이 로맨틱한 해양 도시!",
    "울산": "자연과 산업의 조화 속에서 힐링을 느껴보세요!",
    "세종": "조용한 여유와 세련된 도시 분위기가 공존하는 곳!",
    "경기": "도심 가까이에서 즐기는 간편한 힐링 여행!",
    "강원": "맑은 공기와 푸른 자연이 가득한 청정 지역!",
    "충북": "숨은 자연 명소가 가득한 조용한 힐링 여행지!",
    "충남": "역사와 자연이 어우러진 풍성한 풍경 속으로!",
    "경북": "전통의 향기 속에서 옛 정취를 느낄 수 있는 곳!",
    "경남": "남해의 잔잔한 파도와 여유로운 풍경!",
    "전북": "맛과 멋, 한옥의 정취가 어우러진 고즈넉한 공간!",
    "전남": "따뜻한 남도의 정이 가득한 여행지!",
    "제주": "탁 트인 바다와 초록 자연이 기다리는 낭만 섬!"
};

function pickRandomRegion() {
    if (isLoading) return; // 이미 요청이 진행 중이면 중복 클릭을 막음
    
    document.getElementById("title-text").innerText = "행운의 여행지"; // 타이틀 초기화

    // "추첨 중..." 문구를 띄운다
    document.getElementById("loading").style.display = "block";  // 추첨 중 문구 보이기
    document.getElementById("region-text").style.display = "none";  // 이전에 보였던 지역 텍스트 숨기기
    document.getElementById("initial-message").style.display = "none";  // 초기 문구 숨기기
    document.getElementById("extra-info").style.display = "none";  // 추가 정보 숨기기

    // "뽑기" 버튼을 "다시 뽑기"로 변경
    if (!hasPicked) {
        document.getElementById("btn-text").innerText = "다시 뽑기";
        hasPicked = true; // 랜덤 여행지를 한 번 뽑았으므로 상태 업데이트
    }

    isLoading = true; // 요청 시작

    fetch(contextPath + "/event/randomRegion")
        .then(response => response.json()) // JSON으로 데이터 받기
        .then(data => {
            // 1초 후에 랜덤 여행지 텍스트 출력
            setTimeout(function () {
			    document.getElementById("loading").style.display = "none";
			    document.getElementById("region-text").style.display = "block";
			    document.getElementById("region-link").innerText = data.name;
			    document.getElementById("region-link").href = `${contextPath}/tripDestination/list.do?areaCode=${data.code}`;
			    document.getElementById("region-link").style.display = "inline-block";
			    document.getElementById("extra-info").style.display = "block";
			
			    // 타이틀 변경
			    const description = regionDescriptions[data.name] || "새로운 여행지의 매력을 직접 확인해보세요!";
			    document.getElementById("title-text").innerText = description;
			
			    isLoading = false;
			}, 1000);
        })
        .catch(error => {
            console.error("Error fetching region:", error);
            isLoading = false; // 오류 발생 시 요청 상태 초기화
        });
}
