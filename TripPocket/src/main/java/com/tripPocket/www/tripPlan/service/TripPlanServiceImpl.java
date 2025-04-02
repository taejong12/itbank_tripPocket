package com.tripPocket.www.tripPlan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tripPocket.www.tripPlan.dao.TripPlanDAO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;

@Service
public class TripPlanServiceImpl implements TripPlanService{

	@Autowired
	private TripPlanDAO tripPlanDAO;
	
	@Override
	public void insertPlanDateSet(TripPlanDTO tripPlanDTO) {
		tripPlanDAO.insertPlanDateSet(tripPlanDTO);
	}

	@Override
	public List<TripPlanDTO> selectPlanList(String memberId) {
		return tripPlanDAO.selectPlanList(memberId);
	}

	@Override
	public List<TripDayDTO> selectTripDayListByPlanId(Integer tripPlanId) {
		return tripPlanDAO.selectTripDayListByPlanId(tripPlanId);
	}

}
