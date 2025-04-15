<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>랜덤 여행지</title>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f7fb;
    color: #333;
    margin: 0;
    padding: 0;
}

.container {
    width: 600px;
    height: 600px;
    margin: 80px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
}

h1 {
    font-size: 24px;
    color: #2a8fbd;
    margin-bottom: 20px;
    letter-spacing: 1.5px;
}

h2 {
    font-size: 28px;
    font-weight: bold;
    color: #ff7043;
    margin: 40px 0;
    margin: 20px 0;
    letter-spacing: 2px;
    display: none;
}

.btn {
    display: block;
    width: 140px;
    margin: 30px auto 0;
    padding: 10px;
    background-color: #2a8fbd;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    letter-spacing: 1px;
}

.btn:hover {
    background-color: #1c6a8b;
}

.loading, .initial-message, .extra-info {
    font-size: 28px;
    color: #ff7043;
    font-weight: bold;
    display: none;
    margin-top: 20px;
}

.initial-message {
    margin-top: 10px;
    font-style: italic;
}

.extra-info {
    font-size: 16px;
    color: #666;
    margin-top: 40px;
    line-height: 1.8;
    display: none;
}

.emoji {
    font-size: 48px; /* 이모지 크기 키우기 */
    margin-bottom: 25px; /* 이모지와 타이틀 간격을 줄였습니다 */
}
#initial-message {
    display: block;
}
</style>

<script>
    let hasPicked = false; // 랜덤 여행지를 한 번 뽑았는지 여부
    let isLoading = false; // 요청 진행 여부

    function pickRandomRegion() {
        if (isLoading) return; // 이미 요청이 진행 중이면 중복 클릭을 막음

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

        fetch("${contextPath}/event/randomRegion")
            .then(response => response.text())
            .then(data => {
                // 1초 후에 랜덤 여행지 텍스트 출력
                setTimeout(function() {
                    document.getElementById("loading").style.display = "none";  // 추첨 중 문구 숨기기
                    document.getElementById("region-text").innerText = data;  // 랜덤 여행지 표시
                    document.getElementById("region-text").style.display = "block";  // 결과 문구 보이기
                    document.getElementById("extra-info").style.display = "block";  // "여기는 어떤가요?" 문구 보이기
                    isLoading = false; // 요청 완료
                }, 1000); // 1초 후에 실행
            })
            .catch(error => {
                console.error("Error fetching region:", error);
                isLoading = false; // 오류 발생 시 요청 상태 초기화
            });
    }
</script>
</head>
<body>
    <div class="container">
        <h1 class="emoji">🏖️</h1>
        <h1 style="font-size: 28px;">행운의 여행지</h1>
        <!-- "추첨 중..."과 결과 텍스트를 동일한 위치에 배치 -->
        <div id="loading" class="loading">행운의 여행지 추첨 중...</div> <!-- 추첨 중 문구 -->
        <h2 id="region-text">${region}</h2> <!-- 결과 문구 -->
        <div id="initial-message" class="initial-message">지금 당장 뽑아보세요!</div>
        <div id="extra-info" class="extra-info">여기는 어떤가요? 여행지가 마음에 드시나요?</div>
        <button class="btn" onclick="pickRandomRegion()">
            <span id="btn-text">뽑기</span>
        </button>
    </div>
</body>
</html>
