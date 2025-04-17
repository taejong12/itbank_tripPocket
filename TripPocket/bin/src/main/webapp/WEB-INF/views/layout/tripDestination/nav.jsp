<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<nav>
	<ul>
		<li>
			<a href="${contextPath}/tripDestination/list.do">전체</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=1">서울</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=2">인천</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=3">대전</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=4">대구</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=5">광주</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=6">부산</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=7">울산</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=8">세종</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=31">경기</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=32">강원</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=33">충북</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=34">충남</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=35">경북</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=36">경남</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=37">전북</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=38">전남</a>
		</li>
		<li>
			<a href="${contextPath}/tripDestination/list.do?areaCode=39">제주</a>
		</li>
	</ul>
</nav>

