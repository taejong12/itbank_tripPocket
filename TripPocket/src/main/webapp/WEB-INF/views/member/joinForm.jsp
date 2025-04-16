<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/resources/css/member/join.css">

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
					<button class="memberJoinCheckBtn" type="button" onclick="fu_sms(this)">인증</button>
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
    
<script type="text/javascript">
	let contextPath = "${contextPath}";
	
	window.fu_sms = function(btn){
		let memberTel = document.getElementById("memberTel");
		let memberTelVal = document.getElementById("memberTel").value.trim();
	   	 
		if(memberTelVal == null || memberTelVal == ""){
			memberTel.focus();
			alert("휴대폰 번호 입력해주세요.");
			return;
		}
		
		fetch(contextPath+"/member/sendSms.do", {
			method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ tel: memberTelVal })
		})
		.then(response => {
			if (!response.ok) {
					throw new Error("sms 인증 응답 에러: " + response.status);
			}
			// JSON 데이터로 변환
			return response.json();
		})
		.then(data => {
			console.log("sms 확인용");
			console.log(data);
			
			if(data){
				
				const container = btn.closest('.input-container.column');
				
				// 중복 추가 방지
			    if (container.querySelector('.auth-code-wrap')) {
			        return;
			    }
				
			    // 인증번호 입력창 생성
			    const authDiv = document.createElement('div');
			    authDiv.className = 'input-btn-wrap';
	
			    const input = document.createElement('input');
			    input.type = 'text';
			    input.placeholder = '인증번호 입력';
	
			    const confirmBtn = document.createElement('button');
			    confirmBtn.type = 'button';
			    confirmBtn.textContent = '확인';
			    
			    confirmBtn.addEventListener("click", function () {
			        const userInput = input.value.trim();

			        if (!userInput) {
			            alert("인증번호를 입력하세요.");
			            return;
			        }

			        fetch(contextPath+"/member/codeDiff.do", {
			            method: "POST",
			            headers: {
			                "Content-Type": "application/x-www-form-urlencoded"
			            },
			            body: new URLSearchParams({ memberCode: userInput })
			        })
			        .then(res => res.json())
			        .then(data => {
			        	
			        	console.log("인증비교반환##");
			        	console.log(data);
			        	console.log(data.result);
			        	
			            if (data.result === true) {
			                alert("인증 성공");
			                input.disabled = true;
			                confirmBtn.disabled = true;

			                // 성공 시 hidden input 추가
			                const hiddenInput = document.createElement("input");
			                hiddenInput.type = "hidden";
			                hiddenInput.name = "isPhoneVerified";
			                hiddenInput.value = "true";
			                container.appendChild(hiddenInput);
			            } else if(data.result === false) {
			                alert("인증 실패. 코드를 다시 확인해주세요.");
			            } else {
			            	alert("인증번호 만료");
			            }
			        })
			        .catch(err => {
			            console.error("인증 확인 중 오류 발생:", err);
			            alert("서버 오류가 발생했습니다.");
			        });
			    });

			    // 조립
			    authDiv.appendChild(input);
			    authDiv.appendChild(confirmBtn);

			    // container에 추가
			    container.appendChild(authDiv);
			}
		})
		.catch(error => {
			console.error("sms 인증 오류 발생: ", error);
		});
	}
</script>
<script src="${contextPath}/resources/js/member/joinForm.js"></script>