package com.tripPocket.www.tripPlan.dto;

import java.sql.Date;
import java.util.List;

public class TripPlanDTO {

	private Integer tripPlanId;
	private String tripPlanTitle;
	private String tripPlanContent;
	private Date tripPlanStartDay;
	private Date tripPlanArriveDay;
	private String memberId;
	private Date tripPlanAddDate;
	private Date tripPlanModDate;
	private List<TripDayDTO> tripDayList;
	
	
	public Integer getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(Integer tripPlanId) {
		this.tripPlanId = tripPlanId;
	}
	public Date getTripPlanStartDay() {
		return tripPlanStartDay;
	}
	public void setTripPlanStartDay(Date tripPlanStartDay) {
		this.tripPlanStartDay = tripPlanStartDay;
	}
	public Date getTripPlanArriveDay() {
		return tripPlanArriveDay;
	}
	public void setTripPlanArriveDay(Date tripPlanArriveDay) {
		this.tripPlanArriveDay = tripPlanArriveDay;
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
	public List<TripDayDTO> getTripDayList() {
		return tripDayList;
	}
	public void setTripDayList(List<TripDayDTO> tripDayList) {
		this.tripDayList = tripDayList;
	}
	
}
