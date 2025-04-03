<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f0f2f5;
    font-family: 'Noto Sans', sans-serif;
}

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
    text-align: center;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
}

.input-container {
    width: 100%;
    margin-bottom: 15px;
    position: relative;
}

.input-container input {
    width: 100%;
    padding: 12px;
    font-size: 1rem;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

.gender-container {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 10px;
}

.gender-container label {
    display: flex;
    align-items: center;
    gap: 10px;
}

#checkBtn {
    padding: 8px;
    font-size: 0.875rem;
    color: #fff;
    background-color: #4F46E5;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-left: 10px;
}

#checkBtn:hover {
    background-color: #3b3a99;
}

.button-container button {
    width: 100%;
    padding: 12px;
    font-size: 1rem;
    color: #fff;
    background-color: #4F46E5;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.button-container button:hover {
    background-color: #3b3a99;
}
</style>
<script>
var isMemberIdValid = false;

function fn_memberIdCheck() {
    var memberId = document.joinForm.memberId.value.trim();
    if (memberId === "") {
        alert("아이디를 입력해 주세요.");
        return;
    }
    
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "${contextPath}/member/memberIdCheck.do?memberId=" + encodeURIComponent(memberId), true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var responseText = xhr.responseText.trim();
            if (responseText === "OK") {
                alert("사용 가능한 아이디입니다.");
                isMemberIdValid = true;
            } else {
                alert("중복된 아이디입니다. 다른 아이디를 입력해 주세요.");
                document.joinForm.memberId.focus();
                isMemberIdValid = false;
            }
        }
    };
    xhr.send();
}

document.addEventListener("DOMContentLoaded", function() {
    document.joinForm.memberId.addEventListener("input", function() {
        isMemberIdValid = false;
    });
});

function fn_joinForm(event) {
    var form = document.joinForm;
    
    if (form.memberId.value.trim() === "") {
        alert("아이디를 입력해 주세요.");
        form.memberId.focus();
        event.preventDefault();
        return false;
    }
    
    if (!isMemberIdValid) {
        alert("아이디 중복 체크를 해주세요.");
        form.memberId.focus();
        event.preventDefault();
        return false;
    }
    
    if (form.memberPwd.value.trim() === "") {
        alert("비밀번호를 입력해 주세요.");
        form.memberPwd.focus();
        event.preventDefault();
        return false;
    }
    
    if (form.memberName.value.trim() === "") {
        alert("이름을 입력해 주세요.");
        form.memberName.focus();
        event.preventDefault();
        return false;
    }
    
    if (form.memberEmail.value.trim() === "") {
        alert("이메일을 입력해 주세요.");
        form.memberEmail.focus();
        event.preventDefault();
        return false;
    }
    
    if (form.memberAge.value.trim() === "") {
        alert("나이를 입력해 주세요.");
        form.memberAge.focus();
        event.preventDefault();
        return false;
    }
    
    if (form.memberNickname.value.trim() === "") {
        alert("닉네임을 입력해 주세요.");
        form.memberNickname.focus();
        event.preventDefault();
        return false;
    }
    
    if (form.memberTel.value.trim() === "") {
        alert("전화번호를 입력해 주세요.");
        form.memberTel.focus();
        event.preventDefault();
        return false;
    }
    
    if (!form.memberGender.value) {
        alert("성별을 선택해 주세요.");
        event.preventDefault();
        return false;
    }
}
</script>
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
                <input type="tel" name="memberTel" placeholder="전화번호를 입력하세요" pattern="\d{10,11}">
            </div>
            <div class="gender-container">
                <label><input type="radio" name="memberGender" value="남자"> 남자</label>
                <label><input type="radio" name="memberGender" value="여자"> 여자</label>
            </div>
            <div class="button-container">
                <button type="submit">회원가입</button>
            </div>
        </form>
    </div>
</body>
</html>
