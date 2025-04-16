<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 
<link rel="stylesheet" href="${contextPath}/resources/css/popup/tripSearch.css">

<div class="popup-search-form">
	<div class="popup-search-left">
		<div class="trip-search-bar">
			<div>
				<input type="text" name="tripSearchKeyword" id="tripSearchKeyword" placeholder="관광지 검색">
			</div>
			<div>
				<span class="divider">|</span>
			</div>
			<div>
				<select id="tripSearchAreaCode">
					<option value="" selected>통합검색</option>
					<option value="1">서울</option>
					<option value="2">인천</option>
					<option value="3">대전</option>
					<option value="4">대구</option>
					<option value="5">광주</option>
					<option value="6">부산</option>
					<option value="7">울산</option>
					<option value="8">세종특별자치시</option>
					<option value="31">경기도</option>
					<option value="32">강원특별자치도</option>
					<option value="33">충청북도</option>
					<option value="34">충청남도</option>
					<option value="35">경상북도</option>
					<option value="36">경상남도</option>
					<option value="37">전북특별자치도</option>
					<option value="38">전라남도</option>
					<option value="39">제주특별자치도</option>
				</select>
			</div>
			<div class="popup-search-btn-div">	
				<button onclick="fu_tripSearch(event)">
					<img src="${contextPath}/resources/img/search/search_image.png" alt="검색 이미지">
				</button>
			</div>
		</div>
		<div class="popup-close-btn-div">
			<button onclick="fu_closePopup()">✕</button>
		</div>
	</div>
	<div id="tripSearchList"></div>
	<button id="loadMoreBtn">더보기</button>
</div>

<script>
	let contextPath = "${contextPath}";
</script>
<script src="${contextPath}/resources/js/popup/tripSearch.js"></script>
<script>
	const keywordInput = document.getElementById('tripSearchKeyword');
	const areaCodeInput = document.getElementById('tripSearchAreaCode');

	const searchbar = document.querySelector('.trip-search-bar');
	const searchbtn = document.querySelector('.popup-search-btn-div button');
	
	//원래 placeholder 저장해두기
	const keywordPlaceholder = keywordInput.placeholder;
	
	//포커스되면 placeholder 비우기
	keywordInput.addEventListener('focus', () => {
		keywordInput.placeholder = '';
		searchbar.style.backgroundColor = 'white';
		searchbar.style.border = '1px solid black';
		searchbar.style.boxShadow = 'none';
		searchbtn.style.backgroundColor = 'white';
		keywordInput.style.backgroundColor = 'white';
		areaCodeInput.style.backgroundColor = 'white';
	});
	
	//포커스 아웃되면 다시 넣기
	keywordInput.addEventListener('blur', () => {
		keywordInput.placeholder = keywordPlaceholder;
		searchbar.style.backgroundColor = '#f5f5f5';
		searchbar.style.border = 'none';
		searchbar.style.boxShadow = '0 4px 10px rgba(0,0,0,0.1)';
		searchbtn.style.backgroundColor = '#f5f5f5';
		keywordInput.style.backgroundColor = '#f5f5f5';
		areaCodeInput.style.backgroundColor = '#f5f5f5';
	});
	
	keywordInput.addEventListener('keydown', (e) => {
		if (e.key === 'Enter') {
			fu_tripSearch(event);
		}
	});
</script>
