package com.tripPocket.www.tripShare.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareContentDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

@Repository
public class TripShareDAOImpl implements TripShareDAO{
	@Autowired
	SqlSession session;
	//shareList
	@Override
	public List<TripShareDTO> selectListOrderByViews(String sortType) {
		// TODO Auto-generated method stub
		return session.selectList("mapper.trip.share.selectListOrderByViews",sortType);
	}

	@Override
	public List<TripShareDTO> selectListOrderByShares(String sortType) {
		// TODO Auto-generated method stub
		return session.selectList("mapper.trip.share.selectListOrderByShares",sortType);
	}

	@Override
	public List<TripShareDTO> selectListOrderByLatest(String sortType) {
		// TODO Auto-generated method stub
		return session.selectList("mapper.trip.share.selectListOrderByLatest",sortType);
	}
	
	@Override
	public List<TripDayDTO> selectData(TripDayDTO tripDayDTO) {
		List<TripDayDTO> tripDayList = session.selectList("mapper.trip.share.selectDayList", tripDayDTO);
		return tripDayList;
	}

	@Override
	public void write(TripShareDTO tripShareDTO) {
		session.insert("mapper.trip.share.insertTripShare", tripShareDTO);
	}

	@Override
	public List<TripPlanDTO> selectIdList(String memberId) {
		return session.selectList("mapper.trip.share.selectIdList", memberId);
	}

	@Override
	public TripShareDTO detailList(TripShareDTO tripShareDTO) {
		return session.selectOne("mapper.trip.share.selectDetail", tripShareDTO);
	}

	@Override
	public void insertContent(TripDayDTO tripDayDTO) {
	    session.insert("mapper.trip.share.insertTripShareDay", tripDayDTO);
	}

	@Override
	public List<TripShareDTO> myShare(String memberId) {
		return session.selectList("mapper.trip.share.myShareList", memberId);
	}

	@Override
	public void simpleInsertPlanAndDays(Long tripShareId, String memberId) {
		 // 1. 파라미터 맵 준비
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("tripShareId", tripShareId);
	    paramMap.put("memberId", memberId);

	    // 2. trip_plan 삽입
	    session.insert("mapper.trip.share.insertTripPlanFromShare", paramMap);

	    Long newTripPlanId = session.selectOne("mapper.trip.share.selectLatestTripPlanId", memberId);
	    paramMap.put("tripPlanId", newTripPlanId);
	    session.insert("mapper.trip.share.insertTripDaysFromShare", paramMap);
	}

	@Override
	public void shareDelete(int tripShareId) {
		session.delete("mapper.trip.share.shareDelete", tripShareId);
	}

	@Override
	public TripShareDTO getShareDetail(int tripShareId) {
		return session.selectOne("mapper.trip.share.selectDetail", tripShareId);
	}

	@Override
	public List<TripShareContentDTO> getTripDayDetailList(int tripShareId) {
		return session.selectList("mapper.trip.share.getTripDayDetailList", tripShareId);
	}

	@Override
	public MemberDTO getWriterByShareId(int tripShareId) {
		return session.selectOne("mapper.trip.share.getWriterByShareId", tripShareId);
	}
	
	@Override
	public void updateTripShareContents(List<Map<String, Object>> contentList) {
		 for (Map<String, Object> map : contentList) {
		        session.update("mapper.trip.share.updateTripShareContent", map);
		    }
	}



	@Override
	public boolean existsTripShareViewLog(Integer tripShareId, String memberId) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("tripShareId", tripShareId);
		params.put("memberId", memberId);
		
		return session.selectOne("mapper.trip.share.existsTripShareViewLog",params);
	}

	@Override
	public void insertTripShareViewLog(Integer tripShareId, String memberId) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("tripShareId", tripShareId);
		params.put("memberId", memberId);
		session.insert("mapper.trip.share.insertTripShareViewLog",params);
	}
	
	@Override
	public int getTripShareViewCount(Integer tripShareId) {
		// TODO Auto-generated method stub
		
		return session.selectOne("mapper.trip.share.getTripShareViewCount",tripShareId);
	}
	// 공유 수 중복확인
	@Override
	public boolean existsShareLog(Long tripShareId, String memberId) {
		Map<String, Object> params = new HashMap<>();
		params.put("tripShareId", tripShareId);
		params.put("memberId", memberId);
		session.selectOne("mapper.trip.share.existsShareLog",params);
		
		return false;
	}
	//로그 테이블에 추가
	@Override
	public void insertShareLog(Long tripShareId, String memberId) {
		Map<String, Object> params = new HashMap<>();
		params.put("tripShareId", tripShareId);
		params.put("memberId", memberId);
		session.insert("mapper.trip.share.insertShareLog",params);
		
	}

	@Override
	public int getTripShareShareCount(Integer tripShareId) {
	
		return session.selectOne("mapper.trip.share.getTripShareShareCount",tripShareId);
	}

	

} 
