package com.tripPocket.www.tripAwards.dto;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class TripAwardsDTO {
  
	private String awardsId;
	private int articleno;
	private int imgFileno;
	private String title;
	private String content;
	private String Category;
	private String Result;
	private int firstAwardsNo;
    private int secondAwardsNo;
    private int monthlyAwardsNo;
	private int photoAwardsNo;
	
	public String getAwardsId() {
		return awardsId;
	}
	
	public void setAwardsId(List<TripAwardsDTO> awardsList, String awardsId) {
		this.awardsId = awardsId;
	}
	public int getArticleno() {
		return articleno;
	}
	public void setArticleno(int articleno) {
		this.articleno = articleno;
	}
	public int getImgFileno() {
		return imgFileno;
	}
	public void setImgFileno(int imgFileno) {
		this.imgFileno = imgFileno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return Category;
	}
	public void setCategory(String category) {
		Category = category;
	}
	public String getResult() {
		return Result;
	}
	public void setResult(String result) {
		Result = result;
	}
	public int getFirstAwardsNo() {
		return firstAwardsNo;
	}
	public void setFirstAwardsNo(int firstAwardsNo) {
		this.firstAwardsNo = firstAwardsNo;
	}
	public int getSecondAwardsNo() {
		return secondAwardsNo;
	}
	public void setSecondAwardsNo(int secondAwardsNo) {
		this.secondAwardsNo = secondAwardsNo;
	}
	public int getMonthlyAwardsNo() {
		return monthlyAwardsNo;
	}
	public void setMonthlyAwardsNo(int monthlyAwardsNo) {
		this.monthlyAwardsNo = monthlyAwardsNo;
	}
	public int getPhotoAwardsNo() {
		return photoAwardsNo;
	}
	public void setPhotoAwardsNo(int photoAwardsNo) {
		this.photoAwardsNo = photoAwardsNo;
	}
	
}
	