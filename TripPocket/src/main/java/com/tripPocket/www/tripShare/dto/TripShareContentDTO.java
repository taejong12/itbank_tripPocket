package com.tripPocket.www.tripShare.dto;

public class TripShareContentDTO {
		private Long tripShareDayId;
	    private Integer tripShareId;
	    private Integer tripDayId;

	    private Integer tripShareDayDay;
	    private String tripShareDayPlace;
	    private String tripShareDayAddress;
	    private java.sql.Date tripShareDayDate;
	    private String tripShareDayImage;
	    private double tripShareDayMapx;
	    private double tripShareDayMapy;
	    	
	    private String tripShareContent;
	    private java.sql.Date tripPlanStartDay;
	    private java.sql.Date tripPlanArriveDay;

		public java.sql.Date getTripPlanStartDay() {
			return tripPlanStartDay;
		}

		public void setTripPlanStartDay(java.sql.Date tripPlanStartDay) {
			this.tripPlanStartDay = tripPlanStartDay;
		}

		public java.sql.Date getPlanArriveDay() {
			return tripPlanArriveDay;
		}

		public void setPlanArriveDay(java.sql.Date planArriveDay) {
			tripPlanArriveDay = planArriveDay;
		}

		public void setTripShareDayMapy(double tripShareDayMapy) {
			this.tripShareDayMapy = tripShareDayMapy;
		}

		public Long getTripShareDayId() {
			return tripShareDayId;
		}

		public void setTripShareDayId(Long tripShareDayId) {
			this.tripShareDayId = tripShareDayId;
		}

		public Integer getTripShareId() {
			return tripShareId;
		}

		public void setTripShareId(Integer tripShareId) {
			this.tripShareId = tripShareId;
		}

		public Integer getTripDayId() {
			return tripDayId;
		}

		public void setTripDayId(Integer tripDayId) {
			this.tripDayId = tripDayId;
		}

		public Integer getTripShareDayDay() {
			return tripShareDayDay;
		}

		public void setTripShareDayDay(Integer tripShareDayDay) {
			this.tripShareDayDay = tripShareDayDay;
		}

		public String getTripShareDayPlace() {
			return tripShareDayPlace;
		}

		public void setTripShareDayPlace(String tripShareDayPlace) {
			this.tripShareDayPlace = tripShareDayPlace;
		}

		public String getTripShareDayAddress() {
			return tripShareDayAddress;
		}

		public void setTripShareDayAddress(String tripShareDayAddress) {
			this.tripShareDayAddress = tripShareDayAddress;
		}

		public java.sql.Date getTripShareDayDate() {
			return tripShareDayDate;
		}

		public void setTripShareDayDate(java.sql.Date tripShareDayDate) {
			this.tripShareDayDate = tripShareDayDate;
		}

		public String getTripShareDayImage() {
			return tripShareDayImage;
		}

		public void setTripShareDayImage(String tripShareDayImage) {
			this.tripShareDayImage = tripShareDayImage;
		}

		public double getTripShareDayMapx() {
			return tripShareDayMapx;
		}

		public void setTripShareDayMapx(double tripShareDayMapx) {
			this.tripShareDayMapx = tripShareDayMapx;
		}

		public double getTripShareDayMapy() {
			return tripShareDayMapy;
		}

		public void setTripShareDayMapy(Double tripShareDayMapy) {
			this.tripShareDayMapy = tripShareDayMapy;
		}

		public String getTripShareContent() {
			return tripShareContent;
		}

		public void setTripShareContent(String tripShareContent) {
			this.tripShareContent = tripShareContent;
		}
}
