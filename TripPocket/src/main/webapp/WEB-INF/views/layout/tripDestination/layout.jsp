<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title"/></title>
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/layout.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/header.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/nav.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/footer.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/tripDestination/list.css">
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" /> 
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
</html>