// 아이디 중복 체크
function fn_memberIdCheck() {
    var memberId = document.joinForm.memberId.value.trim();
    var specialCharPattern = /[!@#$%^&*(),.?":{}|<>]/g;

    if (memberId === "") {
        alert("아이디를 입력해 주세요.");
        return false;
    }
    if (specialCharPattern.test(memberId)) {
        alert("아이디에 특수 문자를 사용할 수 없습니다.");
        return false;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", contextPath + "/member/memberIdCheck.do?memberId=" + encodeURIComponent(memberId), false); // 동기 처리
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.send();
    var responseText = xhr.responseText.trim();
    if (responseText === "OK") {
        alert("사용 가능한 아이디입니다.");
        isMemberIdValid = true;
        return true;
    } else {
        alert("중복된 아이디입니다. 다른 아이디를 입력해 주세요.");
        isMemberIdValid = false;
        return false;
    }
}

// 이메일 중복 체크
function fn_emailCheck() {
    var memberEmail = document.joinForm.memberEmail.value.trim();
    if (memberEmail === "") {
        alert("이메일을 입력해 주세요.");
        return false;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", contextPath + "/member/memberEmailCheck.do?memberEmail=" + encodeURIComponent(memberEmail), false); // 동기 처리
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.send();
    var responseText = xhr.responseText.trim();
    if (responseText === "OK") {
        isEmailValid = true;
        return true;
    } else {
        alert("중복된 이메일입니다. 다른 이메일을 입력해 주세요.");
        isEmailValid = false;
        return false;
    }
}

// 입력값 변경 시 유효성 초기화
document.addEventListener("DOMContentLoaded", function () {
    document.joinForm.memberId.addEventListener("input", function () {
        isMemberIdValid = false;
    });
    document.joinForm.memberEmail.addEventListener("input", function () {
        isEmailValid = false;
    });
});

// 최종 제출 처리
function fn_joinForm(event) {
    event.preventDefault();
    var form = document.joinForm;

    // 아이디 검증
    if (form.memberId.value.trim() === "") {
        alert("아이디를 입력해 주세요.");
        form.memberId.focus();
        return false;
    }
    // 사용자가 직접 버튼 눌러야만 통과
   if (!isMemberIdValid) {
       alert("아이디 중복 확인을 먼저 해주세요.");
       return false;
   }

    // 비밀번호
    const password = form.memberPwd.value.trim();
	const specialCharPattern = /[!@#$%^&*(),.?":{}|<>]/;
	
	if (password === "" || password.length < 8 || !specialCharPattern.test(password)) {
	    alert("비밀번호는 최소 8자 이상, 특수문자(예: !, @, #, $ 등)를 포함해 주세요.");
	    form.memberPwd.focus();
	    return false;
	}

    // 이름
    var name = form.memberName.value.trim();
	if (name === "") {
	    alert("이름을 입력해 주세요.");
	    form.memberName.focus();
	    return false;
	}
	var namePattern = /^[가-힣a-zA-Z\s]+$/;
	if (!namePattern.test(name)) {
	    alert("이름은 한글 또는 영어만 입력해 주세요.");
	    form.memberName.focus();
	    return false;
	}

    // 이메일
    if (form.memberEmail.value.trim() === "") {
        alert("이메일을 입력해 주세요.");
        form.memberEmail.focus();
        return false;
    }
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailPattern.test(form.memberEmail.value)) {
        alert("정확한 이메일을 입력해 주세요.");
        form.memberEmail.focus();
        return false;
    }
    if (!isEmailValid && !fn_emailCheck()) return false;

    // 나이
    var age = parseInt(form.memberAge.value.trim(), 10);

	if (!form.memberAge.value.trim()) {
	    alert("나이를 입력해 주세요.");
	    form.memberAge.focus();
	    return false;
	}
	
	if (isNaN(age) || age < 19 || age > 65) {
	    alert("가입은 19세 이상 65세 이하만 가능합니다.");
	    form.memberAge.focus();
	    return false;
	}

    // 닉네임
	var nickname = form.memberNickname.value.trim();
	if (nickname === "") {
	    alert("닉네임을 입력해 주세요.");
	    form.memberNickname.focus();
	    return false;
	}
	
	// 1단계: 전체 허용 문자 체크 (한글, 영어, 숫자, 공백만)
	var nicknamePattern = /^[가-힣a-zA-Z0-9 ]+$/;
	if (!nicknamePattern.test(nickname)) {
	    alert("닉네임은 한글, 영어, 숫자 사용할 수 있어요. (특수문자 불가)");
	    form.memberNickname.focus();
	    return false;
	}
	
	// 2단계: 의미 있는 글자 존재 체크 (한글, 영어, 숫자 중 하나 이상)
	var meaningfulPattern = /[가-힣a-zA-Z0-9]/;
	if (!meaningfulPattern.test(nickname)) {
	    alert("닉네임에는 (공백포함) 한글, 영어, 숫자 중 하나 이상이 포함되어야 해요.");
	    form.memberNickname.focus();
	    return false;
	}

    // 전화번호
    var tel = form.memberTel.value.trim();
	var telPattern = /^010-\d{4}-\d{4}$/;
	
	if (!telPattern.test(tel)) {
	    alert("전화번호 형식을 확인해 주세요.\n(예: 010-1234-5678)");
	    form.memberTel.focus();
	    return false;
	}

    // 성별
    if (!form.memberGender.value) {
        alert("성별을 선택해 주세요.");
        return false;
    }
   
   alert("회원가입이 완료되었습니다!\n로그인 후 Trip Pocket을 이용해 주세요.");
   
    // 제출
	form.action = "join.do";
    form.submit();
}

// 휴대전화번호 자동 하이픈 삽입 + 최대 11자리 숫자 제한
document.addEventListener("DOMContentLoaded", function () {
    const telInput = document.querySelector("input[name='memberTel']");

    if (telInput) {
        telInput.addEventListener("input", function () {
            let value = this.value.replace(/\D/g, ""); // 숫자만 추출
            if (value.length > 11) value = value.slice(0, 11); // 11자리 초과 방지

            if (value.length <= 3) {
                this.value = value;
            } else if (value.length <= 7) {
                this.value = value.replace(/(\d{3})(\d+)/, "$1-$2");
            } else {
                this.value = value.replace(/(\d{3})(\d{4})(\d{0,4})/, "$1-$2-$3");
            }
        });
    }
});