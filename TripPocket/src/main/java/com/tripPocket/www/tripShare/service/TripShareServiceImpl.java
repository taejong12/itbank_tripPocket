package com.tripPocket.www.tripShare.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public void write(TripShareDTO tripShareDTO) {
		tripShareDAO.write(tripShareDTO);
		// 저장된 공유 ID 가져오기 (selectKey로 세팅되었다고 가정)
		Integer tripShareId = tripShareDTO.getTripShareId();

	    // 일자별 콘텐츠 저장
	    List<TripDayDTO> dayList = tripShareDTO.getTripDayList();
	    if (dayList != null) {
	        for (TripDayDTO day : dayList) {
	            day.setTripShareId(tripShareId);
	            tripShareDAO.insertContent(day);
	        }
	    }
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



	@Override
	public TripShareDTO detailList(TripShareDTO tripShareDTO) {
		// TODO Auto-generated method stub
		return tripShareDAO.detailList(tripShareDTO);
	}



	@Override
	public List<TripShareDTO> myList(String memberId) {
		// TODO Auto-generated method stub
		return tripShareDAO.myShare(memberId);
	}



	@Override
	public void importToMyPlan(Long tripShareId, String memberId) {
		tripShareDAO.simpleInsertPlanAndDays(tripShareId,memberId);
		
	}
}