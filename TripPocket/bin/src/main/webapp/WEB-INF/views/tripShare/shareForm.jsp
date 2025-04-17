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
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/shareForm.css">
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
    <script>
    let globalTripDays = [];
    let reviewMap = {};

    $(document).ready(function () {

        // ✅ 여행 목록 안내 문구 placeholder처럼: 클릭 시 제거
		$('#tripPlanId').change(function () {
		let selectedPlanId = $(this).val();
		
		// 선택 시 안내 문구 제거 (한 번만)
		$(this).find('option[value=""]').remove();
		
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

        // ✅ submit 유효성 검사 + hidden input 생성
        $('#tripShareForm').submit(function (e) {
            const tripPlanId = $('#tripPlanId').val();
            const title = $('input[name="tripShareTitle"]').val().trim();

            if (!tripPlanId || tripPlanId === "") {
                alert('📌 공유할 여행을 선택해주세요!');
                $('#tripPlanId').focus();
                e.preventDefault();
                return false;
            }

            if (title === "") {
                alert('📝 여행 제목을 입력해주세요!');
                $('input[name="tripShareTitle"]').focus();
                e.preventDefault();
                return false;
            }

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

        // ✅ 여행 플랜 선택 시 일차 정보 불러오기
        $('#tripPlanId').change(function () {
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

        // ✅ 일차 탭 렌더링
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

        // ✅ 선택된 일차의 입력 영역 렌더링
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

            selectedDays.forEach(function (day) {
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
                    '<textarea name="tripShareContent" rows="4" data-key="' + key + '" data-day="' + day.tripDayDay + '" placeholder="추억을 여기에 남겨보세요! 다른 사람에게도 큰 도움이 될 거예요 ☺️">' + savedContent + '</textarea>' +
                    '</div>';

                container.append(html);
            });

            // 입력값 저장
            $('textarea[name="tripShareContent"]').on('input', function () {
                let key = $(this).data('key');
                reviewMap[key] = $(this).val();
            });
        };
    });
    </script>
</head>
<body>
<div class="container">
    <h2>나의 여행 글 쓰기</h2>
    <form:form modelAttribute="tripShareDTO" method="post" action="${contextPath}/share/write.do" id="tripShareForm">
        <label>✈️ 공유하고 싶은 나의 여행을 골라주세요</label>
        <form:select path="tripPlanId" id="tripPlanId">
            <form:option value="" disabled="true" selected="true">📌 기억에 남는 여행을 선택해주세요</form:option>
            <form:options items="${tripPlanList}" itemValue="tripPlanId" itemLabel="tripPlanTitle" />
        </form:select>

        <label>📝 여행 이야기에 어울리는 제목을 적어주세요</label>
        <form:input path="tripShareTitle" />

        <div id="dayTabs"></div>
        <div id="tripDayContainer"></div>

        <input type="submit" value="✈️ 나의 여행 블로그 등록하기" />
    </form:form>
</div>
</body>
</html>
