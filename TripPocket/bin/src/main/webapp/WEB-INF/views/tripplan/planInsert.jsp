<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<link rel="stylesheet" href="${contextPath}/resources/css/tripPlan/planInsert.css">

<form name="planInsert">
	
	<div class="plan-insert-form">
		<div class="plan-row-box">
			<div class="plan-row">
		        <span class="plan-label">제목</span>
		        <span class="plan-title"><input type="text" name="tripPlanTitle" placeholder="여행 제목을 입력하세요"></span>
		    </div>
		    <div class="plan-row">
		        <span class="plan-label">소개</span>
		        <span class="plan-content">
		            <textarea name="tripPlanContent" rows="5" placeholder="여행 계획에 대한 간단한 소개를 입력하세요"></textarea>
		        </span>
		    </div>
		</div>
		
		<div class="plan-calendar">
			<div class="plan-calendar-header">
				<button type="button" id="prevMonth">&lt;</button>
				<h2 id="monthYear"></h2>
				<button type="button" id="nextMonth">&gt;</button>
			</div>
			<div class="plan-calendar-body">
				<div class="plan-day-names">
					<div>일</div><div>월</div><div>화</div><div>수</div><div>목</div><div>금</div><div>토</div>
				</div>
				<div id="planCalendarDays" class="plan-days"></div>
			</div>
		</div>
		
		<div class="plan-date-form">
			<div class="plan-date-wrapper">
				<div class="plan-date">
					<div class="plan-date-label">출발</div>
					<input type="text" name="tripPlanStartDay" id="startDay" readonly>
				</div>
				<div class="wave">~</div>
				<div class="plan-date">
					<div class="plan-date-label">도착</div>
					<input type="text" name="tripPlanArriveDay" id="arriveDay" readonly>
				</div>
			</div>
		</div>
		
		<button  class="plan-submit-btn" onclick="fu_planInsert(event)">작성완료</button>
	</div>
</form>
	
<script>
    let contextPath = "${contextPath}";
</script>
<script src="${contextPath}/resources/js/tripPlan/planInsert.js"></script>
<script type="text/javascript">
	
	const calendarDays = document.getElementById("planCalendarDays");
	const monthYear = document.getElementById("monthYear");
	const prevMonthBtn = document.getElementById("prevMonth");
	const nextMonthBtn = document.getElementById("nextMonth");
	
	let currentDate = new Date();
	
	let startDate = null;
	let endDate = null;
	
	window.fu_formatDate = function(date){
		const yyyy = date.getFullYear();
		const mm = String(date.getMonth() + 1).padStart(2, '0');
		const dd = String(date.getDate()).padStart(2, '0');
		return yyyy+'-'+mm+'-'+dd;
	}
	
	// 날짜 클릭 시 사용하는 안전한 local date 파서
	function parseLocalDate(dateStr) {
	    const [year, month, day] = dateStr.split('-');
	    return new Date(Number(year), Number(month) - 1, Number(day));
	}
	
	window.fu_planCalendar = function(date){
		calendarDays.innerHTML = "";

		const year = date.getFullYear();
		const month = date.getMonth();

		const firstDay = new Date(year, month, 1);
		const lastDay = new Date(year, month + 1, 0);
		const startDay = firstDay.getDay();
		const totalDays = lastDay.getDate();
		
		// 제목
		monthYear.textContent = year+'년 '+(month + 1) + '월';
		
		// 앞쪽 공백
		for (let i = 0; i < startDay; i++) {
			const emptyDiv = document.createElement("div");
			calendarDays.appendChild(emptyDiv);
		}
		
		// 날짜 표시
		for (let i = 1; i <= totalDays; i++) {
			const day = document.createElement("div");
			day.textContent = i;
			
			const dayDate = new Date(year, month, i);
			const yyyy_mm_dd = fu_formatDate(dayDate);
			day.dataset.date = yyyy_mm_dd;

			const today = new Date();
			today.setHours(0, 0, 0, 0);
			if (dayDate.getTime() === today.getTime()) {
				day.classList.add("today");
			}
			
			// 클릭 이벤트 연결
			day.addEventListener("click", () => {
				dayClick(yyyy_mm_dd);
			});
			
			calendarDays.appendChild(day);
		}
	}
	
	fu_planCalendar(currentDate);
	
	// 월 이동
	prevMonthBtn.addEventListener("click", () => {
		currentDate.setMonth(currentDate.getMonth() - 1);
		fu_planCalendar(currentDate);
	});
	
	nextMonthBtn.addEventListener("click", () => {
		currentDate.setMonth(currentDate.getMonth() + 1);
		fu_planCalendar(currentDate);
	});
	
	window.dayClick = function(dateStr) {
		const clickDate = new parseLocalDate(dateStr);
		const today = new Date();
		today.setHours(0, 0, 0, 0);
		
		if (clickDate < today) {
			alert("오늘 이전 날짜는 선택할 수 없습니다.");
			startDate = null;
			endDate = null;
			fu_updateInputDay();
			fu_selectDates();
			return;
		}
		
		if(!startDate || (startDate && endDate)){
			// 출발일
			startDate = clickDate;
			endDate = null;
		} else {
			// 도착일
			// 출발일보다 늦어야 함
			if(clickDate >= startDate){
				endDate = clickDate;
			} else {
				// 출발일보다 전날 선택하면 출발일로 교체
				startDate = clickDate;
				endDate = null;
			}
		}
		
		fu_updateInputDay();
		fu_selectDates();
	};
	
	window.fu_updateInputDay = function (){
		document.getElementById("startDay").value = startDate ? fu_formatDate(startDate) : '';
		document.getElementById("arriveDay").value = endDate ? fu_formatDate(endDate) : '';
	}
	
	window.fu_selectDates = function(){
		const days = document.querySelectorAll('.plan-days div');
		days.forEach(day => {
			day.classList.remove('select-start', 'select-end', 'select-between');
			
			const dateStr = day.dataset.date;
			// 공백칸 대비
			if (!dateStr) return;
			
			const date = parseLocalDate(dateStr);
			
			if (startDate && fu_formatDate(date) === fu_formatDate(startDate)) {
				day.classList.add('select-start');
			}
			if (endDate && fu_formatDate(date) === fu_formatDate(endDate)) {
				day.classList.add('select-end');
			}
			if (startDate && endDate && date > startDate && date < endDate) {
				day.classList.add('select-between');
			}
		});
	}
	
</script>
