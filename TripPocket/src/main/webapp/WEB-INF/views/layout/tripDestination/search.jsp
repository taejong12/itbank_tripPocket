<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<div id="trip-destination-search-bar">
	<form action="${contextPath}/tripDestination/searchResult.do" method="get">
		<input type="text" name="keyword" placeholder="검색어를 입력하세요" />
		<button type="submit">검색</button>
	</form>
</div>