<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/list.css">

<div id="trip-destination-list"></div>

<script type="text/javascript">
	let contextPath = "${contextPath}";
	let currentAreaCode = "${areaCode}";
</script>
<script src="${contextPath}/resources/js/tripDestination/list.js"></script>
