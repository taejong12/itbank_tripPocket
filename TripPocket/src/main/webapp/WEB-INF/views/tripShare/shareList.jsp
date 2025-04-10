<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 공유 리스트</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/shareList.css">
  
</head>
<body class="ListContainer">

    <!-- Page Title -->
    <h1>여행 공유 리스트</h1>
    
    <!-- Table Section -->
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>추가 날짜</th>
                <th>수정 날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="share" items="${tripShareList}">
                <tr>
                    <td>${share.tripShareId}</td>
                    <td>
                        <a href="${contextPath}/share/shareDetail.do?tripShareId=${share.tripShareId}" class="a">
                            ${share.tripShareTitle}
                        </a>
                    </td>
                    <td><fmt:formatDate value="${share.tripShareAddDate}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${share.tripShareModDate}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Floating Add Button -->
    <a class="add-btn" href="<c:url value='/share/shareForm.do' />">공유 추가</a>

</body>
</html>