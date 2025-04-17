package com.tripPocket.www.tripShare.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;
@Component
public class TripShareLogDTO {
		private Integer tripShareId;     // 게시글 고유 ID
	    private String memberId;        // 사용자 ID
	    private String actionType;    // 'VIEW' 또는 'SHARE'
	    private Date actionDate;  // 액션 발생일
	    
	    
		public Integer getTripShareId() {
			return tripShareId;
		}
		public void setTripShareId(Integer tripShareId) {
			this.tripShareId = tripShareId;
		}
		public String getMemberId() {
			return memberId;
		}
		public void setMemberId(String memberId) {
			this.memberId = memberId;
		}
		public String getActionType() {
			return actionType;
		}
		public void setActionType(String actionType) {
			this.actionType = actionType;
		}
		public Date getActionDate() {
			return actionDate;
		}
		public void setActionDate(Date actionDate) {
			this.actionDate = actionDate;
		}
	    
	    
}
