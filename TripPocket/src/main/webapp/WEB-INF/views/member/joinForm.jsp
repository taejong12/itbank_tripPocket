<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form name="joinForm" method="post" action="${contextPath}/member/join.do">
		<table border="1" width="80%" align="center">
			<tr align="center">
				<td>아이디</td>
				<td><input type="text" name="memberId" size="20"></td>
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
				<td><input type="text" name="memberAge" size="20"></td>
			</tr>
			<tr align="center">
				<td>닉네임</td>
				<td><input type="text" name="memberNickname" size="20"></td>
			</tr>
			<tr align="center">
				<td>전화번호</td>
				<td><input type="tel" name="memberTel" size="20"></td>
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