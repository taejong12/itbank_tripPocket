	<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container">
    <h1>${share.tripShareTitle}</h1>
    <div class="meta">
        <strong>작성자:</strong> ${share.memberId} <br>
        <strong>여행 기간:</strong>
        <fmt:formatDate value="${share.tripPlanStartDay}" pattern="yyyy-MM-dd" /> ~
        <fmt:formatDate value="${share.tripPlanArriveDay}" pattern="yyyy-MM-dd" />
    </div>

    <div class="day-tab" id="dayTabs">
        <c:set var="days" value=""/>
        <c:forEach var="day" items="${detailList}">
            <c:if test="${not fn:contains(days, day.tripDayDay)}">
                <button class="day-tab-btn" onclick="showDay(${day.tripDayDay}, this)">Day ${day.tripDayDay}</button>
                <c:set var="days" value="${days}${day.tripDayDay},"/>
            </c:if>
        </c:forEach>
    </div>

    <c:forEach var="i" begin="1" end="10">
        <c:set var="hasContent" value="false" />
        <c:forEach var="day" items="${detailList}">
            <c:if test="${day.tripDayDay == i}">
                <c:set var="hasContent" value="true" />
            </c:if>
        </c:forEach>

        <c:if test="${hasContent}">
            <div class="trip-day" id="trip-day-${i}">
                <div id="map-${i}" class="map"></div>
                <c:forEach var="day" items="${detailList}">
                    <c:if test="${day.tripDayDay == i}">
                        <h3>Day ${day.tripDayDay} - ${day.tripDayPlace}</h3>
                        <p>${day.tripDayAddress}</p>
                        <c:if test="${not empty day.tripDayImage}">
                            <img src="${day.tripDayImage}" alt="여행 이미지" />
                        </c:if>
                        <div class="review-content">${day.tripShareContent}</div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>
    </c:forEach>

    <a class="back-link" href="${contextPath}/share/shareList.do">← 전체 여행 목록으로</a>
</div>
	<a class="" href="${contextPath}/share/shareImport.do?tripShareId=${share.tripShareId}&tripPlanId=${share.tripPlanId}">불러오기</a>
<script>
    const groupedDays = {};
    const tempList = [];
    <c:forEach var="day" items="${detailList}" varStatus="status">
    tempList.push({
        d: ${day.tripDayDay},
        x: "${day.tripDayMapx}",
        y: "${day.tripDayMapy}",
        place: "${fn:escapeXml(day.tripDayPlace)}"
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
