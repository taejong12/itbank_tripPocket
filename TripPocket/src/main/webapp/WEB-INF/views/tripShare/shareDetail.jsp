<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
    <title>${share.tripShareTitle} - 여행 공유</title>
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
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
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
            padding: 15px; /* 패딩을 적당히 줄임 */
            border-left: 5px solid #2a8fbd; /* 왼쪽 강조선 유지 */
            border-radius: 8px;
            font-size: 14px;
            color: #333;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            word-wrap: break-word; /* 긴 단어 줄바꿈 */
            overflow-wrap: break-word; /* 긴 단어 줄바꿈 */
            min-height: 60px; /* 최소 높이를 현재 크기의 절반으로 설정 */
            max-height: 80px; /* 텍스트 박스의 최대 높이 제한 */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
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
                padding: 12px; /* 모바일용 패딩 조정 */
                min-height: 50px; /* 모바일용 최소 높이 */
                max-height: 70px; /* 모바일용 최대 높이 */
            }
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
                <h3>Day ${day.tripDayDay}</h3>
                <p>${day.tripDayAddress}</p>

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