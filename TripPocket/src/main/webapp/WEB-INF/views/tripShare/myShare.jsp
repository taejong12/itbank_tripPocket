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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>
<body>

<div class="container" id="shareListContainer">
    <!-- 공유 리스트가 렌더링될 위치 -->
</div>

<!-- 페이지네이션을 카드 리스트 내부에 위치 -->
<div class="pagination" id="paginationContainer"></div>

<!-- 글쓰기 버튼을 항상 보이도록 하여, 조건문 밖에 배치 -->
<div class="add-btn-container">
    <a class="add-btn" href="<c:url value='/share/shareForm.do' />">✍️ 나의 첫 여행 블로그 공유하기</a>
</div>

<script>
$(document).ready(function() {
    const pageSize = 5; // 한 페이지에 보여줄 항목 수
    let currentPage = 1;
    let fullData = []; // 전체 데이터를 저장

    loadShareList(); // 페이지 로드 시 공유 목록 불러오기

    // 공유 목록을 불러오는 함수
    function loadShareList() {
        $.ajax({
            url: '${contextPath}/share/myShareListAjax.do',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                fullData = data; // 전체 데이터를 저장
                if (Array.isArray(fullData) && fullData.length > 0) {
                    renderPage(currentPage);
                    renderPagination(fullData.length);
                } else {
                    $('#shareListContainer').html(
                        '<p>아직 공유된 여행이 없어요. 나만 알고 있기엔 아까운 당신의 여행 이야기,<br>지금 바로 세상과 나눠보세요 ✨</p>'
                    );
                    $('#paginationContainer').empty(); // 페이징도 지움
                }
            },
            error: function() {
                $('#shareListContainer').html('<p>데이터를 불러오는 중 오류가 발생했습니다.</p>');
            }
        });
    }

    // 페이지 렌더링 함수
    function renderPage(page) {
        const start = (page - 1) * pageSize;
        const end = start + pageSize;
        const pageItems = fullData.slice(start, end);

        let listHtml = '';
        pageItems.forEach(function(item) {
            listHtml += '<div class="card">';
            listHtml += '<h2 class="card-title">';
            listHtml += '<a href="${contextPath}/share/myDetail.do?tripShareId=' + item.tripShareId + '">';
            listHtml += item.tripShareTitle + '</a></h2>';
            listHtml += '<div class="card-meta">';
            listHtml += '추가 날짜: ' + item.tripShareAddDate + ' | ';
            listHtml += '수정 날짜: ' + item.tripShareModDate;
            listHtml += '</div>';
            listHtml += '<div class="card-actions">';
            listHtml += '<a href="${contextPath}/share/modForm.do?tripShareId=' + item.tripShareId + '" class="edit-btn">✏️ 수정</a>';
            listHtml += '<a href="${contextPath}/share/shareDelete.do?tripShareId=' + item.tripShareId + '" class="delete-btn" onclick="return confirm(\'정말 삭제하시겠습니까?\');">🗑️ 삭제</a>';
            listHtml += '</div>';
            listHtml += '</div>';
        });

        $('#shareListContainer').html(listHtml);

        // 페이지네이션을 카드 리스트 아래에 추가
        $('#shareListContainer').append('<div class="pagination" id="paginationContainer"></div>');
    }

    // 페이징 렌더링 함수
    function renderPagination(totalItems) {
        const totalPages = Math.ceil(totalItems / pageSize);
        let paginationHtml = '';

        for (let i = 1; i <= totalPages; i++) {
            paginationHtml += '<button class="page-btn' + (i === currentPage ? ' active' : '') + '" data-page="' + i + '">' + i + '</button>';
        }

        $('#paginationContainer').html(paginationHtml);

        // 페이지 버튼 클릭 이벤트
        $('.page-btn').click(function() {
            currentPage = parseInt($(this).data('page'));
            renderPage(currentPage);
            renderPagination(totalItems); // 다시 렌더링해서 active 갱신
        });
    }
});
</script>

</body>
</html>