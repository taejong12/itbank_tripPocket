<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String contextPath = request.getContextPath();
%>

<html>
<head>
    <title>여행 공유 글쓰기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0 20px;
        }

        .top-section {
            text-align: center;
            padding: 30px 10px;
            background-color: #ffffff;
            border-radius: 16px;
            margin-top: 20px;
        }

        .top-section img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
        }

        .title-main {
            font-size: 28px;
            margin: 15px 0 5px;
        }

        .subtitle {
            font-size: 18px;
            color: #666;
        }

        #dayTabs {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 8px;
        }

        .day-tab-btn {
            padding: 10px 20px;
            border: none;
            background-color: #e0e0e0;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .day-tab-btn.active {
            background-color: #3b82f6;
            color: white;
        }

        #tripDayContainer {
            margin-top: 30px;
        }

        .trip-day-card {
            background-color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .trip-day-card h3 {
            margin-top: 0;
        }

        .trip-day-card img {
            max-width: 100%;
            margin-top: 10px;
            border-radius: 8px;
        }

        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 16px;
            margin-top: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        input[type="submit"] {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2563eb;
        }
    </style>

    <script>
        let globalTripDays = [];

        $(document).ready(function() {
            $('select[name="tripPlanId"]').change(function() {
                let selectedPlanId = $(this).val();

                if (selectedPlanId) {
                    $.ajax({
                        url: '<%= contextPath %>/share/getTripDays.do',
                        type: 'GET',
                        data: { tripPlanId: selectedPlanId },
                        success: function(data) {
                            globalTripDays = data.sort(function(a, b) {
                                return a.tripDayDay - b.tripDayDay;
                            });
                            renderDayTabs(globalTripDays);
                            renderTripDayContent(globalTripDays[0].tripDayDay);
                        },
                        error: function(xhr, status, error) {
                            alert("여행 일차 데이터를 불러오는 중 오류 발생: " + error);
                        }
                    });
                }
            });

            function renderDayTabs(tripDays) {
                let tabs = $('#dayTabs');
                tabs.empty();

                let uniqueDays = [];
                tripDays.forEach(function(day) {
                    if (!uniqueDays.includes(day.tripDayDay)) {
                        uniqueDays.push(day.tripDayDay);
                    }
                });

                uniqueDays.forEach(function(dayNum, index) {
                    let btnClass = (index === 0) ? 'active' : '';
                    let buttonHtml = 
                        '<button type="button" class="day-tab-btn ' + btnClass + '" data-day="' + dayNum + '">' +
                        'Day ' + dayNum +
                        '</button>';
                    tabs.append(buttonHtml);
                });

                $('.day-tab-btn').click(function() {
                    $('.day-tab-btn').removeClass('active');
                    $(this).addClass('active');

                    let day = $(this).data('day');
                    renderTripDayContent(day);
                });
            }

            function renderTripDayContent(selectedDay) {
                let container = $('#tripDayContainer');
                container.empty();

                let selectedDays = globalTripDays.filter(function(day) {
                    return day.tripDayDay == selectedDay;
                });

                if (selectedDays.length === 0) {
                    container.append('<p>해당 일차 정보가 없습니다.</p>');
                    return;
                }

                selectedDays.forEach(function(day) {
                    let imageTag = '';
                    if (day.tripDayImage && day.tripDayImage.trim() !== '') {
                        imageTag = '<img src="' + day.tripDayImage + '" alt="여행 이미지">';
                    }

                    let html = 
                        '<div class="trip-day-card">' +
                            '<h3>Day ' + day.tripDayDay + ' - ' + day.tripDayDate + '</h3>' +
                            '<p>📍 ' + day.tripDayAdr + '</p>' +
                            imageTag +
                        '</div>';
                    container.append(html);
                });
            }
        });
    </script>
</head>
<body>

    <div class="top-section">
        <img src="https://cdn.triple.guide/img/place-default-image.png" alt="여행 대표 이미지">
        <div class="title-main">나고야, 5박 6일</div>
        <div class="subtitle">트리플이 알려준 맞춤일정으로 여행을 떠나보세요.</div>
    </div>

    <div class="form-container">
        <h2>여행 공유 글쓰기</h2>
        <form:form modelAttribute="tripShareDTO" method="post" action="${contextPath}/share/write.do">
            <label>여행 계획 선택</label><br/>
            <form:select path="tripPlanId">
                <form:option value="" label="-- 선택하세요 --"/>
                <c:forEach var="plan" items="${tripPlanList}">
                    <form:option value="${plan.tripPlanId}">
                        ${plan.tripPlanTitle} (${plan.tripPlanStartDay} ~ ${plan.tripPlanArriveDay})
                    </form:option>
                </c:forEach>
            </form:select>
            <br/><br/>

            <label>제목</label><br/>
            <form:input path="tripShareTitle"/><br/><br/>

            <label>내용</label><br/>
            <form:textarea path="tripShareContent" rows="8" cols="80"/><br/><br/>

            <input type="submit" value="글쓰기"/>
        </form:form>
    </div>

    <div id="dayTabs"></div>
    <div id="tripDayContainer"></div>

</body>
</html>
