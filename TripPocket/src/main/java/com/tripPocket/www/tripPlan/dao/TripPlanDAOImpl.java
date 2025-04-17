package com.tripPocket.www.tripPlan.dao;

import java.util.List;

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
	public int insertPlan(TripPlanDTO tripPlanDTO) {
		sqlSession.insert("mapper.trip.plan.insertPlan", tripPlanDTO);
		return tripPlanDTO.getTripPlanId();
	}

	@Override
	public List<TripPlanDTO> selectPlanList(String memberId) {
		return sqlSession.selectList("mapper.trip.plan.selectPlanList", memberId);
	}

	@Override
	public List<TripDayDTO> selectTripDayListByPlanId(Integer tripPlanId) {
		return sqlSession.selectList("mapper.trip.plan.selectTripDayListByPlanId", tripPlanId);
	}

	@Override
	public TripDayDTO insertTripDay(TripDayDTO tripDayDTO) {
		sqlSession.insert("mapper.trip.plan.insertTripDay", tripDayDTO);
		return tripDayDTO;
	}

	@Override
	public TripPlanDTO selectTripPlanById(Integer tripPlanId) {
		return sqlSession.selectOne("mapper.trip.plan.selectTripPlanById", tripPlanId);
	}

	@Override
	public int deleteTripDayByTripDayId(Integer tripDayId) {
		return sqlSession.delete("mapper.trip.plan.deleteTripDayByTripDayId", tripDayId);
	}

	@Override
	public int deleteTripPlanByTripPlanId(Integer tripPlanId) {
		sqlSession.delete("mapper.trip.plan.deleteTripDayByTripPlanId", tripPlanId);
		return sqlSession.delete("mapper.trip.plan.deleteTripPlanByTripPlanId", tripPlanId);
	}
	
	public List<TripDayDTO> selectTripDay(TripDayDTO tripDayDTO) {
		return sqlSession.selectList("mapper.trip.plan.selectTripDay", tripDayDTO);
	}

}
