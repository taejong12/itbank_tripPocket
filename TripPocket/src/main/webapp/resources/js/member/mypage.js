function showEditField(label) {
    const fields = ['password', 'tel', 'nickname', 'email'];
    fields.forEach(function (key) {
        if (key !== label) {
            hideEditField(key);
        }
    });
    document.getElementById(label + '-display').style.display = 'none';
    document.getElementById(label + '-edit').style.display = 'flex';
    document.getElementById(label + '-button').style.display = 'none';
    
    // input 값 비우기
    const input = document.getElementById(label + '-input');
    if (input) {
        input.value = '';  // 이 줄이 핵심!
    }
}

function hideEditField(label) {
    document.getElementById(label + '-display').style.display = 'flex';
    document.getElementById(label + '-edit').style.display = 'none';
    document.getElementById(label + '-button').style.display = 'inline';
}

function mypageForm(event) {
    // 어떤 입력 영역이 현재 보이고 있는지 확인
    const editFields = ['password', 'email', 'tel', 'nickname'];
    let target = null;

    for (const field of editFields) {
        const editDiv = document.getElementById(field + '-edit');
        if (editDiv && editDiv.style.display === 'flex') {
            target = field;
            break;
        }
    }

    if (!target) {
        alert("수정할 항목을 선택해 주세요.");
        return false;
    }

    switch (target) {
        case 'password':
            const password = document.getElementById('password-input').value.trim();
            const specialCharPattern = /[!@#$%^&*(),.?":{}|<>]/;
            // 비밀번호 길이 + 특수문자 검사 합치기
            if (password.length < 8 || !specialCharPattern.test(password)) {
                alert("비밀번호는 최소 8자 이상, 특수문자(예: !, @, #, $ 등)를 포함해 주세요.");
                document.getElementById('password-input').focus();
                return false;
            }
            break;

        case 'email':
            const email = document.getElementById('email-input').value.trim();
            if (!email) {
                alert("이메일을 입력해 주세요.");
                document.getElementById('email-input').focus();
                return false;
            }
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            if (!emailPattern.test(email)) {
                alert("정확한 이메일 형식을 입력해 주세요.");
                document.getElementById('email-input').focus();
                return false;
            }
            break;

       case 'tel':
			const tel = document.getElementById('tel-input').value.trim();
			if (!tel) {
			    alert("전화번호를 입력해 주세요.");
			    document.getElementById('tel-input').focus();
			    return false;
			}
			const telPattern = /^010-\d{4}-\d{4}$/;
			if (!telPattern.test(tel)) {
			    alert("전화번호를 010-1234-5678 형식으로 입력해 주세요.");
			    document.getElementById('tel-input').focus();
			    return false;
			}
			break;

        case 'nickname':
            const nickname = document.getElementById('nickname-input').value.trim();
            if (!nickname) {
                alert("닉네임을 입력해 주세요.");
                document.getElementById('nickname-input').focus();
                return false;
            }
            break;
    }

    return true;
}

// 휴대전화번호 자동 하이픈 포맷터 + 최대 13자리 제한 (010-0000-0000)
function formatPhoneNumber(value) {
    value = value.replace(/\D/g, ''); // 숫자 외 제거

    if (value.length > 11) {
        value = value.slice(0, 11); // 11자리까지만 허용
    }

    if (value.length <= 3) {
        return value;
    } else if (value.length <= 7) {
        return value.slice(0, 3) + '-' + value.slice(3);
    } else {
        return value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
    }
}

// 이벤트 연결
document.addEventListener('DOMContentLoaded', function () {
    const telInput = document.getElementById('tel-input');
    if (telInput) {
        telInput.addEventListener('input', function () {
            const numericOnly = telInput.value.replace(/\D/g, '').slice(0, 11); // 최대 11자리
            telInput.value = formatPhoneNumber(numericOnly);
        });
    }
});