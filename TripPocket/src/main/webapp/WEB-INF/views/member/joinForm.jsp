<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/join.css">
<script src="${contextPath}/resources/js/common/back/formReset.js"></script>

    <div class="container">
        <p class="form-title">Sign up</p>
        <form name="joinForm" method="post" action="${contextPath}/member/join.do" onsubmit="fn_joinForm(event);">
            <div class="input-container column">
            	<p>아이디</p>
            	<div class="input-btn-wrap">
	                <input type="text" name="memberId" placeholder="아이디를 입력하세요">
	                <button class="memberJoinCheckBtn" id="checkBtn" type="button" name="memberIdCheck" onclick="fn_memberIdCheck()">중복확인</button>
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
                <div class="input-btn-wrap">
                	<input type="email" id="memberEmail" name="memberEmail" placeholder="이메일을 입력하세요">
					<button class="memberJoinCheckBtn" type="button" onclick="fu_sendAuthMail(this)">인증전송</button>
            	</div>
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
                <input type="tel" name="memberTel" id="memberTel" placeholder="예: 01012345678">
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
<script type="text/javascript">
	let contextPath = "${contextPath}";
	
	window.fu_sendAuthMail = function(sendMailBtn){
		
		const containerDiv = sendMailBtn.closest('.input-container.column');
		const isMailAuthDiv = containerDiv.querySelector('.mail-auth-btn-wrap');
		
		if(isMailAuthDiv){
			isMailAuthDiv.remove();
		}
		
		let memberMail = document.getElementById("memberEmail");
		let memberMailVal = memberMail.value.trim();
	   	 
		if(memberMailVal == null || memberMailVal == ""){
			memberMail.focus();
			alert("이메일을 입력해주세요.");
			return;
		}
		
		fetch(contextPath+"/member/sendAuthMail.do", {
			method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ memberMail: memberMailVal })
		})
		.then(response => {
			if (!response.ok) {
					throw new Error("메일 전송 응답 에러: " + response.status);
			}
			// JSON 데이터로 변환
			return response.json();
		})
		.then(data => {
			
			alert(data.msg);
			
			if(data.result == true){
				const container = sendMailBtn.closest('.input-container.column');
				
				// 중복 추가 방지
			    if (container.querySelector('.mail-auth-btn-wrap')) {
			        return;
			    }
				
			    // 인증번호 입력창 생성
			    const mailAuthDiv = document.createElement('div');
			    mailAuthDiv.className = 'mail-auth-btn-wrap';
	
			    const mailAuthInput = document.createElement('input');
			    mailAuthInput.type = 'text';
			    mailAuthInput.placeholder = '인증번호 입력';
	
			    const authCodeConfirmBtn = document.createElement('button');
			    authCodeConfirmBtn.classList.add("memberJoinCheckBtn");
			    authCodeConfirmBtn.type = 'button';
			    authCodeConfirmBtn.textContent = '확인';
			    
			 	// 타이머 표시 요소 생성
			    const timerDiv = document.createElement('div');
			    timerDiv.className = 'timer';
			    timerDiv.style.marginTop = '8px';
			    timerDiv.style.fontSize = '14px';
			    timerDiv.style.color = 'red';

				// 3분 (180초)
			    let timeLeft = 180;
			    
				const startTimer = () => {
					const timerInterval = setInterval(() => {
						let minutes = String(Math.floor(timeLeft / 60)).padStart(2, '0');
						let seconds = String(timeLeft % 60).padStart(2, '0');
						timerDiv.textContent = minutes+":"+seconds;

						if (timeLeft <= 0) {
							clearInterval(timerInterval);
							alert("인증시간초과");
							 // 필요하다면 입력 비활성화 등 추가 처리
							mailAuthInput.disabled = true;
							authCodeConfirmBtn.disabled = true;
						}
	
						timeLeft--;
					}, 1000);
				};
			    
				authCodeConfirmBtn.addEventListener("click", function () {
			        const mailAuthCode = mailAuthInput.value.trim();

			        if (!mailAuthCode) {
			            alert("인증번호를 입력하세요.");
			            return;
			        }

			        fetch(contextPath+"/member/authCodeConfirm.do", {
			            method: "POST",
			            headers: {
			                "Content-Type": "application/x-www-form-urlencoded"
			            },
			            body: new URLSearchParams({ memberAuthCode: mailAuthCode })
			        })
			        .then(res => res.json())
			        .then(data => {
			        	
			            if (data.result === true) {
			                alert(data.msg);
			                mailAuthInput.readOnly  = true;
			                mailAuthInput.style.backgroundColor = '#f0f0f0';
			                authCodeConfirmBtn.disabled = true;
			                authCodeConfirmBtn.style.backgroundColor = '#f0f0f0';
			                memberMail.readOnly  = true;
			                memberMail.style.backgroundColor = '#f0f0f0';
			                sendMailBtn.disabled = true;
			                sendMailBtn.style.backgroundColor = '#f0f0f0';
			                
			                timerDiv.remove();
			                
			                // 성공 시 hidden input 추가
			                const mailAuthSuccess = document.createElement("input");
			                mailAuthSuccess.type = "hidden";
			                mailAuthSuccess.name = "mailAuthSuccess";
			                mailAuthSuccess.value = "true";
			                container.appendChild(mailAuthSuccess);
			            } else {
			            	alert(data.msg);
			            } 
			        })
			        .catch(err => {
			            console.error("메일 인증 오류 발생:", err);
			        });
			    });

			    mailAuthDiv.appendChild(mailAuthInput);
			    mailAuthDiv.appendChild(authCodeConfirmBtn);
			    mailAuthDiv.appendChild(timerDiv);

			    container.appendChild(mailAuthDiv);
			    
			    startTimer();
			}
		})
		.catch(error => {
			console.error("메일 인증 오류 발생: ", error);
		});
	}
</script>
<script src="${contextPath}/resources/js/member/joinForm.js"></script>