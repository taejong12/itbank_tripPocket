<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 공유 리스트</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 18px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #34495e;
            color: white;
        }
        a {
            color: #2980b9;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .add-btn {
            display: block;
            width: 150px;
            margin: 30px auto 0;
            padding: 10px;
            background-color: #27ae60;
            color: white;
            text-align: center;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }
        .add-btn:hover {
            background-color: #219150;
        }
    </style>
</head>
<body>

    <h1>여행 공유 리스트</h1>
    
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
                        <a href="${contextPath}/share/shareDetail.do?tripShareId=${share.tripShareId}">
                            ${share.tripShareTitle}
                        </a>
                    </td>
                    <td><fmt:formatDate value="${share.tripShareAddDate}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${share.tripShareModDate}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <a class="add-btn" href="<c:url value='/share/shareForm.do' />">공유 추가</a>

</body>
</html>
	