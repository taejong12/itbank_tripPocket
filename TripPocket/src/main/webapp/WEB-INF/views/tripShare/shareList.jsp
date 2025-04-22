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

    <!-- 검색 입력란 추가 -->
    <div class="search-section">
    <label for="searchCriteria">검색 기준:</label>
    <select id="searchCriteria">
        <option value="title">제목</option>
        <option value="id">아이디</option>
    </select>

    <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
	</div>

    <div class="sort-section">
        <label for="sortType">정렬:</label>
        <select id="sortType" class="sort-select">
            <option value="latest">최신순</option>
            <option value="views">조회순</option>
            <option value="shares">공유순</option>
        </select>
    </div>

    <div class="card-list" id="shareListBody">
        <!-- 게시글 목록 렌더링 -->
    </div>

    <div class="pagination" id="pagination">
        <!-- 페이지네이션 버튼 -->
    </div>
	
    <div class="add-btn-wrapper">
    	<c:if test="${memberId != 'guest' }">
        <a class="add-btn" href="<c:url value='/share/shareForm.do' />">✍️ 여행 이야기 공유하기</a>x
        </c:if>
    </div>
</div>

<script>
    const contextPath = '${contextPath}';
    let allList = []; // 전체 리스트
    let filteredList = []; // 필터링된 리스트
    let currentPage = 1;
    let totalPages = 1;
    const pageSize = 5;

    $(document).ready(function () {
        loadShareList();

        $('#sortType').on('change', function () {
            currentPage = 1;
            loadShareList();
        });

        // 검색 버튼 클릭 시
        $('#searchBtn').on('click', function () {
            currentPage = 1;
            searchShareList();
        });

        // 검색 입력 필드에서 엔터 키 눌렀을 때
        $('#searchInput').on('keypress', function (e) {
            if (e.which === 13) { // 엔터 키
                currentPage = 1;
                searchShareList();
            }
        });
    });

    // 게시글 목록을 서버에서 가져오는 함수
    function loadShareList() {
        const sortType = $('#sortType').val();

        $.ajax({
            url: contextPath + '/share/shareListAjax.do',
            method: 'GET',
            data: { sortType: sortType },
            success: function (res) {
                // 서버에서 받아온 데이터에서 `list`만 사용
                allList = res.list;
                filteredList = allList; // 초기 상태에서는 필터링하지 않은 전체 리스트
                totalPages = Math.ceil(filteredList.length / pageSize);
                renderShareList();
                renderPagination();
            },
            error: function (xhr) {
                console.error("에러:", xhr.responseText);
            }
        });
    }

    // 검색 기능
    function searchShareList() {
        // 1. 입력된 검색어를 가져옴
        const searchTerm = $('#searchInput').val().toLowerCase();
        // 2. 검색 기준을 가져옴 (제목 또는 ID)
        const searchCriteria = $('#searchCriteria').val(); 

        // 3. 전체 리스트(allList)에서 선택된 검색 기준에 맞게 필터링
        filteredList = allList.filter(function (item) {
            if (searchCriteria === 'title') {
                // 제목에서 검색어가 포함된 항목을 필터링
                return item.tripShareTitle.toLowerCase().includes(searchTerm);
            } else if (searchCriteria === 'id') {
                // ID에서 검색어가 포함된 항목을 필터링
                return item.memberId.toString().toLowerCase().includes(searchTerm);
            }
            return false;
        });

        // 4. 필터링된 리스트(filteredList)의 전체 페이지 수 계산
        totalPages = Math.ceil(filteredList.length / pageSize);
        
        // 5. 필터링된 리스트를 페이지네이션에 맞춰 렌더링
        renderShareList();
        renderPagination();
    }

    // 게시글 목록을 렌더링하는 함수
    function renderShareList() {
        const container = $('#shareListBody');
        container.empty();

        const start = (currentPage - 1) * pageSize;
        const end = start + pageSize;
        const pageList = filteredList.slice(start, end);

        if (pageList.length === 0) {
            container.append(
                '<div class="no-share-text">' +
                '🗺️ 아직 공유된 여행이 없어요.<br>' +
                '<span>당신의 첫 여행기를 남겨주세요!</span>' +
                '</div>'
            );
            return;
        }

        pageList.forEach(function (item) {
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
                        '<p class="card-meta">👤 ' + item.memberId + '님 · 🗓️ ' + addDate +
                        '<p class="card-updated">최근 수정: ' + modDate + '</p>' +
                    '</div>' +
                '</div>';

            container.append(card);
        });
    }

    // 페이지네이션을 렌더링하는 함수
    function renderPagination() {
        const pagination = $('#pagination');
        pagination.empty();

        // 이전 버튼 생성
        const prevBtn = $('<button class="page-btn prev-btn"></button>').
            text('◀️ 이전').
            addClass(currentPage === 1 ? 'disabled' : '').
            on('click', function () {
                if (currentPage > 1) {
                    currentPage--;
                    renderShareList();
                    renderPagination();
                }
            });

        pagination.append(prevBtn);

        // 페이지 번호 버튼 생성
        for (let i = 1; i <= totalPages; i++) {
            const btn = $('<button class="page-btn"></button>')
                .text(i)
                .on('click', function () {
                    currentPage = i;
                    renderShareList();
                    renderPagination();
                });

            if (i === currentPage) {
                btn.addClass('active');
            }

            pagination.append(btn);
        }

        // 다음 버튼 생성
        const nextBtn = $('<button class="page-btn next-btn"></button>')
            .text('다음 ▶️')
            .addClass(currentPage === totalPages ? 'disabled' : '')
            .on('click', function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    renderShareList();
                    renderPagination();
                }
            });

        pagination.append(nextBtn);
    }

    // 날짜 포맷 함수
    function formatDate(dateStr) {
        if (!dateStr) return '';
        const date = new Date(dateStr);
        return date.toISOString().split('T')[0];
    }
</script>
