package com.tripPocket.www.tripPlan.dto;

import java.sql.Date;

public class TripPlanDTO {

	private String tripPlanId;
	private String tripPlanTitle;
	private String tripPlanContent;
	private String memberId;
	private Date tripPlanAddDate;
	private Date tripPlanModDate;
	
	public String getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(String tripPlanId) {
		this.tripPlanId = tripPlanId;
	}
	public String getTripPlanTitle() {
		return tripPlanTitle;
	}
	public void setTripPlanTitle(String tripPlanTitle) {
		this.tripPlanTitle = tripPlanTitle;
	}
	public String getTripPlanContent() {
		return tripPlanContent;
	}
	public void setTripPlanContent(String tripPlanContent) {
		this.tripPlanContent = tripPlanContent;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Date getTripPlanAddDate() {
		return tripPlanAddDate;
	}
	public void setTripPlanAddDate(Date tripPlanAddDate) {
		this.tripPlanAddDate = tripPlanAddDate;
	}
	public Date getTripPlanModDate() {
		return tripPlanModDate;
	}
	public void setTripPlanModDate(Date tripPlanModDate) {
		this.tripPlanModDate = tripPlanModDate;
	}
	
}
