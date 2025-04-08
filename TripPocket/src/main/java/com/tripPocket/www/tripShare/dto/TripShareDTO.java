package com.tripPocket.www.tripShare.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
@Component
public class TripShareDTO {
	private Integer tripShareId;
	private String tripShareTitle;
	private String tripShareContent;
	private String tripPlanId;
	private Date tripShareAddDate;
	private Date tripShareModDate;
	private String tripPlanStartDay;
	private String tripPlanArriveDay;
	
	public String getTripPlanStartDay() {
		return tripPlanStartDay;
	}
	public void setTripPlanStartDay(String tripPlanStartDay) {
		this.tripPlanStartDay = tripPlanStartDay;
	}
	public String getTripPlanArriveDay() {
		return tripPlanArriveDay;
	}
	public void setTripPlanArriveDay(String tripPlanArriveDay) {
		this.tripPlanArriveDay = tripPlanArriveDay;
	}
	public List<TripDayDTO> getTripDayList() {
		return tripDayList;
	}
	public void setTripDayList(List<TripDayDTO> tripDayList) {
		this.tripDayList = tripDayList;
	}
	
	private List<TripDayDTO> tripDayList;
	
	public Integer getTripShareId() {
		return tripShareId;
	}
	public void setTripShareId(Integer tripShareId) {
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