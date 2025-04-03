package com.tripPocket.www.tripPlan.dto;

import java.sql.Date;

public class TripDayDTO {

	private Integer tripDayId;
	private Integer tripDayDay;
	private String tripDayAdr;
	private Date tripDayDate;
	private String tripDayImage;
	private Integer tripPlanId;
	private Date tripPlanAddDate;
	private Date tripPlanModDate;
	
	public String getTripDayImage() {
		return tripDayImage;
	}
	public void setTripDayImage(String tripDayImage) {
		this.tripDayImage = tripDayImage;
	}
	public Integer getTripDayDay() {
		return tripDayDay;
	}
	public String getTripDayAdr() {
		return tripDayAdr;
	}
	public Integer getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(Integer tripPlanId) {
		this.tripPlanId = tripPlanId;
	}
	public void setTripDayId(Integer tripDayId) {
		this.tripDayId = tripDayId;
	}
	public void setTripDayDay(Integer tripDayDay) {
		this.tripDayDay = tripDayDay;
	}
	public int getTripDayId() {
		return tripDayId;
	}
	public void setTripDayAdr(String tripDayAdr) {
		this.tripDayAdr = tripDayAdr;
	}
	public Date getTripDayDate() {
		return tripDayDate;
	}
	public void setTripDayDate(Date tripDayDate) {
		this.tripDayDate = tripDayDate;
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
