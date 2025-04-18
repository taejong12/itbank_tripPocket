package com.tripPocket.www.member.dto;

import java.sql.Date;

public class MemberDTO {
	private String memberId; 
    private String memberPwd;
    private String memberName;
    private String memberEmail;
    private int memberAge;
    private String memberNickname;
    private String memberTel;
    private String memberGender;
    private Date memberAddDate;
    private Date memberModDate;
    
    // 쿠키용
    private String loginKeep;
    
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPwd() {
		return memberPwd;
	}
	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public int getMemberAge() {
		return memberAge;
	}
	public void setMemberAge(int memberAge) {
		this.memberAge = memberAge;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getMemberTel() {
		return memberTel;
	}
	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public Date getMemberModDate() {
		return memberModDate;
	}
	public void setMemberModDate(Date memberModDate) {
		this.memberModDate = memberModDate;
	}
	public Date getMemberAddDate() {
		return memberAddDate;
	}
	public void setMemberAddDate(Date memberAddDate) {
		this.memberAddDate = memberAddDate;
	}
	public String getLoginKeep() {
		return loginKeep;
	}
	public void setLoginKeep(String loginKeep) {
		this.loginKeep = loginKeep;
	}
}
