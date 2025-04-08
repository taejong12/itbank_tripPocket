package com.tripPocket.www.tripShare.dao;

import java.util.List;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

public interface TripShareDAO {

	List<TripShareDTO> shareList(TripShareDTO tripShareDTO);

	List<TripDayDTO> selectData(TripDayDTO tripDayDTO);

	void write(TripShareDTO tripShareDTO);

	List<TripPlanDTO> selectIdList(String memberId);

}
