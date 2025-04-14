package com.tripPocket.www.tripShare.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareContentDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

public interface TripShareDAO {

	List<TripShareDTO> shareList(TripShareDTO tripShareDTO);

	List<TripDayDTO> selectData(TripDayDTO tripDayDTO);

	void write(TripShareDTO tripShareDTO);

	List<TripPlanDTO> selectIdList(String memberId);

	TripShareDTO detailList(TripShareDTO tripShareDTO);

	void insertContent(TripDayDTO day);

	List<TripShareDTO> myShare(String memberId);

	void simpleInsertPlanAndDays(Long tripShareId, String memberId);

	void shareDelete(int tripShareId);

	TripShareDTO getShareDetail(int tripShareId);

	List<TripDayDTO> getTripDayDetailList(int tripShareId);

	MemberDTO getWriterByShareId(int tripShareId);
	
	void updateTripShareContents(@Param("contentList") List<Map<String, Object>> contentList);



}
