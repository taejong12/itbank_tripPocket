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
	private Integer tripPlanId;
	private Date tripShareAddDate;
	private Date tripShareModDate;
	private Date tripPlanStartDay;
	private Date tripPlanArriveDay;
	private List<TripDayDTO> tripDayList; 
	private String memberId;
	
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
	public List<TripDayDTO> getTripDayList() {
		return tripDayList;
	}
	public void setTripDayList(List<TripDayDTO> tripDayList) {
		this.tripDayList = tripDayList;
	}
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
	public Integer getTripPlanId() {
		return tripPlanId;
	}
	public void setTripPlanId(Integer tripPlanId) {
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