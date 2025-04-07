/**
 * 
 */
 function showEditField(label) {
	        const fields = ['name', 'password', 'tel', 'age', 'nickname', 'gender', 'email'];
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
    const password = document.getElementById('password-input').value.trim();
    const email = document.getElementById('email-input').value.trim();
    const tel = document.getElementById('tel-input').value.trim();
    const age = document.getElementById('age-input').value.trim();
    const nickname = document.getElementById('nickname-input').value.trim();
    const name = document.getElementById('name-input').value.trim();
    const gender = document.getElementById('gender-input').value;

    // 비밀번호 (선택사항: 입력했다면 최소 4자 이상)
    if (password && password.length < 7) {
        alert("비밀번호는 최소 8자 이상 입력해 주세요.");
        document.getElementById('password-input').focus();
        return false;
    }

    // 이메일
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

    // 전화번호
    if (!tel) {
        alert("전화번호를 입력해 주세요.");
        document.getElementById('tel-input').focus();
        return false;
    }
    const telPattern = /^\d{10,11}$/;
    if (!telPattern.test(tel)) {
        alert("유효한 전화번호를 입력해 주세요. (숫자만)");
        document.getElementById('tel-input').focus();
        return false;
    }

    // 나이
    if (!age) {
        alert("나이를 입력해 주세요.");
        document.getElementById('age-input').focus();
        return false;
    }
    const ageNum = parseInt(age);
    if (isNaN(ageNum) || ageNum < 1 || ageNum > 100) {
        alert("유효한 나이(1~100세)를 입력해 주세요.");
        document.getElementById('age-input').focus();
        return false;
    }

    // 닉네임
    if (!nickname) {
        alert("닉네임을 입력해 주세요.");
        document.getElementById('nickname-input').focus();
        return false;
    }

    // 이름
    if (!name) {
        alert("이름을 입력해 주세요.");
        document.getElementById('name-input').focus();
        return false;
    }

    // 성별
    if (!gender) {
        alert("성별을 선택해 주세요.");
        document.getElementById('gender-input').focus();
        return false;
    }

    return true; // 모든 조건 통과
}

	    