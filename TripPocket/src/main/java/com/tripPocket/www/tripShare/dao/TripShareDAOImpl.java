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
import com.tripPocket.www.tripShare.dto.TripShareDTO;

@Repository
public class TripShareDAOImpl implements TripShareDAO{
	@Autowired
	SqlSession session;

	@Override
	public List<TripShareDTO> shareList(TripShareDTO tripShareDTO) {
		
		return session.selectList("mapper.trip.share.selectList",tripShareDTO);
	}

	@Override
	public List<TripDayDTO> selectData(TripDayDTO tripDayDTO) {
		List<TripDayDTO> tripDayList = session.selectList("mapper.trip.share.selectDayList", tripDayDTO);
		return tripDayList;
		
	}

	@Override
	public void write(TripShareDTO tripShareDTO) {
		session.insert("mapper.trip.share.insertTripShare",tripShareDTO);
		
	}

	@Override
	public List<TripPlanDTO> selectIdList(String memberId) {
		
		return session.selectList("mapper.trip.share.selectIdList",memberId);
	}

	@Override
	public TripShareDTO detailList(TripShareDTO tripShareDTO) {
		 
		return session.selectOne("mapper.trip.share.selectDetail",tripShareDTO);
	}

	@Override
	public void insertContent(TripDayDTO tripDayDTO) {
	    session.insert("mapper.trip.share.insertShareContent", tripDayDTO);
	}

	@Override
	public List<TripShareDTO> myShare(String memberId) {
		// TODO Auto-generated method stub
		return session.selectList("mapper.trip.share.myShareList",memberId);
	}

	@Override
	public void simpleInsertPlanAndDays(Long tripShareId, String memberId) {
	    // 1. 파라미터를 map으로 준비
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("tripShareId", tripShareId);
	    paramMap.put("memberId", memberId);

	    // 2. 공유글 기반으로 내 계획(plan) 복사
	    // 이 시점에 selectKey로 tripPlanId가 paramMap에 자동으로 들어감
	    session.insert("mapper.trip.share.insertTripPlanFromShare", paramMap);

	    // 3. 새로 생성된 tripPlanId를 꺼내서 확인
	    Long newPlanId = (Long) paramMap.get("tripPlanId");
	    System.out.println("✅ 생성된 내 planId: " + newPlanId);

	    // 4. day 복사 시 사용할 planId를 다시 map에 담아줌
	    paramMap.put("tripPlanId", newPlanId);

	    // 5. 공유된 day 데이터 → 내 계획에 복사
	    session.insert("mapper.trip.share.insertTripDaysFromShare", paramMap);
	}

	@Override
	public void shareDelete(int tripShareId) {
		session.delete("mapper.trip.share.shareDelete", tripShareId);
	}

	@Override
	public TripShareDTO getShareDetail(int tripShareId) {
		return session.selectOne("mapper.trip.share.getShareDetail",tripShareId);
	}

	@Override
	public List<TripDayDTO> getTripDayDetailList(int tripShareId) {
		return session.selectList("mapper.trip.share.getTripDayDetailList", tripShareId);
	}

	@Override
	public MemberDTO getWriterByShareId(int tripShareId) {
		return session.selectOne("mapper.trip.share.getWriterByShareId", tripShareId);
	}

	

}
