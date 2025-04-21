<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/pwdUpdateComplete.css">
<script src="${contextPath}/resources/js/common/back/formReset.js"></script>

<c:if test="${updateCheck == 'true'}">
	<div class="pwd-update-complete-form">
		<h1>비밀번호 변경완료</h1>
		<hr>
		<div class="pwd-update-complete-text-wrap">
			<p class="pwd-update-complete-text">고객님의 비밀번호가 성공적으로 변경되었습니다.</p>
			<p class="pwd-update-complete-text">보안을 위해 변경된 비밀번호로 다시 로그인해 주세요.</p>
		</div>
		<div class="login-btn-wrap">
			<button class="login-btn" onclick="fu_loginForm()">로그인하기</button>
		</div>
	</div>
</c:if>

<c:if test="${updateCheck != 'true'}">
	<div class="pwd-update-complete-form">
		<h1>비밀번호 변경실패</h1>
		<hr>
		<div class="pwd-update-complete-text-wrap">
			<p class="pwd-update-complete-text">고객님의 비밀번호 변경이 실패했습니다.</p>
			<p class="pwd-update-complete-text">보안을 위해 다시 인증해주세요.</p>
		</div>
		<div class="login-btn-wrap">
			<button class="login-btn" onclick="fu_loginForm()">로그인하기</button>
			<button class="pwd-btn" onclick="fu_findPwdForm()">비밀번호찾기</button>
		</div>
	</div>
</c:if>

<script>
	window.fu_loginForm = function(){
		window.location.href = "${contextPath}/member/loginForm.do";
	}
	
	window.fu_findPwdForm = function(){
		window.location.href = "${contextPath}/member/findPwdForm.do";
	}
</script>