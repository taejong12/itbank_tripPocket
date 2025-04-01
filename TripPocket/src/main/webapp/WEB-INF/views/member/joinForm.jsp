<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script>
var isMemberIdValid = false;

function fn_joinForm() {
    var form = document.joinForm;
    
    if (form.memberId.value.trim() === "") {
        alert("아이디를 입력해 주세요.");
        form.memberId.focus();
        return false;
    }
    
    if (!isMemberIdValid) {
        alert("아이디 중복 체크를 해주세요.");
        form.memberId.focus();
        return false;
    }
    
    if (form.memberPwd.value.trim() === "") {
        alert("비밀번호를 입력해 주세요.");
        form.memberPwd.focus();
        return false;
    }
    
    if (form.memberName.value.trim() === "") {
        alert("이름을 입력해 주세요.");
        form.memberName.focus();
        return false;
    }
    
    if (form.memberEmail.value.trim() === "") {
        alert("이메일을 입력해 주세요.");
        form.memberEmail.focus();
        return false;
    } else {
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/; // 이메일 패턴 ex)hong@test.com
        if (!emailPattern.test(form.memberEmail.value)) {
            alert("정확한 이메일을 입력해 주세요.");
            form.memberEmail.focus();
            return false;
        }
    }
    
    if (form.memberAge.value.trim() === "") {
        alert("나이를 입력해 주세요.");
        form.memberAge.focus();
        return false;
    } else {
        var age = parseInt(form.memberAge.value); // 정수로 변환
        if (isNaN(age) || age <= 0) { // 나이가 숫자가 아니거나 0보다 작거나 같으면 false
            alert("유효한 나이를 입력해 주세요.");
            form.memberAge.focus();
            return false;
        }
    }
    
    if (form.memberNickname.value.trim() === "") {
        alert("닉네임을 입력해 주세요.");
        form.memberNickname.focus();
        return false;
    }
    
    if (form.memberTel.value.trim() === "") {
        alert("전화번호를 입력해 주세요.");
        form.memberTel.focus();
        return false;
    } else {
        var telPattern = /^\d{10,11}$/; // 01012341234 형식
        if (!telPattern.test(form.memberTel.value)) {
            alert("유효한 전화번호를 입력해 주세요. 숫자만 입력해 주세요.");
            form.memberTel.focus();
            return false;
        }
    }
    
    return true;
}

function fn_memberIdCheck() {
    var memberId = document.joinForm.memberId.value.trim();
    if (memberId === "") {
        alert("아이디를 입력해 주세요.");
        return;
    }
    
    var xhr = new XMLHttpRequest(); // AJAX 요청
    xhr.open("GET", "${contextPath}/member/memberIdCheck.do?memberId=" + encodeURIComponent(memberId), true); // get메서드로 아이디 값을 인코딩하여 서버로 넘기고 비동기로 처리
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); // 형식으로 인코딩
    
    xhr.onreadystatechange = function() { // 요청 상태가 변경될 때 호출되는 콜백 함수
        if (xhr.readyState === 4 && xhr.status === 200) { // 4-요청이 완료되었는지 확인, 200-요정이 성공적으로 처리되었는지 확인
            var responseText = xhr.responseText.trim(); // 서버로부터 받은 응답 텍스트를 공백제거
            if (responseText === "OK") { // ok면 아이디 중복 X
                alert("사용 가능한 아이디입니다.");
                isMemberIdValid = true;
            } else { // 아니면 아이디 중복 O
                alert("중복된 아이디입니다. 다른 아이디를 입력해 주세요.");
                document.joinForm.memberId.focus(); // 중복이면 id 포커스
                isMemberIdValid = false;
            }
        }
    };
    xhr.send(); // 서버로부터 요청보냄
}
</script>
</head>
<body>
    <form name="joinForm" method="post" action="${contextPath}/member/join.do" onsubmit="return fn_joinForm();">
        <table border="1" width="80%" align="center">
            <tr align="center">
                <td>아이디</td>
                <td>
                    <input type="text" name="memberId" size="20">
                    <input type="button" name="memberIdCheck" value="중복확인" onclick="fn_memberIdCheck()">
                </td>
            </tr>
            <tr align="center">
                <td>비밀번호</td>
                <td><input type="password" name="memberPwd" size="20"></td>
            </tr>
            <tr align="center">
                <td>이름</td>
                <td><input type="text" name="memberName" size="20"></td>
            </tr>
            <tr align="center">
                <td>이메일</td>
                <td><input type="email" name="memberEmail" size="20"></td>
            </tr>
            <tr align="center">
                <td>나이</td>
                <td><input type="number" name="memberAge" size="20"></td>
            </tr>
            <tr align="center">
                <td>닉네임</td>
                <td><input type="text" name="memberNickname" size="20"></td>
            </tr>
            <tr align="center">
                <td>전화번호</td>
                <td><input type="tel" name="memberTel" size="20" pattern="\d{10,11}"></td>
            </tr>
            <tr align="center">
                <td>성별</td>
                <td>
                    <select name="memberGender">
                        <option value="남자">남자</option>
                        <option value="여자">여자</option>
                    </select>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <input type="submit" value="회원가입">
                    <a href="${contextPath}/main.do">메인페이지</a>
                </td>
            </tr>
        </table>    
    </form>
</body>
</html>