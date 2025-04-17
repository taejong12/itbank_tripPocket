<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title"/></title>
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/layout/layout.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/layout/header.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/layout/search.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/layout/nav.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/layout/footer.css">
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" /> 
		</div>
		<div id="search">
			<tiles:insertAttribute name="search" /> 
		</div>
		<div id="nav">
			<tiles:insertAttribute name="nav"/> 
		</div>
		<div id="content">
			<tiles:insertAttribute name="body"/>
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer"/>
		</div>
	</div>
</body>
<script src="${contextPath}/resources/js/layout/layout.js"></script>
</html>