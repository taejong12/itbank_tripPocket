window.fu_deleteTripPlan = function(tripPlanId){
			
	fetch(contextPath+"/trip/deleteTripPlan.do", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(tripPlanId)
    })
    .then(response => {
        if (!response.ok) {
        	 throw new Error("여행 계획 삭제 응답 중 에러: " + response.status);
        }
        return response.json();
    })
    .then(map => {
		
    	// 삭제된 요소를 화면에서 제거
    	let div_id = document.getElementById("tripPlan_"+tripPlanId);
		
    	if (div_id) {
    		div_id.remove();
        }
    	
    })
    .catch(error => {
        console.error("여행 계획 삭제 오류 발생:", error);
    });
}