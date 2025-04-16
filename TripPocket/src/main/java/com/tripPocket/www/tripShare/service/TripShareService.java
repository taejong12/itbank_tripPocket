package com.tripPocket.www.tripShare.service;

import java.util.List;
import java.util.Map;

import com.tripPocket.www.member.dto.MemberDTO;
import com.tripPocket.www.tripPlan.dto.TripDayDTO;
import com.tripPocket.www.tripPlan.dto.TripPlanDTO;
import com.tripPocket.www.tripShare.dto.TripShareContentDTO;
import com.tripPocket.www.tripShare.dto.TripShareDTO;

public interface TripShareService {

	List<TripShareDTO> shareList(TripShareDTO tripShareDTO);

	void write(TripShareDTO tripShareDTO);

	List<TripPlanDTO> getTripPlansByMemberId(String memberId);

	List<TripDayDTO> selectTripDayList(TripDayDTO tripDayDTO);

	TripShareDTO detailList(TripShareDTO tripShareDTO);

	List<TripShareDTO> myList(String memberId);

	void importToMyPlan(Long tripShareId, String memberId);

	void shareDelete(int tripShareId);

	TripShareDTO getShareDetail(int tripShareId);

	List<TripShareContentDTO> getTripDayDetailList(int tripShareId);

	MemberDTO getWriterByShareId(int tripShareId);

	void updateTripShareContents(List<Map<String, Object>> contentList);


}