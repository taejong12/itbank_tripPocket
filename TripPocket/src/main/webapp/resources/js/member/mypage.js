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
            if (password.length < 8) {
                alert("비밀번호는 최소 8자 이상 입력해 주세요.");
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
			    alert("전화번호는 010-0000-0000 형식으로 입력해 주세요.");
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
