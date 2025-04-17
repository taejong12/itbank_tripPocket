package com.tripPocket.www.tripShare.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
@Component
public class TripShareDTO {
	private Integer tripShareId;
	private String tripShareTitle;
	private String tripShareContent;
	private Integer tripPlanId;
	private Date tripShareAddDate;
	private Date tripShareModDate;
	 @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date tripPlanStartDay;
	 @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date tripPlanArriveDay;
	 @JsonIgnore
	private List<TripDayDTO> tripDayList; 
	private String memberId;
	@JsonIgnore
	private List<TripShareContentDTO> tripShareContentList;
	private Integer tripShareViewCount;
	private Integer TripShareShareCount;
	
	
	public int getTripShareShareCount() {
		return TripShareShareCount;
	}
	public void setTripShareShareCount(int tripShareShareCount) {
		TripShareShareCount = tripShareShareCount;
	}
	public int getTripShareViewCount() {
		return tripShareViewCount;
	}
	public void setTripShareViewCount(int tripShareViewCount) {
		this.tripShareViewCount = tripShareViewCount;
	}
	public List<TripShareContentDTO> getTripShareContentList() {
		return tripShareContentList;
	}
	public void setTripShareContentList(List<TripShareContentDTO> tripShareContentList) {
		this.tripShareContentList = tripShareContentList;
	}
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
	
	@Override
    public String toString() {
        return "TripShareDTO{" +
               "tripShareId=" + tripShareId +
               ", tripShareTitle='" + tripShareTitle + '\'' +
               ", tripPlanId=" + tripPlanId +
               ", tripShareAddDate=" + tripShareAddDate +
               ", tripShareModDate=" + tripShareModDate +
               ", tripPlanStartDay=" + tripPlanStartDay +
               ", tripPlanArriveDay=" + tripPlanArriveDay +
               ", memberId='" + memberId + '\'' +
               '}';
    }
}
