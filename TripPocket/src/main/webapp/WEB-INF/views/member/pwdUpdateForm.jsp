<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/pwdUpdateForm.css">
<script src="${contextPath}/resources/js/common/back/formReset.js"></script>

<form name="pwdUpdateForm">
	<div class="pwd-update-form-wrap">
		<h1>비밀번호 재설정</h1>
		<p class="pwd-update-text">비밀번호를 변경해주세요.</p>
		<p class="pwd-update-text">다른 아이디나 사이트에서 사용한 적 없는 안전한 비밀번호로 변경해 주세요.</p>
		<hr>
		<div class="pwd-update-form-div">
			<input type="hidden" name="memberId" value="${memberId}">
			<div class="id-label">아이디: ${memberId}</div>
			<div class="pwd-input">
				<input type="password" id="memberPwd" name="memberPwd" placeholder="새 비밀번호">
			</div>
			<div class="pwd-check-input">
				<input type="password" id="memberPwdCheck" name="memberPwdCheck" placeholder="새 비밀번호 확인">
			</div>
		</div>
		<div class="pwd-update-button-wrap">
			<button type="button" class="pwd-update-btn" onclick="fu_pwdUpdateBtn(event)">비밀번호 변경</button>
		</div>
	</div>
</form>

<script>
	const contextPath = "${contextPath}";
	const memberId = "${memberId}";

	window.fu_pwdUpdateBtn = function(event){
		
		event.preventDefault();
		
		const pwdUpdateForm = document.pwdUpdateForm;
		
		const memberPwd = pwdUpdateForm.memberPwd.value.trim();
		const memberPwdCheck = pwdUpdateForm.memberPwdCheck.value.trim();
		const specialCharPattern = /[!@#$%^&*(),.?":{}|<>]/;
		
		if(memberPwd == '' || memberPwd == null || memberPwd.length == 0){
			pwdUpdateForm.memberPwd.focus();
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		if (memberPwd === "" || memberPwd.length < 8 || !specialCharPattern.test(memberPwd)) {
		    pwdUpdateForm.memberPwd.focus();
		    alert("비밀번호는 최소 8자 이상, 특수문자(예: !, @, #, $ 등)를 포함해 주세요.");
		    return false;
		}
		
		if(memberPwdCheck == '' || memberPwdCheck == null || memberPwdCheck.length == 0){
			pwdUpdateForm.memberPwdCheck.focus();
			alert("비밀번호 확인을 입력해주세요.");
			return;
		}
		
		if(memberPwd != memberPwdCheck){
			pwdUpdateForm.memberPwd.focus();
			alert("비밀번호가 일치하지 않습니다.");
		    return;
		}
		
		pwdUpdateForm.method= "post";
		pwdUpdateForm.action= contextPath+"/member/pwdUpdate.do";
		pwdUpdateForm.submit();
	}
</script>
