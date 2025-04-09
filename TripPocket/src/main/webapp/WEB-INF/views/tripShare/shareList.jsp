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
        /* General Body Styling */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        /* Page Title */
        h1 {
            color: #2a8fbd;
            text-align: center;
            margin-bottom: 30px;
            font-size: 32px;
            font-weight: bold;
        }

        /* Table Styling */
        table {
            width: 90%;
            margin: 0 auto;
            border-collapse: collapse;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            border-bottom: 1px solid #e2e2e2;
            text-align: center;
        }

        th {
            background-color: #2a8fbd;
            color: white;
            font-size: 16px;
        }

        td {
            font-size: 14px;
            color: #333;
        }

        tr:last-child td {
            border-bottom: none;
        }

        /* Links Styling */
        a {
            color: #2a8fbd;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #176c93;
            text-decoration: underline;
        }

        /* Floating Add Button */
        .add-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #2a8fbd;
            color: white;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
            padding: 10px 15px;
            border-radius: 50px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
        }

        .add-btn:hover {
            background-color: #176c93;
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table {
                width: 95%;
            }

            th, td {
                font-size: 12px;
                padding: 10px;
            }

            .add-btn {
                font-size: 12px;
                padding: 8px 12px;
            }
        }
    </style>
</head>
<body>

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

    <!-- Floating Add Button -->
    <a class="add-btn" href="<c:url value='/share/shareForm.do' />">공유 추가</a>

</body>
</html>