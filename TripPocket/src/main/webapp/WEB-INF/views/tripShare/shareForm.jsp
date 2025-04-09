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
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />">
    <style>
        /* General Body Styling */
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
        }

        /* Container for the Form */
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #2a8fbd;
            font-size: 28px;
            margin-bottom: 30px;
        }

        label {
            font-size: 16px;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }

        select, input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="text"]:focus, select:focus, textarea:focus {
            border-color: #2a8fbd;
            outline: none;
            box-shadow: 0 0 5px rgba(42, 143, 189, 0.5);
        }

        #dayTabs {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .day-tab-btn {
            background: #f1f1f1;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 10px 15px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .day-tab-btn.active, .day-tab-btn:hover {
            background: #2a8fbd;
            color: white;
            border-color: #2a8fbd;
        }

        .trip-day-card {
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .trip-day-card h3 {
            margin: 0 0 10px;
            font-size: 18px;
            color: #2a8fbd;
        }

        .trip-day-card p {
            font-size: 14px;
            margin: 5px 0;
            color: #666;
        }

        .trip-day-card img {
            max-width: 100%;
            border-radius: 6px;
            margin-top: 10px;
        }

        input[type="submit"] {
            display: block;
            width: 100%;
            background: #2a8fbd;
            color: white;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            border: none;
            border-radius: 8px;
            padding: 12px 20px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        input[type="submit"]:hover {
            background: #176c93;
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 24px;
            }

            .day-tab-btn {
                padding: 8px 12px;
            }

            .trip-day-card h3 {
                font-size: 16px;
            }

            input[type="submit"] {
                font-size: 14px;
            }
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
    <div class="container">
        <h2>여행 공유 글쓰기</h2>
        <form:form modelAttribute="tripShareDTO" method="get" action="${contextPath}/share/write.do">
            <label>여행 계획 선택</label>
            <form:select path="tripPlanId">
                <form:option value="" label="-- 선택하세요 --" />
                <c:forEach var="plan" items="${tripPlanList}">
                    <form:option value="${plan.tripPlanId}">
                        ${plan.tripPlanTitle} (${plan.tripPlanStartDay} ~ ${plan.tripPlanArriveDay})
                    </form:option>
                </c:forEach>
            </form:select>

            <label>제목</label>
            <form:input path="tripShareTitle" />

            <div id="dayTabs"></div>
            <div id="tripDayContainer"></div>

            <input type="submit" value="글쓰기" />
        </form:form>
    </div>
</body>
</html>