package com.tripPocket.www.tripShare.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;
@Component
public class TripFileDTO {

	int tripFileId;
	String tripFileName;
	String tripFilePath;
	Date uploadDate;
	
	public int getTripFileId() {
		return tripFileId;
	}
	public void setTripFileId(int tripFileId) {
		this.tripFileId = tripFileId;
	}
	public String getTripFileName() {
		return tripFileName;
	}
	public void setTripFileName(String tripFileName) {
		this.tripFileName = tripFileName;
	}
	public String getTripFilePath() {
		return tripFilePath;
	}
	public void setTripFilePath(String tripFilePath) {
		this.tripFilePath = tripFilePath;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	
}