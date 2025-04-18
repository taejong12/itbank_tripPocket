<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/findIdForm.css">
<script src="${contextPath}/resources/js/common/back/formReset.js"></script>

<form name="findIdForm">
	<div class="find-id-form-wrap">
		<h2>아이디 찾기</h2>
		<p class="find-id-text">본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
		<hr>
		<div class="find-id-form-div">
			<div class="find-id-name-wrap">
				<div class="name-label">이름</div>
				<div>
					<input type="text" id="memberName" name="memberName" placeholder="이름 입력">
				</div>
			</div>
			<div class="find-id-email-wrap">
				<div class="email-label">이메일</div>
				<div class="send-mail-wrap">
					<input type="email" id="memberEmail" name="memberEmail"  placeholder="이메일 입력">
					<button type="button" class="send-mail-btn" onclick="fu_findIdSendMail(this)">인증전송</button>
				</div>
			</div>
		</div>
		<div class="find-id-button-wrap">
			<button type="button" class="find-id-btn" onclick="fu_findIdBtn(event)">아이디 찾기</button>
		</div>
	</div>
</form>

<script>
	
	let contextPath = "${contextPath}";
	let memberNameCheck = null;
	
	window.fu_findIdSendMail = function(sendMailBtn){
		const memberName = document.getElementById('memberName');
		const memberEmail = document.getElementById('memberEmail');
		const nameVal = memberName.value.trim();
		const emailVal = memberEmail.value.trim();
		
		if(nameVal == '' || nameVal == null || nameVal.length == 0){
			memberName.focus();
			alert("이름을 입력해주세요.");
			return;
		}
		
		if(emailVal == '' || emailVal == null || emailVal.length == 0){
			memberEmail.focus();
			alert("이메일을 입력해주세요.");
			return;
		}
		
		fetch(contextPath+"/member/sendFindIdAuthMail.do", {
			method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ memberEmail: emailVal, memberName:nameVal })
		})
		.then(response => {
			if (!response.ok) {
				throw new Error("메일 전송 응답 에러: " + response.status);
			}
			
			return response.json();
		})
		.then(data => {
			
			alert(data.msg);
			
			if(data.result == true){
				const container = sendMailBtn.closest('.find-id-email-wrap');
				const findIdFormDiv = document.querySelector('.find-id-form-div');
				
				// 중복 추가 방지
			    if (container.querySelector('.mail-auth-wrap')) {
			        return;
			    }
				
			    // 인증번호 입력창 생성
			    const findIdemailAuthWrap = document.createElement('div');
			    findIdemailAuthWrap.className = 'find-id-email-auth-wrap';
			    
			    const mailAuthLabelDiv = document.createElement('div');
			    mailAuthLabelDiv.className = 'email-auth-label';
			    mailAuthLabelDiv.textContent = '인증번호';
			    
			    const mailAuthDiv = document.createElement('div');
			    mailAuthDiv.className = 'mail-auth-wrap';
	
			    const mailAuthInput = document.createElement('input');
			    mailAuthInput.id = 'emailAuthCode';
			    mailAuthInput.type = 'text';
			    mailAuthInput.placeholder = '인증번호 입력';
	
			    const authCodeConfirmBtn = document.createElement('button');
			    authCodeConfirmBtn.classList.add("mail-auth-btn");
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
			        	
			        	console.log(data);
			        	console.log(data.result);
			        	
			            if (data.result === true) {
			                alert(data.msg);
			                mailAuthInput.readOnly  = true;
			                mailAuthInput.style.backgroundColor = '#f0f0f0';
			                authCodeConfirmBtn.disabled = true;
			                authCodeConfirmBtn.style.backgroundColor = '#f0f0f0';
			                memberEmail.readOnly  = true;
			                memberEmail.style.backgroundColor = '#f0f0f0';
			                sendMailBtn.disabled = true;
			                sendMailBtn.style.backgroundColor = '#f0f0f0';
			                
			                timerDiv.remove();
			                
			                memberNameCheck = nameVal;
			                
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

			    findIdemailAuthWrap.appendChild(mailAuthLabelDiv);
			    findIdemailAuthWrap.appendChild(mailAuthDiv);
			    findIdemailAuthWrap.appendChild(timerDiv);
			    
			    findIdFormDiv.appendChild(findIdemailAuthWrap);
			    
			    startTimer();
			}
		})
		.catch(error => {
			console.error("메일 전송 오류 발생: ", error);
		});
	}
	
	window.fu_findIdBtn = function(event){
		
		event.preventDefault();
		
		const findIdForm = document.findIdForm;
		
		const nameVal = findIdForm.memberName.value.trim();
		const emailVal = findIdForm.memberEmail.value.trim();
		const mailAuth = findIdForm.querySelector('input[name="mailAuthSuccess"]');
		
		if(nameVal == '' || nameVal == null || nameVal.length == 0){
			findIdForm.memberName.focus();
			alert("이름을 입력해주세요.");
			return;
		}
		
		if(emailVal == '' || emailVal == null || emailVal.length == 0){
			findIdForm.memberEmail.focus();
			alert("이메일을 입력해주세요.");
			return;
		}
		
		if(!mailAuth || mailAuth.value !== 'true' || mailAuth.length == 0){
			findIdForm.memberEmail.focus();
			alert("이메일 인증해주세요.");
		    return;
		}
		
		if(nameVal != memberNameCheck){
			findIdForm.memberName.focus();
			alert("인증한 이름과 다릅니다. 수정해주세요.");
			return;
		}
		
		findIdForm.method="post";
		findIdForm.action= contextPath+"/member/findIdList.do";
		findIdForm.submit();
		
	}
</script>