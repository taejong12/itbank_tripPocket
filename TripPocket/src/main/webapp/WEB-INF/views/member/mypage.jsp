<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
 <link rel="stylesheet" href="${contextPath}/resources/css/member/mypage.css">
</head>
<body>
    <div class="mypage-container">
        <div class="profile-section">
            <img src="${contextPath}/resources/img/basic.png" alt="프로필 사진" class="profile-img">
            <h2>${member.memberName}</h2>
        </div>
        <div class="info-section">
            <div class="info-item">
                <span class="label">아이디</span>
                <input type="text" value="${member.memberId}" readonly>
            </div>
            <div class="info-item">
                <span class="label">이름</span>
                <input type="text" value="${member.memberPwd}">
                <button class="edit-btn">수정</button>
            </div>
            <div class="info-item">
                <span class="label">비밀번호</span>
                <input type="password" placeholder="비밀번호 변경">
                <button class="edit-btn">변경</button>
            </div>
            <div class="info-item">
                <span class="label">이메일</span>
                <input type="email" value="${member.memberEmail}">
                <button class="edit-btn">수정</button>
            </div>
            <div class="info-item">
                <span class="label">전화번호</span>
                <input type="tel" value="${member.memberTel}">
                <button class="edit-btn">수정</button>
            </div>
            <div class="info-item">
                <span class="label">나이</span>
                <input type="number" value="${member.memberAge}">
                <button class="edit-btn">수정</button>
            </div>
            <div class="info-item">
                <span class="label">닉네임</span>
                <input type="text" value="${member.memberNickname}">
                <button class="edit-btn">수정</button>
            </div>
            <div class="info-item">
                <span class="label">성별</span>
                <select>
                    <option value="남자" ${user.gender == '남자' ? 'selected' : ''}>남자</option>
                    <option value="여자" ${user.gender == '여자' ? 'selected' : ''}>여자</option>
                </select>
            </div>
            <div class="button-container">
                <button class="save-btn">저장</button>
            </div>
        </div>
    </div>
</body>
</html>
