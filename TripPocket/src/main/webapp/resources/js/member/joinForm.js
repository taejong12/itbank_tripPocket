var isMemberIdValid = false; // 아이디 유효성 여부
var isEmailValid = false;    // 이메일 유효성 여부

// 아이디 중복 체크 함수 (중복 확인 버튼에서만 호출)
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
    xhr.open("GET", contextPath + "/member/memberIdCheck.do?memberId=" + encodeURIComponent(memberId), true); // 비동기 요청
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var responseText = xhr.responseText.trim();
            if (responseText === "OK") {
                alert("사용 가능한 아이디입니다.");
                isMemberIdValid = true; // 중복 확인 완료
            } else {
                alert("중복된 아이디입니다. 다른 아이디를 입력해 주세요.");
                document.joinForm.memberId.focus();
                isMemberIdValid = false;
            }
        }
    };
    xhr.send();
}

// 이메일 중복 체크 함수
function fn_emailCheck() {
    var memberEmail = document.joinForm.memberEmail.value.trim();
    if (memberEmail === "") {
        alert("이메일을 입력해 주세요.");
        return false;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", contextPath + "/member/memberEmailCheck.do?memberEmail=" + encodeURIComponent(memberEmail), true); // 비동기 요청
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var responseText = xhr.responseText.trim();
            if (responseText === "OK") {
                isEmailValid = true;
            } else {
                alert("중복된 이메일입니다. 다른 이메일을 입력해 주세요.");
                document.joinForm.memberEmail.focus();
                isEmailValid = false;
            }
        }
    };
    xhr.send();
}

// DOMContentLoaded 이벤트 리스너 추가
document.addEventListener("DOMContentLoaded", function () {
    document.joinForm.memberId.addEventListener("input", function () {
        isMemberIdValid = false; // 아이디 입력 시 유효성 초기화
    });
});

// 폼 제출 시 유효성 검사
function fn_joinForm(event) {
    event.preventDefault(); // 폼 제출 방지
    var form = document.joinForm;

    // 아이디 중복 확인 여부 확인
    if (!isMemberIdValid) {
        alert("아이디 중복 확인을 해주세요.");
        form.memberId.focus();
        return false;
    }

    // 비밀번호 검증
    if (form.memberPwd.value.trim() === "") {
        alert("비밀번호를 입력해 주세요.");
        form.memberPwd.focus();
        return false;
    }

    // 이름 검증
    if (form.memberName.value.trim() === "") {
        alert("이름을 입력해 주세요.");
        form.memberName.focus();
        return false;
    }

    // 이메일 검증
    if (form.memberEmail.value.trim() === "") {
        alert("이메일을 입력해 주세요.");
        form.memberEmail.focus();
        return false;
    } else {
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if (!emailPattern.test(form.memberEmail.value)) {
            alert("정확한 이메일을 입력해 주세요.");
            form.memberEmail.focus();
            return false;
        }
    }

    if (!isEmailValid) {
        fn_emailCheck(); // 이메일 중복 확인
    }

    // 나이 검증
    if (form.memberAge.value.trim() === "") {
        alert("나이를 입력해 주세요.");
        form.memberAge.focus();
        return false;
    } else {
        var age = parseInt(form.memberAge.value, 10);
        if (isNaN(age) || age <= 0 || age >= 100) {
            alert("유효한 나이를 입력해 주세요.");
            form.memberAge.focus();
            return false;
        }
    }

    // 닉네임 검증
    if (form.memberNickname.value.trim() === "") {
        alert("닉네임을 입력해 주세요.");
        form.memberNickname.focus();
        return false;
    }

    // 전화번호 검증
    if (form.memberTel.value.trim() === "") {
        alert("휴대전화번호를 입력해 주세요.");
        form.memberTel.focus();
        return false;
    } else {
        var telPattern = /^\d{10,11}$/;
        if (!telPattern.test(form.memberTel.value)) {
            alert("유효한 전화번호를 입력해 주세요. 숫자만 입력해 주세요.");
            form.memberTel.focus();
            return false;
        }
    }

    // 성별 검증
    if (!form.memberGender.value) {
        alert("성별을 선택해 주세요.");
        return false;
    }

    form.submit(); // 모든 검증 통과 시 폼 제출
}