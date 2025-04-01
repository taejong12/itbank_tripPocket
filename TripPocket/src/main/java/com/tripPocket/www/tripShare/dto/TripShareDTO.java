package com.tripPocket.www.tripShare.dto;

import java.sql.Date;

public class TripShareDTO {
	private String tripShareId;
	private String tripShareTitle;
	private String tripShareContent;
	private String tripPlanId;
	private Date tripShareAddDate;
	private Date tripShareModDate;
	
	public String getTripShareId() {
		return tripShareId;
	}
	public void setTripShareId(String tripShareId) {
		this.tripShareId = tripShareId;
	}
	public String getTripShareTitle() {
		return tripShareTitle;
	}
	public void setTripShareTitle(String tripShareTitle) {
		this.tripShareTitle = tripShareTitle;
	}
	public String getTripShareContent() {
		return tripShareContent;
	}
	public void setTripShareContent(String tripShareContent) {
		this.tripShareContent = tripShareContent;
	}
	public String getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(String tripPlanId) {
		this.tripPlanId = tripPlanId;
	}
	public Date getTripShareAddDate() {
		return tripShareAddDate;
	}
	public void setTripShareAddDate(Date tripShareAddDate) {
		this.tripShareAddDate = tripShareAddDate;
	}
	public Date getTripShareModDate() {
		return tripShareModDate;
	}
	public void setTripShareModDate(Date tripShareModDate) {
		this.tripShareModDate = tripShareModDate;
	}
}
