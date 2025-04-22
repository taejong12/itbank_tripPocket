<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/member/mypage.css">
    <script>
    	var contextPath = "${pageContext.request.contextPath}";
    	var memberId = "${member.memberId}";
    </script>	
    <script src="${contextPath}/resources/js/member/mypage.js"></script>
</head>
<body>
	<div class="mypage-container">
	   <div class="profile-section">
		    <div class="profile-img-wrapper">
		        <!-- 프로필 이미지 경로를 동적으로 처리 -->
		        <img src="${contextPath}/resources/img/profile/${member.memberProfileImage != null ? member.memberProfileImage : 'basic.png'}" alt="프로필 사진" id="profile-img">
		        <!-- 파일 입력을 트리거하는 버튼 -->
		        <button type="button" onclick="triggerFileInput()" id="add" class="profile-btn">➕</button>
		    </div>
		    <input type="file" id="profile-img-input" style="display: none;" accept="image/*" onchange="previewImage(event)">
		    <div class="profile-info-row">
			    <h2>${member.memberNickname}님</h2>
			    <div class="reset-btn-wrapper">
			        <button type="button" onclick="resetToBasicImage()" class="reset-btn">기본 이미지로 복원</button>
			    </div>
			</div>
		</div>
        <!-- 수정 form 시작 -->
        <form action="${contextPath}/member/modMember.do" method="post" onsubmit="return mypageForm(event)">
            <input type="hidden" name="memberId" value="${member.memberId}" />

            <!-- 아이디 -->
            <div class="info-item">
                <span class="label">아이디</span>
                <div class="info-value-row" id="id-display">
                    <span class="info-value id-value">${member.memberId}</span>
                </div>
            </div>

            <!-- 비밀번호 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">비밀번호</span>
                <div class="info-value-row" id="password-display">
                    <span class="info-value password-value">********</span>
                    <a href="javascript:void(0);" class="edit-link" id="password-button" onclick="showEditField('password')">변경</a>
                </div>
            </div>

            <!-- 이메일 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">이메일</span>
                <div class="info-value-row" id="email-display">
                    <span class="info-value email-value">${member.memberEmail}</span>
                    <a href="javascript:void(0);" class="edit-link" id="email-button" onclick="showEditField('email')">변경</a>
                </div>
                <div class="edit-field" id="email-edit">
                    <input type="email" name="memberEmail" id="email-input" value="${member.memberEmail}" placeholder="변경하실 이메일을 입력하세요">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('email')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 전화번호 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">휴대전화번호</span>
                <div class="info-value-row" id="tel-display">
                    <span class="info-value tel-value">${member.memberTel}</span>
                    <a href="javascript:void(0);" class="edit-link" id="tel-button" onclick="showEditField('tel')">변경</a>
                </div>
                <div class="edit-field" id="tel-edit">
                    <input type="tel" name="memberTel" id="tel-input" value="${member.memberTel}" placeholder="변경하실 휴대전화번호를 입력하세요">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('tel')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 나이 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">나이</span>
                <div class="info-value-row" id="age-display">
                    <span class="info-value age-value">${member.memberAge}</span>
                </div>
            </div>

            <!-- 닉네임 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">닉네임</span>
                <div class="info-value-row" id="nickname-display">
                    <span class="info-value nickname-value">${member.memberNickname}</span>
                    <a href="javascript:void(0);" class="edit-link" id="nickname-button" onclick="showEditField('nickname')">변경</a>
                </div>
                <div class="edit-field" id="nickname-edit">
                    <input type="text" name="memberNickname" id="nickname-input" value="${member.memberNickname}" placeholder="변경하실 닉네임을 입력하세요">
                    <div class="button-container">
                        <button type="submit">저장</button>
                        <button type="button" class="cancel-btn" onclick="hideEditField('nickname')">취소</button>
                    </div>
                </div>
            </div>

            <!-- 이름 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">이름</span>
                <div class="info-value-row" id="name-display">
                    <span class="info-value name-value">${member.memberName}</span>
                </div>
            </div>

            <!-- 성별 -->
            <hr class="divider">
            <div class="info-item">
                <span class="label">성별</span>
                <div class="info-value-row" id="gender-display">
                    <span class="info-value gender-value">${member.memberGender}</span>
                </div>
            </div>
        </form>

        <!-- 회원탈퇴 버튼 전 구분선 -->
        <hr class="divider">

        <!-- 회원탈퇴 -->
        <form action="${contextPath}/member/delMember.do" method="post" onsubmit="return confirm('정말로 회원탈퇴를 진행하시겠습니까?');">
            <input type="hidden" name="memberId" value="${member.memberId}" />
            <button type="submit" class="delete-account-btn">회원탈퇴</button>
        </form>
    </div>
</body>
</html>
