<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>날짜/지역 정하기</title>
</head>
<body>
	<form name="planDateSet">
		<div>
			제목:<input type="text" name="tripPlanTitle">
		</div>
		<div>		
			설명:<input type="text" name="tripPlanContent">
		</div>
		<div>
			여행출발일:<input type="date" name="tripPlanStartDay">
		</div>
		<div>
			여행도착일:<input type="date" name="tripPlanArriveDay">
		</div>
		<button onclick="fu_planDateSet(event)">선택완료</button>
	</form>
	
	<script type="text/javascript">

		document.addEventListener("DOMContentLoaded", function () {
			
			window.fu_planDateSet = function(event){
				event.preventDefault();
				
				let form = document.planDateSet;
				
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
					form.action="${contextPath}/trip/insertPlanDateSet.do";
					form.submit();
				}
			}
		});
	</script>
</body>
</html>