<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인창</title>
<script></script>
</head>
<body>
	<form method="post" action="${contextPath}/member/login.do">
		<table border="1" width="80%" align="center">
		
			<tr align="center">
				<td>아이디</td>
				<td>비밀번호</td>
			</tr>
			<tr align="center">
				<td><input type="text" name="memberId" size="20"></td>
				<td><input type="password" name="memberPwd" size="20"></td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="submit" value="로그인">
					<input type="reset" value="다시입력">
				</td>
			</tr>
		</table>	
	</form>
	
	<a href="${contextPath}/member/joinForm.do"><h3>회원가입</h3></a>
</body>
</html>