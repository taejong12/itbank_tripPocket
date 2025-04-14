<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%
    String contextPath = request.getContextPath();
%>

<html>
<head>
    <title>경험 공유 글쓰기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0013492b2b76abad18e946130e719814&libraries=services"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/shareForm.css">
    <style>
        #map {
            width: 100%;
            height: 400px;
            margin: 20px 0;
            border-radius: 10px;
        }
    </style>

    <script>
        let globalTripDays = [];
        let reviewMap = {};

        $(document).ready(function () {
            $('select[name="tripPlanId"]').change(function () {
                let selectedPlanId = $(this).val();

                if (selectedPlanId) {
                    $.ajax({
                        url: '<%= contextPath %>/share/getTripDays.do',
                        type: 'GET',
                        data: { tripPlanId: selectedPlanId },
                        success: function (data) {
                            globalTripDays = data.sort((a, b) => a.tripDayDay - b.tripDayDay);
                            renderDayTabs(globalTripDays);
                            renderTripDayContent(globalTripDays[0].tripDayDay);
                        },
                        error: function (xhr, status, error) {
                            alert("여행 일차 데이터를 불러오는 중 오류 발생: " + error);
                        }
                    });
                }
            });

            function renderDayTabs(tripDays) {
                let tabs = $('#dayTabs');
                tabs.empty();

                let uniqueDays = [];
                tripDays.forEach(function (day) {
                    if (!uniqueDays.includes(day.tripDayDay)) {
                        uniqueDays.push(day.tripDayDay);
                    }
                });

                uniqueDays.forEach(function (dayNum, index) {
                    let btnClass = (index === 0) ? 'active' : '';
                    let buttonHtml =
                        '<button type="button" class="day-tab-btn ' + btnClass + '" data-day="' + dayNum + '">' +
                        'Day ' + dayNum +
                        '</button>';
                    tabs.append(buttonHtml);
                });

                $('.day-tab-btn').off('click').on('click', function () {
                    $('.day-tab-btn').removeClass('active');
                    $(this).addClass('active');

                    let day = $(this).data('day');
                    renderTripDayContent(day);
                });
            }

            window.renderTripDayContent = function (selectedDay) {
                let container = $('#tripDayContainer');
                container.empty();

                let selectedDays = globalTripDays.filter(function (day) {
                    return day.tripDayDay == selectedDay;
                });

                if (selectedDays.length === 0) {
                    container.append('<p>해당 일차 정보가 없습니다.</p>');
                    return;
                }

                selectedDays.forEach(function (day, index) {
                    let key = day.tripDayId;
                    let savedContent = reviewMap[key] || '';
                    let imageTag = '';

                    if (day.tripDayImage && day.tripDayImage.trim() !== '') {
                        imageTag = '<img src="' + day.tripDayImage + '" alt="여행 이미지">';
                    }

                    let html =
                        '<div class="trip-day-card">' +
                        '<h3>Day ' + day.tripDayDay + ' - ' + day.tripDayDate + '</h3>' +
                        '<p>📍 ' + day.tripDayAddress + '</p>' +
                        imageTag +
                        '<textarea name="tripShareContent" rows="4" data-key="' + key + '" data-day="' + day.tripDayDay + '"placeholder="추억을 여기에 남겨보세요! 다른 사람에게도 큰 도움이 될 거예요 ☺️">' + savedContent + '</textarea>' +
                        '</div>';

                    container.append(html);
                });

                $('textarea[name="tripShareContent"]').on('input', function () {
                    let key = $(this).data('key');
                    reviewMap[key] = $(this).val();
                });

                renderMap(selectedDays);
            }

            function renderMap(dayPlaces) {
                $('#map').remove(); // 기존 지도 제거
                $('#tripDayContainer').before('<div id="map"></div>'); // 🟢 지도 위치를 위로 이동

                let mapContainer = document.getElementById('map');
                let mapOption = {
                    center: new kakao.maps.LatLng(36.5, 127.5),
                    level: 8
                };
                let map = new kakao.maps.Map(mapContainer, mapOption);
                let bounds = new kakao.maps.LatLngBounds();
                let linePath = [];

                let geocoder = new kakao.maps.services.Geocoder();

                dayPlaces.forEach(function (place, index) {
                    if (place.tripDayMapx && place.tripDayMapy) {
                        let latlng = new kakao.maps.LatLng(place.tripDayMapy, place.tripDayMapx);
                        bounds.extend(latlng);
                        linePath.push(latlng);

                        let marker = new kakao.maps.Marker({ map: map, position: latlng });
                        let infowindow = new kakao.maps.InfoWindow({
                            content: '<div style="padding:5px;font-size:14px;">' + (index + 1) + '. ' + place.tripDayAddress + '</div>'
                        });
                        infowindow.open(map, marker);

                        if (linePath.length === dayPlaces.length) {
                            let polyline = new kakao.maps.Polyline({
                                map: map,
                                path: linePath,
                                strokeWeight: 3,
                                strokeColor: '#007BFF',
                                strokeOpacity: 0.8,
                                strokeStyle: 'solid'
                            });
                            map.setBounds(bounds);
                        }
                    } else {
                        geocoder.addressSearch(place.tripDayAddress, function (result, status) {
                            if (status === kakao.maps.services.Status.OK) {
                                let latlng = new kakao.maps.LatLng(result[0].y, result[0].x);
                                bounds.extend(latlng);
                                linePath.push(latlng);

                                let marker = new kakao.maps.Marker({ map: map, position: latlng });
                                let infowindow = new kakao.maps.InfoWindow({
                                    content: '<div style="padding:5px;font-size:14px;">' + (index + 1) + '. ' + place.tripDayAddress + '</div>'
                                });
                                infowindow.open(map, marker);

                                if (linePath.length === dayPlaces.length) {
                                    let polyline = new kakao.maps.Polyline({
                                        map: map,
                                        path: linePath,
                                        strokeWeight: 3,
                                        strokeColor: '#007BFF',
                                        strokeOpacity: 0.8,
                                        strokeStyle: 'solid'
                                    });
                                    map.setBounds(bounds);
                                }
                            } else {
                                console.warn("❌ 주소 검색 실패:", place.tripDayAddress);
                            }
                        });
                    }
                });
            }

            $('form').submit(function (e) {
                $('.generated-hidden').remove();

                let form = $(this);
                let index = 0;

                for (let key in reviewMap) {
                    let content = reviewMap[key];
                    if (content.trim() !== '') {
                        let matchedDay = globalTripDays.find(day => day.tripDayId === key);
                        let dayDay = matchedDay ? matchedDay.tripDayDay : '';

                        form.append('<input type="hidden" class="generated-hidden" name="tripDayList[' + index + '].tripDayId" value="' + key + '">');
                        form.append('<input type="hidden" class="generated-hidden" name="tripDayList[' + index + '].tripDayDay" value="' + dayDay + '">');
                        form.append('<input type="hidden" class="generated-hidden" name="tripDayList[' + index + '].tripShareContent" value="' + $('<div>').text(content).html() + '">');
                        index++;
                    }
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <h2>나의 여행 글 쓰기</h2>
    <form:form modelAttribute="tripShareDTO" method="get" action="${contextPath}/share/write.do">
        <label>✈️ 공유하고 싶은 나의 여행을 골라주세요</label>
        <form:select path="tripPlanId">
            <form:option value="" label="📌 기억에 남는 여행을 선택해주세요" />
            <c:forEach var="plan" items="${tripPlanList}">
                <form:option value="${plan.tripPlanId}">${plan.tripPlanTitle}</form:option>
            </c:forEach>
        </form:select>

        <label>제목</label>
        <form:input path="tripShareTitle" />

        <div id="dayTabs"></div>
        <div id="tripDayContainer"></div>

        <input type="submit" value="✈️ 나의 여행 블로그 등록하기" />
    </form:form>
</div>
</body>
</html>