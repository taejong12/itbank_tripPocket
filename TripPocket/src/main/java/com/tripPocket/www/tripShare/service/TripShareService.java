package com.tripPocket.www.tripShare.service;

import java.util.List;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

public interface TripShareService {

	List<TripShareDTO> shareList(TripShareDTO tripShareDTO);

	

	void write(TripShareDTO tripShareDTO);

	List<TripPlanDTO> getTripPlansByMemberId(String memberId);

	List<TripDayDTO> selectTripDayList(TripDayDTO tripDayDTO);



	TripShareDTO detailList(TripShareDTO tripShareDTO);



	

}