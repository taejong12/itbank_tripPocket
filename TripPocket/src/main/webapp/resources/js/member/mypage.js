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

// ➕ 버튼 클릭 시 파일 입력창 열기
function triggerFileInput() {
    document.getElementById('profile-img-input').click();
}

// 이미지 미리보기 및 업로드 후 리다이렉트
function previewImage(event) {
    const file = event.target.files[0];
    const preview = document.getElementById('profile-img');

    if (file && file.type.startsWith("image/")) {
        const reader = new FileReader();

        reader.onload = function (e) {
            preview.src = e.target.result; // 미리보기 이미지 업데이트
        };

        reader.readAsDataURL(file);

        // --- 여기서 서버로 업로드 ---
        const formData = new FormData();
        formData.append("profileImage", file);

        fetch(contextPath + "/member/uploadProfileImage.do", {
            method: "POST",
            body: formData
        })
        .then(res => res.text())  // 서버에서 이미지 경로 반환 받기
        .then(data => {
            console.log("업로드 완료:", data);
			const updatedImage = contextPath + "/resources/img/profile/" + data;
            preview.src = updatedImage; // 업로드된 이미지로 갱신
			alert("프로필사진이 변경되었습니다.")
            // 업로드 완료 후 mypage로 리다이렉트
            window.location.href = contextPath + "/member/mypage.do";  // mypage로 리다이렉트
        })
        .catch(err => {
            console.error("업로드 실패:", err);
            alert("이미지 업로드 실패. 다시 시도해 주세요.");
        });
    } else {
        alert("이미지 파일만 업로드 가능합니다.");
    }
}

// 프로필 이미지를 기본 이미지로 복원 후 리다이렉트
function resetToBasicImage() {
    var url = contextPath + "/member/resetProfileImage.do";  // 기본 이미지 복원을 위한 URL
    fetch(url, {
        method: 'POST'
        // body는 더 이상 필요하지 않음
    })
    .then(response => response.text())
    .then(data => {
        console.log("기본 이미지로 복원 완료: ", data);
        const preview = document.getElementById('profile-img');
        preview.src = contextPath + "/resources/img/profile/basic.png";  // 기본 이미지로 변경
        alert("기본 프로필사진으로 변경되었습니다.");

        // 복원 후 mypage로 리다이렉트
        window.location.href = contextPath + "/member/mypage.do";  // mypage로 리다이렉트
    })
    .catch(error => {
        console.error("기본 이미지로 복원 실패:", error);
    });
}
