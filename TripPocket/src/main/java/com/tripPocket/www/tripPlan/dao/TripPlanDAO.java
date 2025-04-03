package com.tripPocket.www.tripPlan.dao;

import java.util.List;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;

public interface TripPlanDAO {

	void insertPlanDateSet(TripPlanDTO tripPlanDTO);

	List<TripPlanDTO> selectPlanList(String memberId);

	List<TripDayDTO> selectTripDayListByPlanId(Integer tripPlanId);

	TripDayDTO insertTripDay(TripDayDTO tripDayDTO);

	TripPlanDTO selectTripPlanById(Integer tripPlanId);

	int deleteTripDayByTripDayId(Integer tripDayId);

	int deleteTripPlanByTripPlanId(Integer tripPlanId);

}
