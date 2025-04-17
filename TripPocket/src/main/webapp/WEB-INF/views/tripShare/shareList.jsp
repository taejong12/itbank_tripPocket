<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- 구글 웹폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${contextPath}/resources/css/tripShare/shareList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="blog-container">
    <h1 class="blog-title">🌿 Trip Share 블로그</h1>

    <div class="sort-section">
        <label for="sortType">정렬:</label>
        <select id="sortType" class="sort-select">
            <option value="latest">최신순</option>
            <option value="views">조회순</option>
            <option value="shares">공유순</option>
        </select>
    </div>

    <div class="card-list" id="shareListBody">
        <!-- AJAX로 카드형 게시글 렌더링 -->
    </div>

    <div class="add-btn-wrapper">
        <a class="add-btn" href="<c:url value='/share/shareForm.do' />">✍️ 여행 이야기 공유하기</a>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    $(document).ready(function () {
        loadShareList();

        $('#sortType').on('change', function () {
            loadShareList();
        });
    });

    function loadShareList() {
        const sortType = $('#sortType').val();

        $.ajax({
            url: contextPath + '/share/shareListAjax.do',
            method: 'GET',
            data: { sortType: sortType },
            success: function(res) {
                renderShareList(res);
            },
            error: function(xhr) {
                console.error("에러:", xhr.responseText);
            }
        });
    }

    function renderShareList(list) {
        const container = $('#shareListBody');
        container.empty();

        if (!list || list.length === 0) {
            container.append(
                '<div class="no-share-text">' +
                '🗺️ 아직 공유된 여행이 없어요.<br>' +
                '<span>당신의 첫 여행기를 남겨주세요!</span>' +
                '</div>'
            );
            return;
        }

        list.forEach(function(item) {
            const addDate = formatDate(item.tripShareAddDate);
            const modDate = formatDate(item.tripShareModDate);

            const card =
                '<div class="share-card">' +
                    '<div class="card-content">' +
                        '<h2 class="card-title">' +
                            '<a href="' + contextPath + '/share/shareDetail.do?tripShareId=' + item.tripShareId + '">' +
                                item.tripShareTitle +
                            '</a>' +
                        '</h2>' +
                        '<p class="card-meta">👤 ' + item.memberId + '님 · 🗓️ ' + addDate + ' · 👁️ ' + item.tripShareViewCount + '회 조회</p>' +
                        '<p class="card-updated">최근 수정: ' + modDate + '</p>' +
                    '</div>' +
                '</div>';

            container.append(card);
        });
    }

    function formatDate(dateStr) {
        if (!dateStr) return '';
        const date = new Date(dateStr);
        return date.toISOString().split('T')[0];
    }
</script>
