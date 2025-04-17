<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<head>
<title>${share.tripShareTitle}- 여행 공유</title>
 <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/shareDetail.css">
<script>
        // JavaScript: 가져오기 버튼 클릭 처리
        function handleFetchClick(tripShareId, tripPlanId) {
    alert("여행 정보를 불러옵니다");
    const contextPath = '${contextPath}';
    const url = contextPath + '/share/shareImport.do'
        + '?tripShareId=' + encodeURIComponent(tripShareId)
        + '&tripPlanId=' + encodeURIComponent(tripPlanId);

    location.href = url;
	}
    </script>
</head>
<body>
	<div class="container">
		<h2>${share.tripShareTitle}</h2>
		<div class="share-meta">
			<strong>작성자:</strong> ${share.memberNickname}님 | <strong>여행
				기간:</strong> <fmt:formatDate value="${share.tripPlanStartDay}" pattern="yyyy-MM-dd" />~<fmt:formatDate value="${share.tripPlanArriveDay}" pattern="yyyy-MM-dd" />
		</div>

		<!-- 여행 일차를 tripDayDay 기준으로 정렬 -->
		<c:forEach var="day" items="${detailList}">
			<div class="trip-day">
				<h3>Day ${day.tripDayDay}</h3>
				<p>${day.tripDayAddress}</p>

				<c:if test="${not empty day.tripDayImage}">
					<img src="${day.tripDayImage}" alt="여행 이미지" />
				</c:if>

				<div class="review-content">${day.tripShareContent}</div>
			</div>
		</c:forEach>

		<!-- 가져오기 버튼 -->
		<div class="fetch-button-container">
			<button class="fetch-button"
				onclick="handleFetchClick(${share.tripShareId}, ${share.tripPlanId})">
				➕ 내 여행에 추가하기</button>
		</div>
	</div>
</body>
</html>