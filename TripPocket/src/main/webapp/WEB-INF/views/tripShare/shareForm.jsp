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
	        /* Import Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

/* Base Styles */
body {
    font-family: 'Roboto', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
    color: #333;
}

.container {
    max-width: 800px;
    margin: 30px auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    color: #2c3e50;
}

label {
    font-weight: 500;
    margin-bottom: 10px;
    display: block;
    color: #34495e;
}

input[type="submit"] {
    background-color: #3498db;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 700;
    transition: background-color 0.3s;
}

input[type="submit"]:hover {
    background-color: #2980b9;
}

form select, form input, form textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 16px;
}

form select:focus, form input:focus, form textarea:focus {
    outline: none;
    border-color: #3498db;
}

.day-tab-btn {
    margin: 5px;
    padding: 8px 16px;
    border: 1px solid #ccc;
    background-color: #f0f0f0;
    cursor: pointer;
    border-radius: 6px;
    transition: background-color 0.3s;
}

.day-tab-btn:hover {
    background-color: #e0e0e0;
}

.day-tab-btn.active {
    background-color: #4CAF50;
    color: white;
}

#tripDayContainer {
    margin-top: 20px;
    border: 1px solid #ddd;
    padding: 15px;
    border-radius: 10px;
    background-color: #fff;
}

.trip-day-card {
    margin-bottom: 30px;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 12px;
    background-color: #fdfdfd;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

.trip-day-card img {
    max-width: 100%;
    height: auto;
    margin-top: 10px;
    border-radius: 8px;
}

.trip-day-card label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
}

.trip-day-card textarea {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border-radius: 10px;
    border: 1px solid #bbb;
    resize: vertical;
    font-size: 14px;
    box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
    transition: border-color 0.3s;
}

.trip-day-card textarea:focus {
    outline: none;
    border-color: #4CAF50;
}
	    </style>
	
	    <script>
	        let globalTripDays = [];
	
	        $(document).ready(function () {
	            $('select[name="tripPlanId"]').change(function () {
	                let selectedPlanId = $(this).val();
	
	                if (selectedPlanId) {
	                    $.ajax({
	                        url: '<%= contextPath %>/share/getTripDays.do',
	                        type: 'GET',
	                        data: { tripPlanId: selectedPlanId },
	                        success: function (data) {
	                            globalTripDays = data.sort(function (a, b) {
	                                return a.tripDayDay - b.tripDayDay;
	                            });
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
	
	            function renderTripDayContent(selectedDay) {
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
	                    let imageTag = '';
	                    if (day.tripDayImage && day.tripDayImage.trim() !== '') {
	                        imageTag = '<img src="' + day.tripDayImage + '" alt="여행 이미지">';
	                    }
	
	                    let html =
	                        '<div class="trip-day-card">' +
	                            '<h3>Day ' + day.tripDayDay + ' - ' + day.tripDayDate + '</h3>' +
	                            '<p>📍 ' + day.tripDayAdr + '</p>' +
	                            imageTag +
	                            '<label for="review-' + day.tripDayDay + '-' + index + '">여행 후기</label>' +
	                            '<textarea name="tripReviews[' + day.tripDayDay + '][' + index + ']" rows="4" ' +
	                            'placeholder="이 장소는 어땠나요? 느낀 점을 자유롭게 작성해보세요."></textarea>' +
	                        '</div>';
	                    container.append(html);
	                });
	            }
	        });
	    </script>
	</head>
	<body>
	    <h2>여행 공유 글쓰기</h2>
	
	    <!-- 여행 공유 form -->
	    <form:form modelAttribute="tripShareDTO" method="post" action="${contextPath}/share/write.do">
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
	
	        <!-- Day 버튼 영역 -->
	        <div id="dayTabs" style="margin-top: 30px;"></div>
	
	        <!-- 일정 출력 + 후기 입력란 -->
	        <div id="tripDayContainer"></div>
	
	        <br/>
	        <input type="submit" value="글쓰기" />
	    </form:form>
	</body>
	</html>
