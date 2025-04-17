<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/join.css">

<!-- Firebase App (필수) -->
<script src="https://www.gstatic.com/firebasejs/11.6.0/firebase-app-compat.js"></script>
<!-- Firebase Authentication (전화번호 인증용) -->
<script src="https://www.gstatic.com/firebasejs/11.6.0/firebase-auth-compat.js"></script>
<!-- Firebase Analytics (선택사항) -->
<script src="https://www.gstatic.com/firebasejs/11.6.0/firebase-analytics-compat.js"></script>

    <div class="container">
        <p class="form-title">Sign up</p>
        <form name="joinForm" method="post" action="${contextPath}/member/join.do" onsubmit="fn_joinForm(event);">
            <div class="input-container column">
            	<p>아이디</p>
            	<div class="input-btn-wrap">
                <input type="text" name="memberId" placeholder="아이디를 입력하세요">
                <button id="checkBtn" type="button" name="memberIdCheck" class="memberJoinCheckBtn" onclick="fn_memberIdCheck()">중복확인</button>
            	</div>
            </div>
            <div class="input-container column">
            	<p>비밀번호</p>
                <input type="password" name="memberPwd" placeholder="비밀번호를 입력하세요">
            </div>
            <div class="input-container column">
            	<p>이름</p>
                <input type="text" name="memberName" placeholder="이름을 입력하세요">
            </div>
            <div class="input-container column">
            	<p>이메일</p>
                <input type="email" name="memberEmail" placeholder="이메일을 입력하세요">
            </div>
            <div class="input-container column">
            	<p>나이</p>
                <input type="text" name="memberAge" placeholder="나이를 입력하세요">
            </div>
            <div class="input-container column">
            	<p>닉네임</p>
                <input type="text" name="memberNickname" placeholder="닉네임을 입력하세요">
            </div>
            <div class="input-container column">
	            <p>휴대전화번호</p>
            	<div class="input-btn-wrap">
	                <input type="tel" name="memberTel" id="memberTel" placeholder="예: 01012345678">
					<button class="memberJoinCheckBtn" type="button" onclick="fu_sendSMS(this)">인증</button>
            	</div>
            </div>
            <div class="gender-container">
                <label><input type="radio" name="memberGender" value="남자"><span></span> 남자</label>
                <label><input type="radio" name="memberGender" value="여자"><span></span> 여자</label>
            </div>
            <div class="button-container">
                <button type="submit">회원가입</button>
            </div>
        </form>
    </div>
    
<!-- recaptcha 영역 -->
<div id="recaptcha-container"></div>

<script type="text/javascript">

	let contextPath = "${contextPath}";

	//Firebase 설정
	const firebaseConfig = {
		apiKey: "AIzaSyCnFapPUvfjLNot2A0LIg3nY5HK1abF4Wg",
		authDomain: "trippocket-21bfa.firebaseapp.com",
		projectId: "trippocket-21bfa",
		storageBucket: "trippocket-21bfa.appspot.com",
		messagingSenderId: "1041108579388",
		appId: "1:1041108579388:web:28d3ea8f80b4097843ff39",
		measurementId: "G-747WZ4ZMQJ"
	};

	// Firebase 초기화
	firebase.initializeApp(firebaseConfig);
	firebase.analytics();
	
	let confirmationResult = null;
	
	// 인증발송
	window.fu_sendSMS = function(btn){
		const memberTel = document.getElementById("memberTel");
		const memberTelVal = document.getElementById("memberTel").value.trim();
	   	 
		if(memberTelVal == null || memberTelVal == ""){
			memberTel.focus();
			alert("휴대폰 번호 입력해주세요.");
			return;
		}
		
		const appVerifier = new firebase.auth.RecaptchaVerifier('recaptcha-container', {
			size: 'invisible',
			callback: function(response) {
				console.log("reCAPTCHA 성공");
			}
		});
		
		// Firebase는 국가 코드 포함된 국제전화 형식만 인식
		const formattedPhone = memberTelVal.replace(/^0/, '+82');
		
		console.log("formattedPhone: "+formattedPhone);
		
		firebase.auth().signInWithPhoneNumber(formattedPhone, appVerifier)
		.then(result => {
			confirmationResult = result;
			alert("인증번호 전송 완료");
			
			const container = btn.closest('.input-container.column');
			
			// 중복 추가 방지
		    if (container.querySelector('.input-btn-wrap')) {
		        return;
		    }
			
		    // 인증번호 입력창 생성
		    const authDiv = document.createElement('div');
		    authDiv.className = 'input-btn-wrap';

		    const authInput = document.createElement('input');
		    authInput.type = 'text';
		    authInput.placeholder = '인증번호 입력';

		    const confirmBtn = document.createElement('button');
		    confirmBtn.type = 'button';
		    confirmBtn.textContent = '확인';
		    
		 	// 인증확인
		    confirmBtn.addEventListener("click", function () {
		        const memberAuthInput = authInput.value.trim();

		        if (!memberAuthInput) {
		            alert("인증번호를 입력하세요.");
		            return;
		        }
	    		
    			confirmationResult.confirm(memberAuthInput)
    			.then(result => {
    				
    				console.log("사용자 정보:"+ result.user);
    				console.log("result:"+ result);
    				
    				input.disabled = true;
	                confirmBtn.disabled = true;

	                // 성공 시 hidden input 추가
	                const hiddenAuthInput = document.createElement("input");
	                hiddenAuthInput.type = "hidden";
	                hiddenAuthInput.name = "isPhoneVerified";
	                hiddenAuthInput.value = "true";
	                container.appendChild(hiddenAuthInput);
    				
    				alert("인증 성공");
    			})
    			.catch(error => {
    				console.error("인증 에러: "+error);
    			});
		    });

		    authDiv.appendChild(authInput);
		    authDiv.appendChild(confirmBtn);

		    container.appendChild(authDiv);
		})
		.catch(error => {
			console.error("인증번호 전송 에러:", error.message);
		});
	}
</script>
<script src="${contextPath}/resources/js/member/joinForm.js"></script>




