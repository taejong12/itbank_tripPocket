<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${share.tripShareTitle} - 여행 상세</title>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0013492b2b76abad18e946130e719814&libraries=services"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/tripShare/shareDetail.css">
</head>
<body>
<div class="container">
    <h1>${share.tripShareTitle}</h1>
    <div class="meta">
        <span><strong>작성자:</strong> ${share.memberId}</span>
        <span><strong>여행 기간:</strong>
            <fmt:formatDate value="${share.tripPlanStartDay}" pattern="yyyy-MM-dd" /> ~
            <fmt:formatDate value="${share.tripPlanArriveDay}" pattern="yyyy-MM-dd" />
        </span>
        <span><strong>조회수:</strong> ${share.tripShareViewCount}</span>
        <span><strong>불러오기수:</strong> ${share.tripShareShareCount}</span>
    </div>

    <!-- Day 탭 -->
    <div class="day-tab" id="dayTabs">
        <c:set var="days" value=""/>
        <c:forEach var="day" items="${share.tripShareContentList}">
            <c:if test="${not fn:contains(days, day.tripShareDayDay)}">
                <button class="day-tab-btn" onclick="showDay(${day.tripShareDayDay}, this)">Day ${day.tripShareDayDay}</button>
                <c:set var="days" value="${days}${day.tripShareDayDay},"/>
            </c:if>
        </c:forEach>
    </div>

    <!-- Day별 콘텐츠 -->
    <c:forEach var="i" begin="1" end="10">
        <c:set var="hasContent" value="false" />
        <c:forEach var="day" items="${share.tripShareContentList}">
            <c:if test="${day.tripShareDayDay == i}">
                <c:set var="hasContent" value="true" />
            </c:if>
        </c:forEach>
        <c:if test="${hasContent}">
            <div class="trip-day" id="trip-day-${i}">
                <div id="map-${i}" class="map"></div>
                <c:forEach var="day" items="${share.tripShareContentList}">
                    <c:if test="${day.tripShareDayDay == i}">
                        <div class="location-card">
                            <h3>Day ${day.tripShareDayDay} - ${day.tripShareDayPlace}</h3>
                            <p>${day.tripShareDayAddress}</p>
                            <c:if test="${not empty day.tripShareDayImage}">
                                <img src="${day.tripShareDayImage}" alt="여행 이미지" />
                            </c:if>
								<div class="review-content">
								<c:if test="${not empty day.tripShareContent}">
								${day.tripShareContent}
								</c:if>
								</div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>
    </c:forEach>

    <!-- 버튼 -->
    <div class="button-container">
        <a class="back-link" href="${contextPath}/share/myShare.do">← 나의 여행 글쓰기로</a>
        <c:if test="${share.memberId ne member.memberId}">
            <a class="fetch-button" href="${contextPath}/share/shareImport.do?tripShareId=${share.tripShareId}&tripPlanId=${share.tripPlanId}">
                <span class="plus-button">+</span> 내 여행 계획에 추가하기
            </a>
        </c:if>
    </div>

    <!-- 댓글 -->
    <div class="comment-section">
        <h2>댓글을 남겨주세요</h2>
        <textarea id="commentContent" placeholder="당신의 여행 경험을 공유해주세요..." required></textarea>
        <button type="button" onclick="submitComment()">댓글 작성</button>

        <div class="comment-list" id="commentList">
            <c:forEach var="comment" items="${commentList}">
                <div class="comment-item" data-id="${comment.commentId}">
                    <strong>${comment.memberId}님</strong>
                    <p class="comment-text">${comment.commentContent}</p>
                    <small><fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></small>
                    
                    <c:if test="${comment.memberId eq member.memberId}">
                        <div class="edit-delete-buttons">
                            <a class="edit" href="#" onclick="editComment(${comment.commentId}, this); return false;">수정</a>
							<a class="delete" href="#" onclick="deleteComment(${comment.commentId}); return false;">삭제</a>
                         </div>
                    </c:if>
                    
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
    // JavaScript 코드
    const groupedDays = {};
    const tempList = [];
    <c:forEach var="day" items="${share.tripShareContentList}">
        tempList.push({
            d: ${day.tripShareDayDay},
            x: "${day.tripShareDayMapx}",
            y: "${day.tripShareDayMapy}",
            place: "${fn:escapeXml(day.tripShareDayPlace)}"
        });
    </c:forEach>
    tempList.forEach(d => {
        if (!groupedDays[d.d]) groupedDays[d.d] = [];
        groupedDays[d.d].push({ x: d.x, y: d.y, place: d.place });
    });

    function showDay(dayNum, btn) {
        document.querySelectorAll(".trip-day").forEach(d => d.classList.remove("active"));
        document.getElementById("trip-day-" + dayNum).classList.add("active");
        document.querySelectorAll(".day-tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        setTimeout(() => loadMap(dayNum), 100);
    }

    function loadMap(dayNum) {
        const mapContainer = document.getElementById("map-" + dayNum);
        if (!mapContainer || mapContainer.innerHTML !== "") return;

        const points = groupedDays[dayNum];
        if (!points || points.length === 0) return;

        const bounds = new kakao.maps.LatLngBounds();
        const path = [];
        const map = new kakao.maps.Map(mapContainer, {
            center: new kakao.maps.LatLng(points[0].y, points[0].x),
            level: 6
        });

        points.forEach((p, idx) => {
            const latlng = new kakao.maps.LatLng(p.y, p.x);
            bounds.extend(latlng);
            path.push(latlng);
            const marker = new kakao.maps.Marker({ position: latlng, map: map });
            const info = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;font-size:14px;">' + (idx + 1) + '. ' + p.place + '</div>'
            });
            info.open(map, marker);
        });

        if (path.length > 1) {
            new kakao.maps.Polyline({
                path: path,
                strokeWeight: 3,
                strokeColor: '#007BFF',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                map: map
            });
        }
        map.setBounds(bounds);
    }

    window.onload = function () {
        const firstBtn = document.querySelector(".day-tab-btn");
        if (firstBtn) firstBtn.click();
    };

    function submitComment() {
        const content = $("#commentContent").val().trim();
        if (!content) return alert("댓글 내용을 입력해주세요.");
        $.ajax({
            type: "POST",
            url: "${contextPath}/share/commentAdd",
            data: {
                tripShareId: "${share.tripShareId}",
                commentContent: content,
                memberId: "${member.memberId}" // memberId를 추가
            },
            success: function(response) {
                if (response.status === "success") {
                    location.reload(); // 새로고침으로 반영
                } else {
                    alert("댓글 등록 실패");
                }
            }
        });
    }

    function deleteComment(commentId) {
        console.log("Deleting comment with ID:", commentId);  // 확인용 로그
        if (!confirm("댓글을 삭제하시겠습니까?")) return;
        $.ajax({
            type: "POST",
            url: "${contextPath}/share/commentDel.do",  // URL 확인
            data: { commentId: commentId },
            success: function(response) {
                console.log(response);  // 서버 응답 확인
                if (response.status === "success") {
                    location.reload();  // 새로고침으로 반영
                } else {
                    alert("삭제 실패");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error occurred:", status, error);  // 오류 로그
            }
        });
    }

    function editComment(commentId, btn) {
        const item = $(btn).closest(".comment-item");
        const original = item.find(".comment-text");
        const originalText = original.text();
        const textarea = $("<textarea>").val(originalText).css("width", "100%");
        original.replaceWith(textarea);
        const saveBtn = $("<a>").text("저장").attr("href", "#").click(function () {
            const newText = textarea.val().trim();
            if (!newText) return alert("내용을 입력해주세요.");
            $.ajax({
                type: "POST",
                url: "${contextPath}/share/commentMod.do",
                data: {
                    commentId: commentId,
                    commentContent: newText,
                },
                success: function(response) {
                    if (response.status === "success") {
                        location.reload();
                    } else {
                        alert("수정 실패");
                    }
                }
            });
        });
        $(btn).hide();
        $(btn).parent().append(saveBtn);
    }
</script>
</body>
</html>
