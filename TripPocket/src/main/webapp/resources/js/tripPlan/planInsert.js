document.addEventListener("DOMContentLoaded", function () {
			
	window.fu_planInsert = function(event){
		event.preventDefault();
		
		let form = document.planInsert;
		
		let title = form.tripPlanTitle.value;
		let content = form.tripPlanContent.value;
		let startDay = form.tripPlanStartDay.value;
		let arriveDay = form.tripPlanArriveDay.value;
		
		if(title == "" || title.length == 0) {
			alert("제목이 입력되지 않았습니다.");
			form.tripPlanTitle.focus();
		} else if (content == "" || content.length == 0) {
			alert("설명이 입력되지 않았습니다.");
			form.tripPlanContent.focus();
		} else if (startDay == "" || startDay.length == 0) {
			alert("출발일이 입력되지 않았습니다.");
			form.tripPlanStartDay.focus();
		} else if (arriveDay == "" || arriveDay.length == 0) {
			alert("도착일이 입력되지 않았습니다.");
			form.tripPlanArriveDay.focus();
		} else {
			alert("여행 계획 등록 완료");
			form.method="post";
			form.action= contextPath+"/plan/insertPlan.do";
			form.submit();
		}
	}
});