<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>${share.tripShareTitle}- 여행 공유</title>
<style>
/* General Body Styling */
body {
	font-family: 'Roboto', sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
	color: #333;
}

.container {
	max-width: 800px;
	margin: 30px auto;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

h2 {
	color: #2a8fbd;
	margin-bottom: 10px;
	font-size: 28px;
	font-weight: bold;
}

.share-meta {
	color: #777;
	font-size: 14px;
	margin-bottom: 30px;
}

.trip-day {
	padding: 20px;
	border-radius: 8px;
	background: #f6f8fa;
	margin-bottom: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.trip-day h3 {
	font-size: 18px;
	color: #34495e;
	margin-bottom: 10px;
}

.trip-day p {
	font-size: 14px;
	margin: 10px 0;
	color: #666;
}

.trip-day img {
	max-width: 100%;
	border-radius: 8px;
	margin-top: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.review-content {
	margin-top: 15px;
	background-color: #ffffff;
	padding: 15px;
	border-left: 5px solid #2a8fbd;
	border-radius: 8px;
	font-size: 14px;
	color: #333;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	word-wrap: break-word;
	overflow-wrap: break-word;
	min-height: 60px;
	max-height: 80px;
}

/* 스타일 추가: 가져오기 버튼 */
.fetch-button {
	display: inline-block;
	padding: 10px 20px;
	font-size: 16px;
	color: #fff;
	background-color: #2a8fbd;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

.fetch-button:hover {
	background-color: #1f6f99;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

/* 오른쪽 정렬을 위한 컨테이너 스타일 */
.fetch-button-container {
	text-align: right; /* 버튼을 오른쪽으로 정렬 */
	margin-top: 20px;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.container {
		padding: 20px;
	}
	h2 {
		font-size: 24px;
	}
	.trip-day h3 {
		font-size: 16px;
	}
	.trip-day p {
		font-size: 12px;
	}
	.review-content {
		font-size: 12px;
		padding: 12px;
		min-height: 50px;
		max-height: 70px;
	}
	.fetch-button {
		font-size: 14px;
		padding: 8px 16px;
	}
}
</style>
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
			<strong>작성자:</strong> ${member.memberNickname} | <strong>여행
				기간:</strong> ${share.tripPlanStartDay} ~ ${share.tripPlanArriveDay}
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
				가져오기</button>
		</div>
	</div>
</body>
</html>