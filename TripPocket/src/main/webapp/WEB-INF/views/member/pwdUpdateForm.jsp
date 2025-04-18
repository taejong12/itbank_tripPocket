<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="${contextPath}/resources/js/common/back/formReset.js"></script>

<h1>비밀번호 재설정</h1>
<p>비밀번호를 변경해주세요.</p>
<p>다른 아이디나 사이트에서 사용한 적 없는 안전한 비밀번호로 변경해 주세요.</p>
<hr>
<div>
	<div>아이디: 값</div>
	<input type="text" name="memberPwd" placeholder="새 비밀번호">
	<input type="text" name="memberPwdCheck" placeholder="새 비밀번호 확인">
</div>