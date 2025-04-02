package com.tripPocket.www.tripPlan.service;

import java.util.List;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;

public interface TripPlanService {

	void insertPlanDateSet(TripPlanDTO tripPlanDTO);

	List<TripPlanDTO> selectPlanList(String memberId);

	List<TripDayDTO> selectTripDayListByPlanId(Integer tripPlanId);

	int insertTripDay(TripDayDTO tripDayDTO);

	TripPlanDTO selectTripPlanById(Integer tripPlanId);

}
