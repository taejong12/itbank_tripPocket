<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/login.css">

<div class="container">
	<form class="form" method="post" action="login.do">
		<p class="form-title">Login</p>
		<div class="input-container">
			<input placeholder="ID(아이디 또는 이메일)" type="text" name="memberIdOrEmail">
			<span class="icon">&#128100;</span>
		</div>
		<div class="input-container">
			<input placeholder="비밀번호" type="password" name="memberPwd">
			<span class="icon">&#128274;</span>
		</div>
		<div class="button-container">
			<button class="submit" type="submit">로그인</button>
		</div>
		<p class="signup-link">
			계정이 없으신가요?
			<a href="${contextPath}/member/joinForm.do">회원가입</a>
		</p>
	</form>
</div>
