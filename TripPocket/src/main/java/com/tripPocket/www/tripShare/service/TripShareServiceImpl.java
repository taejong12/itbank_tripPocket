package com.tripPocket.www.tripShare.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dao.TripShareDAO;
import com.tripPocket.www.tripShare.dto.TripShareCommentDTO;
import com.tripPocket.www.tripShare.dto.TripShareContentDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

@Service
public class TripShareServiceImpl implements TripShareService{
	@Autowired
	TripShareDAO tripShareDAO;
	// shareList
	@Override
	public List<TripShareDTO> shareListSorted(String sortType) {
	    switch (sortType) {
	        case "views":
	            return tripShareDAO.selectListOrderByViews(sortType);
	        case "shares":
	            return tripShareDAO.selectListOrderByShares(sortType);
	        default: // latest
	            return tripShareDAO.selectListOrderByLatest(sortType);
	    }
	}

	

		@Override
		@Transactional
		public void write(TripShareDTO tripShareDTO) {
			tripShareDAO.write(tripShareDTO);
			// 저장된 공유 ID 가져오기 (selectKey로 세팅되었다고 가정)
			Integer tripShareId = tripShareDTO.getTripShareId();
	
		    // 일자별 콘텐츠 저장
		    List<TripDayDTO> dayList = tripShareDTO.getTripDayList();
		    
		    if (dayList != null) {
		        for (TripDayDTO day : dayList) {
		            day.setTripShareId(tripShareId);
		            tripShareDAO.insertContent(day);
		           
		        }
		    }
		}

	@Override
	public List<TripPlanDTO> getTripPlansByMemberId(String memberId) {
		// TODO Auto-generated method stub
		return tripShareDAO.selectIdList(memberId);
	}

	@Override
	public List<TripDayDTO> selectTripDayList(TripDayDTO tripDayDTO) {
			
		return tripShareDAO.selectData(tripDayDTO);
	}



	@Override
	public TripShareDTO detailList(TripShareDTO tripShareDTO) {
		// TODO Auto-generated method stub
		return tripShareDAO.detailList(tripShareDTO);
	}



	@Override
	public List<TripShareDTO> myList(String memberId) {
		// TODO Auto-generated method stub
		return tripShareDAO.myShare(memberId);
	}



	@Override
	public void importToMyPlan(Long tripShareId, String memberId) {
		tripShareDAO.simpleInsertPlanAndDays(tripShareId,memberId);
		
	}



	@Override
	public void shareDelete(int tripShareId) {
		tripShareDAO.shareDelete(tripShareId);
		
	}



	@Override
	public TripShareDTO getShareDetail(int tripShareId) {
		return tripShareDAO.getShareDetail(tripShareId);
	}



	@Override
	public List<TripShareContentDTO> getTripDayDetailList(int tripShareId) {
		return tripShareDAO.getTripDayDetailList(tripShareId);
	}



	@Override
	public MemberDTO getWriterByShareId(int tripShareId) {
		return tripShareDAO.getWriterByShareId(tripShareId);
	}

	@Override
	public void updateTripShareContents(List<Map<String, Object>> contentList) {
		tripShareDAO.updateTripShareContents(contentList);
		
	}




	//중복확인 메서드
	@Override
	public boolean existsTripShareViewLog(Integer tripShareId, String memberId) {
		// TODO Auto-generated method stub
		return tripShareDAO.existsTripShareViewLog(tripShareId,memberId);
	}


	// log에 인서트
	@Override
	public void insertTripShareViewLog(Integer tripShareId, String memberId) {
		tripShareDAO.insertTripShareViewLog(tripShareId,memberId);
		
	}


	



	@Override
	public boolean existsShareLog(Long tripShareId, String memberId) {
			
		return tripShareDAO.existsShareLog(tripShareId,memberId);
	}



	@Override
	public void insertShareLog(Long tripShareId, String memberId) {
		tripShareDAO.insertShareLog(tripShareId,memberId);
		
	}



	@Override
	public int getTripShareViewCount(Integer tripShareId) {
		// TODO Auto-generated method stub
		return tripShareDAO.getTripShareViewCount(tripShareId);
	}



	@Override
	public int getTripShareShareCount(Integer tripShareId) {
		// TODO Auto-generated method stub
		return tripShareDAO.getTripShareShareCount(tripShareId);
	}



	@Override
	public void commentAdd(TripShareCommentDTO tripShareCommnetDTO) {
		tripShareDAO.commentAdd(tripShareCommnetDTO);
		
	}



	@Override
	public List<TripShareCommentDTO> getCommentsByTripShareId(Integer tripShareId) {
		// TODO Auto-generated method stub
		return tripShareDAO.getCommentsByTripShareId(tripShareId);
	}



	@Override
	public void commentMod(TripShareCommentDTO tripShareCommnetDTO) {
		tripShareDAO.commentMod(tripShareCommnetDTO);
		
	}



	@Override
	public void commentDel(int commentId) {
	 	tripShareDAO.commentDel(commentId); 
		
	}



	

	


}