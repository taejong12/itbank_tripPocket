<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/memberIdList.css">

<div class="member-id-form">
	<h1>아이디 찾기</h1>
	<p class="member-id-text">고객님의 정보와 일치하는 아이디 목록입니다.</p>
	<hr>
	<div class="member-id-wrap">
		<c:forEach var="member" items="${memberList}">
			<div class="member-info-warp">
				<div class="member-id">아이디: ${member.memberId}</div>
				<div class="member-date">가입: ${member.memberAddDate}</div>
			</div>
		</c:forEach>
	</div>
	<div class="member-btn-wrap">
		<button class="login-btn" onclick="fu_loginForm()">로그인하기</button>
		<button class="pwd-btn" onclick="fu_findPwdForm()">비밀번호찾기</button>
	</div>
</div>

<script>
	window.fu_loginForm = function(){
		window.location.href = "${contextPath}/member/loginForm.do";
	}
	
	window.fu_findPwdForm = function(){
		window.location.href = "${contextPath}/member/findPwdForm.do";
	}
</script>