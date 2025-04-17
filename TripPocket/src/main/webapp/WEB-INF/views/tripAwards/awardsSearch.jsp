<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<h2>${category} 검색 결과</h2>
<div class="awards-results">
    <c:forEach var="award" items="${awardsBest}">
        <div class="award-item">
      <img src="${contextPath}/resources/images/${award.imgFileno}.jpg" alt="썸네일" />
            <p>제목: ${award.title}</p>
            <p>내용: ${award.content}</p>
            <p>조회수: ${award.hits}</p>
            <p>좋아요: ${award.likes}</p>
        </div>
    </c:forEach>
</div>
 <a href="awardslist.jsp">← 목록으로 돌아가기</a>
</body>
</html>