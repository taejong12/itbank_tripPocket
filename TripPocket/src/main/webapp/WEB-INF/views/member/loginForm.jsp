<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/login.css">
<script src="${contextPath}/resources/js/common/back/formReset.js"></script>

<div class="container">
	<form class="form" method="post" action="memberLoginCheck.do">
		<p class="form-title">Login</p>
		<div class="input-container">
			<input placeholder="아이디" type="text" name="memberId">
			<span class="icon">&#128100;</span>
		</div>
		<div class="input-container">
			<input placeholder="비밀번호" type="password" name="memberPwd">
			<span class="icon">&#128274;</span>
		</div>
		<div class="button-container">
			<button class="submit" type="submit">로그인</button>
		</div>
		<div class="signup-link">
			<a href="${contextPath}/member/joinForm.do">회원가입</a>
			<span>|</span>
			<a href="${contextPath}/member/findIdForm.do">아이디 찾기</a>
			<span>|</span>
			<a href="${contextPath}/member/findPwdForm.do">비밀번호 찾기</a>
		</div>
	</form>
</div>

<script>
	let loginFail = "${loginFail}";
	
	// 아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.
	if(loginFail == "fail"){
		
	}
</script>