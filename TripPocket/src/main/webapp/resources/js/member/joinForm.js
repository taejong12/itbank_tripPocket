var isMemberIdValid = false;
var isEmailValid = false;

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
    if (form.memberPwd.value.trim() === "") {
        alert("비밀번호를 입력해 주세요.");
        form.memberPwd.focus();
        return false;
    }

    // 이름
    if (form.memberName.value.trim() === "") {
        alert("이름을 입력해 주세요.");
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
    if (isNaN(age) || age <= 0 || age >= 100) {
        alert("유효한 나이를 입력해 주세요.");
        form.memberAge.focus();
        return false;
    }

    // 닉네임
    if (form.memberNickname.value.trim() === "") {
        alert("닉네임을 입력해 주세요.");
        form.memberNickname.focus();
        return false;
    }

    // 전화번호
    var tel = form.memberTel.value.trim();
    if (!/^\d{10,11}$/.test(tel)) {
        alert("전화번호는 숫자만 10~11자리 입력해 주세요.");
        form.memberTel.focus();
        return false;
    }

    // 성별
    if (!form.memberGender.value) {
        alert("성별을 선택해 주세요.");
        return false;
    }
   
   alert("회원가입이 완료되었습니다!\n로그인 후 서비스를 이용해 주세요.");
   
    // 제출
    form.submit();
}
