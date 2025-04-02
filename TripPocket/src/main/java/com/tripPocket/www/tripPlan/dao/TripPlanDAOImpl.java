package com.tripPocket.www.tripPlan.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;

@Repository
public class TripPlanDAOImpl implements TripPlanDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertPlanDateSet(TripPlanDTO tripPlanDTO) {
		sqlSession.insert("mapper.trip.plan.insertPlanDateSet", tripPlanDTO);
	}

	@Override
	public List<TripPlanDTO> selectPlanList(String memberId) {
		return sqlSession.selectList("mapper.trip.plan.selectPlanList", memberId);
	}

	@Override
	public List<TripDayDTO> selectTripDayListByPlanId(Integer tripPlanId) {
		return sqlSession.selectList("mapper.trip.plan.selectTripDayListByPlanId", tripPlanId);
	}

}
