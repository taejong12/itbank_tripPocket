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
<style>
/* 전체 페이지 스타일 */
body {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  font-family: 'Arial', sans-serif;
}

/* 로그인 폼 */
.form {
  background-color: #fff;
  padding: 2rem;
  max-width: 350px;
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
  text-align: center;
  animation: fadeIn 0.5s ease-in-out;
}

/* 제목 스타일 */
.form-title {
  font-size: 1.5rem;
  font-weight: bold;
  color: #4F46E5;
  margin-bottom: 1rem;
}

/* 입력 필드 스타일 */
.input-container {
  position: relative;
  margin-bottom: 1rem;
}

.input-container input {
  width: 100%;
  padding: 12px;
  border-radius: 8px;
  border: 1px solid #ddd;
  font-size: 1rem;
  transition: all 0.3s ease-in-out;
}

.input-container input:focus {
  border-color: #4F46E5;
  box-shadow: 0 0 8px rgba(79, 70, 229, 0.5);
  outline: none;
}

/* placeholder 스타일 */
.input-container input::placeholder {
  color: #aaa;
  font-size: 0.9rem;
}

/* 아이콘 스타일 */
.input-container span {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  color: #9CA3AF;
}

/* 로그인 버튼 스타일 */
.submit {
  background: #4F46E5;
  color: white;
  padding: 12px;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}

.submit:hover {
  background: #4338CA;
  box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
}

.submit:active {
  transform: scale(0.98);
}

/* 회원가입 링크 */
.signup-link {
  margin-top: 1rem;
  font-size: 0.9rem;
  color: #6B7280;
}

.signup-link a {
  color: #4F46E5;
  font-weight: bold;
  text-decoration: none;
}

.signup-link a:hover {
  text-decoration: underline;
}

/* 애니메이션 효과 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
</head>
<body>
	<div>
    <form class="form" method="post" action="login.do">
       <p class="form-title">귀하의 계정에 로그인하세요</p>
        <div class="input-container">
          <input placeholder="아이디를 입력하세요	" type="text" name="memberId">
          <span>
            <svg stroke="currentColor" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path>
            </svg>
          </span>
      </div>
      <div class="input-container">
          <input placeholder="비밀번호를 입력하세요" type="password" name="memberPwd">

          <span>
            <svg stroke="currentColor" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path>
              <path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path>
            </svg>
          </span>
        </div>
         <button class="submit" type="submit">
        로그인
      </button>

      <p class="signup-link">
       계정이 없으신가요?
        <a href="${contextPath}/member/joinForm.do">회원가입</a>
      </p>
   </form>
</div>
	
</body>
</html>