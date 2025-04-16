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
			const telPattern = /^010\d{8}$/;
			if (!telPattern.test(tel)) {
			    alert("전화번호를 01012345678 형식으로 입력해 주세요.");
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

// 전화번호 입력 제한 + 최대 11자리 숫자 제한
document.addEventListener('DOMContentLoaded', function () {
    const telInput = document.getElementById('tel-input');

    if (telInput) {
        telInput.addEventListener('input', function () {
            let value = telInput.value.replace(/\D/g, ''); // 숫자만 남기기
            value = value.slice(0, 11); // 최대 8자리 제한
            telInput.value = value;
        });
    }
});

 function triggerFileInput() {
	document.getElementById('profile-img-input').click();
}

// 이미지 미리보기 함수
function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('profile-img');
        output.src = reader.result;  // 미리보기 이미지로 설정
    };
    reader.readAsDataURL(event.target.files[0]);
}