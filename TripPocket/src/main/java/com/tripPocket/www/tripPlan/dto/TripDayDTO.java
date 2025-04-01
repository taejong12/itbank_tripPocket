package com.tripPocket.www.tripPlan.dto;

import java.sql.Date;

public class TripDayDTO {

	private int tripDayId;
	private int tripDayDay;
	private String tripDayAdr;
	private Date tripDayDate;
	private String tripPlanId;
	private Date tripPlanAddDate;
	private Date tripPlanModDate;
	
	public int getTripDayId() {
		return tripDayId;
	}
	public void setTripDayId(int tripDayId) {
		this.tripDayId = tripDayId;
	}
	public int getTripDayDay() {
		return tripDayDay;
	}
	public void setTripDayDay(int tripDayDay) {
		this.tripDayDay = tripDayDay;
	}
	public String getTripDayAdr() {
		return tripDayAdr;
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
	public String getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(String tripPlanId) {
		this.tripPlanId = tripPlanId;
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
