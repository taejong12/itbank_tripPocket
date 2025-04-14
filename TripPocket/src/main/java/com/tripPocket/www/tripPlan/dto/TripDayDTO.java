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
	private String tripDayContentId;
	private Integer tripPlanId;
	private Date tripPlanAddDate;
	private Date tripPlanModDate;
	private String tripShareContent;
	private Integer tripShareId;
	
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
	public String getTripDayContentId() {
		return tripDayContentId;
	}
	public void setTripDayContentId(String tripDayContentId) {
		this.tripDayContentId = tripDayContentId;
	}
	public Integer getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(Integer tripPlanId) {
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
	public String getTripShareContent() {
		return tripShareContent;
	}
	public void setTripShareContent(String tripShareContent) {
		this.tripShareContent = tripShareContent;
	}
	public Integer getTripShareId() {
		return tripShareId;
	}
	public void setTripShareId(Integer tripShareId) {
		this.tripShareId = tripShareId;
	}
}
