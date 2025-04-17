<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<style>

</style>

<form name="findPwdForm">
	<div>
		<h1>비밀번호 찾기</h1>
		<p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
		<hr>
		<div>
			<div class="find-pwd-form">
				<div class="find-pwd-name-wrap">
					<div class="id-label">아이디</div>
					<div>
						<input type="text" id="memberId" name="memberId" placeholder="아이디 입력">
					</div>
				</div>
				<div class="find-id-email-wrap">
					<div class="email-label">이메일</div>
					<div class="send-mail-wrap">
						<input type="email" id="memberEmail" name="memberEmail" placeholder="이메일 입력">
						<button type="button" class="send-mail-btn" onclick="fu_findPwdSendMail(this)">인증전송</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>