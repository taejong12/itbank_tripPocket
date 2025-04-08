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
    <style>
        .active { background-color: #ccc; }
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

                $('.day-tab-btn').click(function () {
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
                        '<p>📍 ' + day.tripDayAdr + '</p>' +
                        imageTag +
                        '<label>여행 후기</label>' +
                        '<textarea name="tripShareContent" rows="4" data-key="' + key + '" data-day="' + day.tripDayDay + '">' + savedContent + '</textarea>' +
                        '</div>';

                    container.append(html);
                });

                $('textarea[name="tripShareContent"]').on('input', function () {
                    let key = $(this).data('key');
                    reviewMap[key] = $(this).val();
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
<h2>여행 공유 글쓰기</h2>

<form:form modelAttribute="tripShareDTO" method="get" action="${contextPath}/share/write.do">
    <label>여행 계획 선택</label><br />
    <form:select path="tripPlanId">
        <form:option value="" label="-- 선택하세요 --" />
        <c:forEach var="plan" items="${tripPlanList}">
            <form:option value="${plan.tripPlanId}">
                ${plan.tripPlanTitle} (${plan.tripPlanStartDay} ~ ${plan.tripPlanArriveDay})
            </form:option>
        </c:forEach>
    </form:select>
    <br /><br />

    <label>제목</label><br />
    <form:input path="tripShareTitle" /><br /><br />

    <div id="dayTabs" style="margin-top: 30px;"></div>
    <div id="tripDayContainer"></div>

    <br />
    <input type="submit" value="글쓰기" />
</form:form>
</body>
</html>
