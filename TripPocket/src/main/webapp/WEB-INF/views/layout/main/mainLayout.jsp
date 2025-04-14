<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:type" content="website">
<meta property="og:title" content="Trip Pocket">
<meta property="og:description" content="나만의 여행 계획">
<meta property="og:image" content="https://trippocket.duckdns.org/resources/img/logo/alt_image.png">
<meta property="og:url" content="https://trippocket.duckdns.org/">
<title><tiles:insertAttribute name="title" /></title>
<link rel="stylesheet" href="${contextPath}/resources/css/main/mainLayout.css">
<script src="${contextPath}/resources/js/layout/layout.js"></script>
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" /> 
		</div>
		<div id="content">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>