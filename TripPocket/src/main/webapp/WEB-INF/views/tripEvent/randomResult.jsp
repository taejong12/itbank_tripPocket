<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>랜덤 여행지</title>
<link rel="stylesheet" href="${contextPath}/resources/css/tripEvent/randomResult.css">
<script>
    const contextPath = "${contextPath}";
</script>
<script src="${contextPath}/resources/js/tripEvent/randomResult.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="emoji">🏖️</h1>
        <h1 id="title-text" style="font-size: 28px;">행운의 여행지</h1>
        <!-- "추첨 중..."과 결과 텍스트를 동일한 위치에 배치 -->
        <div id="loading" class="loading">행운의 여행지 추첨 중...</div> <!-- 추첨 중 문구 -->
        <h2 id="region-text">
            <a id="region-link" href="#" class="link-to-region" style="display:none;"></a> <!-- 링크는 초기엔 숨김 -->
        </h2>
        <div id="initial-message" class="initial-message">지금 당장 뽑아보세요!</div>
        <div id="extra-info" class="extra-info">
        	여기는 어떤가요? 여행지가 마음에 드시나요?<br>
        	해당 지역을 눌러 관광명소를 구경해보세요!
        </div>
        <button class="btn" onclick="pickRandomRegion()">
            <span id="btn-text">뽑기</span>
        </button>
    </div>
</body>
</html>
