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
        /* Body and General Styling */
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            padding-top: 80px; /* 헤더 높이에 맞게 조정 */
        }

        /* Card Section */
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }

        .card-title {
            font-size: 20px;
            font-weight: bold;
            color: #2a8fbd;
            margin: 0 0 10px;
        }

        .card-title a {
            text-decoration: none;
            color: inherit;
        }

        .card-title a:hover {
            text-decoration: underline;
        }

        .card-meta {
            font-size: 14px;
            color: #666;
            margin-top: 10px;
        }

        /* Add Button */
        .add-btn {
            display: block;
            width: 200px;
            margin: 30px auto;
            padding: 12px 20px;
            background-color: #2a8fbd;
            color: white;
            text-align: center;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s, transform 0.2s;
        }

        .add-btn:hover {
            background-color: #176c93;
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .card {
                padding: 15px;
            }

            .card-title {
                font-size: 18px;
            }

            .card-meta {
                font-size: 12px;
            }

            .add-btn {
                width: 80%;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <!-- Card Section -->
    <div class="container">
        <c:forEach var="share" items="${myList}">
            <div class="card">
                <h2 class="card-title">
                    <a href="${contextPath}/share/shareDetail.do?tripShareId=${share.tripShareId}">
                        ${share.tripShareTitle}
                    </a>
                </h2>
                <div class="card-meta">
                    추가 날짜: <fmt:formatDate value="${share.tripShareAddDate}" pattern="yyyy-MM-dd" /> | 
                    수정 날짜: <fmt:formatDate value="${share.tripShareModDate}" pattern="yyyy-MM-dd" />
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Add Button -->
    <a class="add-btn" href="<c:url value='/share/shareForm.do' />">공유 추가</a>

</body>
</html>