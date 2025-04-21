// 뒤로가기(back-forward cache) 시 자동 리셋
window.addEventListener("pageshow", function (event) {
	const isBackOrForward = event.persisted || (window.performance && performance.getEntriesByType("navigation")[0].type === "back_forward");
	if (isBackOrForward) {
		// 문서 내 모든 form을 초기화
		const forms = document.querySelectorAll("form");
		forms.forEach(form => form.reset());
		window.location.reload();
	}
});