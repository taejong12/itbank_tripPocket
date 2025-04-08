<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>${share.tripShareTitle} - 여행 공유</title>
    <style>
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
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .share-meta {
            color: #777;
            font-size: 14px;
            margin-bottom: 30px;
        }

        .trip-day {
            margin-bottom: 40px;
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }

        .trip-day h3 {
            color: #34495e;
        }

        .trip-day p {
            margin: 10px 0;
        }

        .trip-day img {
            max-width: 100%;
            border-radius: 8px;
            margin-top: 10px;
        }

        .review-content {
            background-color: #f6f8fa;
            padding: 15px;
            border-left: 5px solid #4CAF50;
            border-radius: 8px;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>${share.tripShareTitle}</h2>
        <div class="share-meta">
            <strong>작성자:</strong> ${member.memberNickname} |
            <strong>여행 기간:</strong> ${share.tripPlanStartDay} ~ ${share.tripPlanArriveDay}
        </div>

        <!-- 여행 일차를 tripDayDay 기준으로 정렬 -->
        <c:forEach var="day" items="${detailList}">
            <div class="trip-day">
                <h3>Day ${day.tripDayDay} - ${day.tripDayDate}</h3>
                <p>📍 ${day.tripDayAdr}</p>

                <c:if test="${not empty day.tripDayImage}">
                    <img src="${day.tripDayImage}" alt="여행 이미지" />
                </c:if>

                <div class="review-content">
                    ${day.tripShareContent}
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
