package com.tripPocket.www.tripPlan.dto;

import java.sql.Date;

public class TripDayDTO {

	private Integer tripDayId;
	private Integer tripDayDay;
	private String tripDayPlace;
	private String tripDayAddress;
	private Date tripDayDate;
	private String tripDayImage;
	private double tripDayMapx;
	private double tripDayMapy;
	private Integer tripPlanId;
	private Date tripDayAddDate;
	private Date tripDayModDate;
	
	public Integer getTripDayId() {
		return tripDayId;
	}
	public void setTripDayId(Integer tripDayId) {
		this.tripDayId = tripDayId;
	}
	public Integer getTripDayDay() {
		return tripDayDay;
	}
	public void setTripDayDay(Integer tripDayDay) {
		this.tripDayDay = tripDayDay;
	}
	public String getTripDayPlace() {
		return tripDayPlace;
	}
	public void setTripDayPlace(String tripDayPlace) {
		this.tripDayPlace = tripDayPlace;
	}
	public String getTripDayAddress() {
		return tripDayAddress;
	}
	public void setTripDayAddress(String tripDayAddress) {
		this.tripDayAddress = tripDayAddress;
	}
	public Date getTripDayDate() {
		return tripDayDate;
	}
	public void setTripDayDate(Date tripDayDate) {
		this.tripDayDate = tripDayDate;
	}
	public String getTripDayImage() {
		return tripDayImage;
	}
	public void setTripDayImage(String tripDayImage) {
		this.tripDayImage = tripDayImage;
	}
	public double getTripDayMapx() {
		return tripDayMapx;
	}
	public void setTripDayMapx(double tripDayMapx) {
		this.tripDayMapx = tripDayMapx;
	}
	public double getTripDayMapy() {
		return tripDayMapy;
	}
	public void setTripDayMapy(double tripDayMapy) {
		this.tripDayMapy = tripDayMapy;
	}
	public Integer getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(Integer tripPlanId) {
		this.tripPlanId = tripPlanId;
	}
	public Date getTripDayAddDate() {
		return tripDayAddDate;
	}
	public void setTripDayAddDate(Date tripDayAddDate) {
		this.tripDayAddDate = tripDayAddDate;
	}
	public Date getTripDayModDate() {
		return tripDayModDate;
	}
	public void setTripDayModDate(Date tripDayModDate) {
		this.tripDayModDate = tripDayModDate;
	}
}
