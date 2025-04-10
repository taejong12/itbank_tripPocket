<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${share.tripShareTitle} - 여행 상세</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/myDetail.css">
   
</head>
<body>

<div class="container">
    <h1>${share.tripShareTitle}</h1>
    <div class="meta">
        <strong>작성자:</strong> ${member.memberNickname} <br>
        <strong>여행 기간:</strong> 
        <fmt:formatDate value="${share.tripPlanStartDay}" pattern="yyyy-MM-dd" /> ~ 
        <fmt:formatDate value="${share.tripPlanArriveDay}" pattern="yyyy-MM-dd" />
    </div>

    <!-- Day별 일정 출력 -->
    <c:forEach var="day" items="${detailList}">
        <div class="trip-day">
            <h3>Day ${day.tripDayDay} - ${day.tripDayPlace}</h3>
            <p>${day.tripDayAddress}</p>

            <c:if test="${not empty day.tripDayImage}">
                <img src="${day.tripDayImage}" alt="여행 이미지">
            </c:if>

            <div class="review-content">
                ${day.tripShareContent}
            </div>
        </div>
    </c:forEach>

    <a class="back-link" href="${contextPath}/share/myList.do">← 나의 여행 공유 목록으로</a>
</div>

</body>
</html>
