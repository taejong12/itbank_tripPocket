package com.tripPocket.www.tripShare.dao;

import java.util.Collections;
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

	@Override
	public List<TripShareDTO> shareList(TripShareDTO tripShareDTO) {
		return session.selectList("mapper.trip.share.selectList", tripShareDTO);
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
 
} 
