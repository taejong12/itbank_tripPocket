package com.tripPocket.www.tripShare.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

@Repository
public class TripShareDAOImpl implements TripShareDAO{
	@Autowired
	SqlSession session;

	@Override
	public List<TripShareDTO> shareList(TripShareDTO tripShareDTO) {
		
		return session.selectList("mapper.tripShare.selectList",tripShareDTO);
	}

	@Override
	public List<TripDayDTO> selectData(TripDayDTO tripDayDTO) {
		List<TripDayDTO> tripDayList = session.selectList("mapper.tripShare.selectDayList", tripDayDTO);
		return tripDayList;
		
	}

	@Override
	public void write(TripShareDTO tripShareDTO) {
		session.insert("mapper.tripShare.insertTripShare",tripShareDTO);
		
	}

	@Override
	public List<TripPlanDTO> selectIdList(String memberId) {
		
		return session.selectList("mapper.tripShare.selectIdList",memberId);
	}
}
