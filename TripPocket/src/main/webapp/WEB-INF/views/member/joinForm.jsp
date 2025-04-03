<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${contextPath}/resources/css/member/join.css">
<script src="${contextPath}/resources/script/member/joinForm.js"></script>
</head>
<body>
    <div class="container">
        <p class="form-title">Sign up</p>
        <form name="joinForm" method="post" action="${contextPath}/member/join.do" onsubmit="fn_joinForm(event);">
            <div class="input-container">
                <input type="text" name="memberId" placeholder="아이디를 입력하세요">
                <button id="checkBtn" type="button" name="memberIdCheck" onclick="fn_memberIdCheck()">중복확인</button>
            </div>
            <div class="input-container">
                <input type="password" name="memberPwd" placeholder="비밀번호를 입력하세요">
            </div>
            <div class="input-container">
                <input type="text" name="memberName" placeholder="이름을 입력하세요">
            </div>
            <div class="input-container">
                <input type="email" name="memberEmail" placeholder="이메일을 입력하세요">
            </div>
            <div class="input-container">
                <input type="text" name="memberAge" placeholder="나이를 입력하세요">
            </div>
            <div class="input-container">
                <input type="text" name="memberNickname" placeholder="닉네임을 입력하세요">
            </div>
            <div class="input-container">
                <input type="tel" name="memberTel" placeholder="휴대전화번호를 입력하세요" pattern="\d{10,11}">
            </div>
            <div class="gender-container">
                <label><input type="radio" name="memberGender" value="남자"><span></span> 남자</label>
                <label><input type="radio" name="memberGender" value="여자"><span></span> 여자</label>
            </div>
            <div class="button-container">
                <button type="submit">회원가입</button>
            </div>
        </form>
    </div>
</body>
</html>