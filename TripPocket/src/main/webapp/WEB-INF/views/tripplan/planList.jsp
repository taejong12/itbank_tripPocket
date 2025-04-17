<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 

<link rel="stylesheet" href="${contextPath}/resources/css/tripPlan/planList.css">

<div class="plan-list-container">
	<h2>내 여행 목록</h2>

	<c:forEach var="tripPlan" items="${tripPlanList}">
	    <div id="tripPlan_${tripPlan.tripPlanId}" class="plan-box-wrapper">
		    <a href="${contextPath}/trip/planDetail.do?tripPlanId=${tripPlan.tripPlanId}" class="plan-box">
		        <div class="plan-row">
		            <span class="plan-label">기간</span>
		            <span class="plan-period">${tripPlan.tripPlanStartDay} ~ ${tripPlan.tripPlanArriveDay}</span>
		        </div>
		        <div class="plan-row">
		            <span class="plan-label">제목</span>
		            <span class="plan-title">${tripPlan.tripPlanTitle}</span>
		        </div>
		    </a>
		    <button class="delete-btn" onclick="fu_deleteTripPlan('${tripPlan.tripPlanId}')">삭제</button>
		</div>
	</c:forEach>

	<a class="add-plan" href="${contextPath}/trip/planInsertForm.do">내 여행 추가</a>
</div>

<script type="text/javascript">
	let contextPath = '${contextPath}';
</script>
<script src="${contextPath}/resources/js/tripPlan/planList.js"></script>
