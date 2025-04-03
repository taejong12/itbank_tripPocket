/**
 * 
 */
 var isMemberIdValid = false;

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
    xhr.open("GET", "${contextPath}/member/memberIdCheck.do?memberId=" + encodeURIComponent(memberId), false);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var responseText = xhr.responseText.trim();
            if (responseText === "OK") {
                alert("사용 가능한 아이디입니다.");
                isMemberIdValid = true;
            } else {
                alert("중복된 아이디입니다. 다른 아이디를 입력해 주세요.");
                document.joinForm.memberId.focus();
                isMemberIdValid = false;
            }
        }
    };
    xhr.send();
    return isMemberIdValid;
}

function fn_emailCheck() {
    var memberEmail = document.joinForm.memberEmail.value.trim();
    if (memberEmail === "") {
        alert("이메일을 입력해 주세요.");
        return false;
    }
    
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "${contextPath}/member/memberEmailCheck.do?memberEmail=" + encodeURIComponent(memberEmail), false);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    
    xhr.onreadystatechange = function() {
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
    return isEmailValid;
}

document.addEventListener("DOMContentLoaded", function() {
    document.joinForm.memberId.addEventListener("input", function() {
        isMemberIdValid = false;
    });
});

function fn_joinForm(event) {
    event.preventDefault();
    var form = document.joinForm;
    
    if (form.memberId.value.trim() === "") {
        alert("아이디를 입력해 주세요.");
        form.memberId.focus();
        return false;
    }
    
    if (!fn_memberIdCheck()) {
        return false;
    }
    
    if (form.memberPwd.value.trim() === "") {
        alert("비밀번호를 입력해 주세요.");
        form.memberPwd.focus();
        return false;
    }
    
    if (form.memberName.value.trim() === "") {
        alert("이름을 입력해 주세요.");
        form.memberName.focus();
        return false;
    }
    
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
    
    if (!fn_emailCheck()) {
        return false;
    }
    
    if (form.memberAge.value.trim() === "") {
        alert("나이를 입력해 주세요.");
        form.memberAge.focus();
        return false;
    } else {
        var age = parseInt(form.memberAge.value);
        if (isNaN(age) || age <= 0 || age >= 100) {
            alert("유효한 나이를 입력해 주세요.");
            form.memberAge.focus();
            return false;
        }
    }
    
    if (form.memberNickname.value.trim() === "") {
        alert("닉네임을 입력해 주세요.");
        form.memberNickname.focus();
        return false;
    }
    
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
    
    if (!form.memberGender.value) {
        alert("성별을 선택해 주세요.");
        return false;
    }

    form.submit();
}