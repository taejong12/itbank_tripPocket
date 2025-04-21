package com.tripPocket.www.tripShare.dto;

import java.sql.Date;
import java.util.List;

public class TripShareCommentDTO {
	private Long commentId;        // 댓글 ID
	private Integer tripShareId;      // 여행 공유 글 ID
	private String memberId;       // 댓글 작성자 ID
	private String commentContent; // 댓글 내용
	private Date createdDate;        // 댓글 작성일
    private Date updatedDate;        // 댓글 수정일
    private Integer parentId; // 부모 댓글 ID (null이면 일반 댓글)
    private int depth;     // 0: 댓글, 1: 대댓글
    private List<TripShareCommentDTO> replies;
    
    
	public List<TripShareCommentDTO> getReplies() {
		return replies;
	}
	public void setReplies(List<TripShareCommentDTO> replies) {
		this.replies = replies;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public Long getCommentId() {
		return commentId;
	}
	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}
	public Integer getTripShareId() {
		return tripShareId;
	}
	public void setTripShareId(Integer tripShareId) {
		this.tripShareId = tripShareId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
}
