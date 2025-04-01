<%@page import="com.tripPocket.www.member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%
   Boolean isLogin = (Boolean) session.getAttribute("isLogin");
   MemberDTO member = (MemberDTO) session.getAttribute("member");
%>
<body>
   <table border="0" width="100%">
      <tr>
         <td>
            <a href="${contextPath}/main.do">
               <img src="${contextPath}/resources/image/" alt="로고">
            </a>
         </td>
         <td>
            <h1><font size="30">TripPocket</font></h1>
         </td>
         <c:choose>
            <c:when test="${isLogin == true || member != null}">
               <td>
                  <h3>${member.memberId}</h3>
                  <h3><a href="${contextPath}/member/myPage.do?memberId=${member.memberId }">마이페이지</a></h3>
                  <h3><a href="${contextPath}/member/logout.do">로그아웃</a></h3>
               </td>
            </c:when>
            <c:otherwise>
               <td>
                  <a href="${contextPath}/member/loginForm.do"><h3>로그인</h3></a>
                  <a href="${contextPath}/member/joinForm.do"><h3>회원가입</h3></a>
               </td>
            </c:otherwise>
         </c:choose>
      </tr>
   </table>
</body>
</html>