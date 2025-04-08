package com.tripPocket.www.tripShare.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dao.TripShareDAO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

@Service
public class TripShareServiceImpl implements TripShareService{
	@Autowired
	TripShareDAO tripShareDAO;

	@Override
	public List<TripShareDTO> shareList(TripShareDTO tripShareDTO) {
		// TODO Auto-generated method stub
		return tripShareDAO.shareList(tripShareDTO);
	}

	

	@Override
	public void write(TripShareDTO tripShareDTO) {
		tripShareDAO.write(tripShareDTO);
		
	}

	@Override
	public List<TripPlanDTO> getTripPlansByMemberId(String memberId) {
		// TODO Auto-generated method stub
		return tripShareDAO.selectIdList(memberId);
	}

	@Override
	public List<TripDayDTO> selectTripDayList(TripDayDTO tripDayDTO) {
			
		return tripShareDAO.selectData(tripDayDTO);
	}
}