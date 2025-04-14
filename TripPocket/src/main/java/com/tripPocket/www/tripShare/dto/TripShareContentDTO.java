package com.tripPocket.www.tripShare.dto;

public class TripShareContentDTO {
	 private Long tripShareId;       // 여행 공유 ID
	 private Long tripDayId;         // 여행 일차 ID
	 private String tripShareContent; // 여행 공유 내용 (후기)
	public Long getTripShareId() {
		return tripShareId;
	}
	public void setTripShareId(Long tripShareId) {
		this.tripShareId = tripShareId;
	}
	public Long getTripDayId() {
		return tripDayId;
	}
	public void setTripDayId(Long tripDayId) {
		this.tripDayId = tripDayId;
	}
	public String getTripShareContent() {
		return tripShareContent;
	}
	public void setTripShareContent(String tripShareContent) {
		this.tripShareContent = tripShareContent;
	}
}
