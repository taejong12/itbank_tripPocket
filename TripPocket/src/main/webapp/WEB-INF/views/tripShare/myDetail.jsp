<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${share.tripShareTitle} - 여행 상세</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/myDetail.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0013492b2b76abad18e946130e719814&libraries=services"></script>

    <style>
        .map {
            width: 100%;
            height: 350px;
            margin: 20px 0;
            border-radius: 10px;
            background-color: #eee;
        }
        .day-tab {
            margin: 10px 0;
        }
        .day-tab button {
            padding: 8px 16px;
            margin-right: 5px;
            border: none;
            border-radius: 5px;
            background-color: #ddd;
            cursor: pointer;
        }
        .day-tab button.active {
            background-color: #4CAF50;
            color: white;
        }
        .trip-day {
            display: none;
        }
        .trip-day.active {
            display: block;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>${share.tripShareTitle}</h1>
    <div class="meta">
        <strong>작성자:</strong> ${share.memberId} <br>
        <strong>여행 기간:</strong> 
        <fmt:formatDate value="${share.tripPlanStartDay}" pattern="yyyy-MM-dd" /> ~ 
        <fmt:formatDate value="${share.tripPlanArriveDay}" pattern="yyyy-MM-dd" />
    </div>

    <!-- Day 버튼 -->
    <div class="day-tab" id="dayTabs">
        <c:set var="prevDay" value="0" />
        <c:forEach var="day" items="${detailList}">
            <c:if test="${day.tripShareDayDay != prevDay}">
                <button class="day-tab-btn" onclick="showDay(${day.tripShareDayDay}, this)">Day ${day.tripShareDayDay}</button>
                <c:set var="prevDay" value="${day.tripShareDayDay}" />
            </c:if>
        </c:forEach>
    </div>

    <!-- Day별 일정 -->
    <c:forEach var="i" begin="1" end="10">
        <c:set var="hasContent" value="false" />
        <c:forEach var="day" items="${detailList}">
            <c:if test="${day.tripShareDayDay == i}">
                <c:set var="hasContent" value="true" />
            </c:if>
        </c:forEach>
        <c:if test="${hasContent}">
            <div class="trip-day" id="trip-day-${i}">
                <div id="map-${i}" class="map"></div>
                <c:forEach var="day" items="${detailList}">
                    <c:if test="${day.tripShareDayDay == i}">
                        <h3>Day ${day.tripShareDayDay} - ${day.tripShareDayPlace}</h3>
                        <p>${day.tripShareDayAddress}</p>
                        <c:if test="${not empty day.tripShareDayImage}">
                            <img src="${day.tripShareDayImage}" alt="여행 이미지" />
                        </c:if>
                        <div class="review-content">${day.tripShareContent}</div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>
    </c:forEach>

    <a class="back-link" href="${contextPath}/share/myShare.do">← 나의 여행 공유 목록으로</a>
</div>

<script>
    const groupedDays = {};
    const tempList = [];
    <c:forEach var="day" items="${detailList}">
        tempList.push({
            d: ${day.tripShareDayDay},
            x: "${day.tripShareDayMapx}",
            y: "${day.tripShareDayMapy}",
            place: "${fn:escapeXml(day.tripShareDayPlace)}"
        });
    </c:forEach>

    tempList.forEach(d => {
        if (!groupedDays[d.d]) groupedDays[d.d] = [];
        groupedDays[d.d].push({ x: d.x, y: d.y, place: d.place });
    });

    function showDay(dayNum, btn) {
        document.querySelectorAll(".trip-day").forEach(d => d.classList.remove("active"));
        document.getElementById("trip-day-" + dayNum).classList.add("active");

        document.querySelectorAll(".day-tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");

        setTimeout(() => loadMap(dayNum), 10);
    }

    function loadMap(dayNum) {
        const mapContainer = document.getElementById("map-" + dayNum);
        if (!mapContainer) return;
        mapContainer.innerHTML = "";

        const points = groupedDays[dayNum];
        if (!points || points.length === 0) return;

        const bounds = new kakao.maps.LatLngBounds();
        const path = [];

        const map = new kakao.maps.Map(mapContainer, {
            center: new kakao.maps.LatLng(points[0].y, points[0].x),
            level: 6
        });

        points.forEach((p, idx) => {
            const latlng = new kakao.maps.LatLng(p.y, p.x);
            bounds.extend(latlng);
            path.push(latlng);

            const marker = new kakao.maps.Marker({
                position: latlng,
                map: map
            });

            const info = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;font-size:14px;">' + (idx + 1) + '. ' + p.place + '</div>'
            });
            info.open(map, marker);
        });

        if (path.length > 1) {
            const line = new kakao.maps.Polyline({
                path: path,
                strokeWeight: 3,
                strokeColor: '#007BFF',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                map: map
            });
        }

        map.setBounds(bounds);
    }

    window.onload = function () {
        const firstBtn = document.querySelector(".day-tab-btn");
        if (firstBtn) firstBtn.click();
    };
</script>

</body>
</html>
