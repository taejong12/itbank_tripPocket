<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/member/mypage.css">

    <script src="${contextPath }/resources/script/member/mypage.js"></script>
    <style>
        /* 회원탈퇴 버튼 스타일 */
        .delete-account-btn {
            display: block;
            margin: 20px auto 0; /* 중앙 정렬 및 위쪽 여백 */
            padding: 10px 20px;
            background-color: #ff4d4d; /* 빨간색 배경 */
            color: white;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
            text-align: center;
        }

        .delete-account-btn:hover {
            background-color: #e60000; /* 버튼 호버 시 더 진한 빨간색 */
        }
    </style>
</head>
<body>
    <div class="mypage-container">
        <div class="profile-section">
            <img src="${contextPath}/resources/img/basic.png" alt="프로필 사진" class="profile-img">
            <h2>${member.memberName}</h2>
        </div>

        <!-- 모든 수정 항목을 포함하는 form -->
        <form action="${contextPath}/member/modMember.do" method="post" onsubmit="return mypageForm(event)">
            <input type="hidden" name="memberId" value="${member.memberId}" />

            <!-- 아이디 (수정 불가) -->
            <div class="info-item">
                <span class="label">아이디</span>
                <div class="info-value-row" id="id-display">
                    <span class="info-value id-value">${member.memberId}</span>
                </div>
            </div>

            <!-- 비밀번호 -->
            <div class="info-item">
                <span class="label">비밀번호</span>
                <div class="info-value-row" id="password-display">
                    <span class="info-value password-value">********</span>
                    <a href="javascript:void(0);" class="edit-link" id="password-button"
                       onclick="showEditField('password')">수정</a>
                </div>
                <div class="edit-field" id="password-edit">
                    <input type="password" name="memberPassword" id="password-input" placeholder="새 비밀번호">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button class="cancel-btn" type="button" onclick="hideEditField('password')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 이메일 -->
            <div class="info-item">
                <span class="label">이메일</span>
                <div class="info-value-row" id="email-display">
                    <span class="info-value email-value">${member.memberEmail}</span>
                    <a href="javascript:void(0);" class="edit-link" id="email-button"
                       onclick="showEditField('email')">수정</a>
                </div>
                <div class="edit-field" id="email-edit">
                    <input type="email" name="memberEmail" id="email-input" value="${member.memberEmail}" />
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('email')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 전화번호 -->
            <div class="info-item">
                <span class="label">전화번호</span>
                <div class="info-value-row" id="tel-display">
                    <span class="info-value tel-value">${member.memberTel}</span>
                    <a href="javascript:void(0);" class="edit-link" id="tel-button"
                       onclick="showEditField('tel')">수정</a>
                </div>
                <div class="edit-field" id="tel-edit">
                    <input type="tel" name="memberTel" id="tel-input" value="${member.memberTel}">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('tel')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 나이 -->
            <div class="info-item">
                <span class="label">나이</span>
                <div class="info-value-row" id="age-display">
                    <span class="info-value age-value">${member.memberAge}</span>
                    <a href="javascript:void(0);" class="edit-link" id="age-button"
                       onclick="showEditField('age')">수정</a>
                </div>
                <div class="edit-field" id="age-edit">
                    <input type="number" name="memberAge" id="age-input" value="${member.memberAge}">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('age')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 닉네임 -->
            <div class="info-item">
                <span class="label">닉네임</span>
                <div class="info-value-row" id="nickname-display">
                    <span class="info-value nickname-value">${member.memberNickname}</span>
                    <a href="javascript:void(0);" class="edit-link" id="nickname-button"
                       onclick="showEditField('nickname')">수정</a>
                </div>
                <div class="edit-field" id="nickname-edit">
                    <input type="text" name="memberNickname" id="nickname-input" value="${member.memberNickname}">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('nickname')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 이름 -->
            <div class="info-item">
                <span class="label">이름</span>
                <div class="info-value-row" id="name-display">
                    <span class="info-value name-value">${member.memberName}</span>
                    <a href="javascript:void(0);" class="edit-link" id="name-button"
                       onclick="showEditField('name')">수정</a>
                </div>
                <div class="edit-field" id="name-edit">
                    <input type="text" name="memberName" id="name-input" value="${member.memberName}">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('name')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 성별 -->
            <div class="info-item">
                <span class="label">성별</span>
                <div class="info-value-row" id="gender-display">
                    <span class="info-value gender-value">${member.memberGender}</span>
                    <a href="javascript:void(0);" class="edit-link" id="gender-button"
                       onclick="showEditField('gender')">수정</a>
                </div>
                <div class="edit-field" id="gender-edit">
                    <select name="memberGender" id="gender-input">
                        <option value="남자" <c:if test="${member.memberGender == '남자'}">selected</c:if>>남자</option>
                        <option value="여자" <c:if test="${member.memberGender == '여자'}">selected</c:if>>여자</option>
                    </select>
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('gender')">취소</button>
                    </div>
                </div>
            </div>
        </form>

        <!-- 회원탈퇴 버튼 -->
        <form action="${contextPath}/member/delMember.do" method="post" onsubmit="return confirm('정말로 회원탈퇴를 진행하시겠습니까?');">
            <input type="hidden" name="memberId" value="${member.memberId}" />
            <button type="submit" class="delete-account-btn">회원탈퇴</button>
        </form>
    </div>
</body>
</html>