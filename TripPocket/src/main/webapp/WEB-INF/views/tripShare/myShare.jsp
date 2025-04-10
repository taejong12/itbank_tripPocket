<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 공유 리스트</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/myShare.css">
</head>
<body>

<div class="container">
<c:choose>
    <c:when test="${empty myList}">
     <div class="empty-box">
    <p class="empty-title">아직 공유된 여행이 없어요</p>
    <p class="empty-sub">나만 알고 있기엔 아까운 당신의 여행 이야기,<br>지금 바로 세상과 나눠보세요 ✨</p>
    <a class="add-btn" href="<c:url value='/share/shareForm.do' />">✍️ 나의 첫 여행 블로그 공유하기</a>
</div>
        </c:when>
         <c:otherwise>
            <c:forEach var="share" items="${myList}">
        <div class="card">
            <h2 class="card-title">
                <a href="${contextPath}/share/myDetail.do?tripShareId=${share.tripShareId}">
                    ${share.tripShareTitle}
                </a>
            </h2>
            <div class="card-meta">
                추가 날짜: <fmt:formatDate value="${share.tripShareAddDate}" pattern="yyyy-MM-dd" /> | 
                수정 날짜: <fmt:formatDate value="${share.tripShareModDate}" pattern="yyyy-MM-dd" />
            </div>
            <div class="card-actions">
                <a href="${contextPath}/share/editForm.do?tripShareId=${share.tripShareId}" class="edit-btn">✏️ 수정</a>
                <a href="${contextPath}/share/shareDelete.do?tripShareId=${share.tripShareId}" class="delete-btn"
                   onclick="return confirm('정말 삭제하시겠습니까?');">🗑️ 삭제</a>
            </div>
        </div>
        </c:forEach>
        <a class="add-btn" href="<c:url value='/share/shareForm.do' />">✍️ 새로운 여행 이야기 공유하기</a>
	 </c:otherwise>
    </c:choose>
</div>



</body>
</html>
