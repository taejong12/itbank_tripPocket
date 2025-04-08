<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행 공유 리스트</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
    <h1>여행 공유 리스트</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>내용</th>
                <th>추가 날짜</th>
                <th>수정 날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="share" items="${tripShareList}">
                <tr>
                    <td>${share.tripShareId}</td>
                    <td>${share.tripShareTitle}</td>
                    <td><fmt:formatDate value="${share.tripShareAddDate}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${share.tripShareModDate}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <a href="<c:url value='/share/shareForm.do' />">공유 추가</a>
</body>
</html>