package com.tripPocket.www.tripAwards.service;


import java.util.List;
import java.util.Map;

import com.tripPocket.www.tripAwards.dto.TripAwardsDTO;


public interface TripAwardsService {

	void FirstAwards(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO selectOne(TripAwardsDTO dto);
	void TripAwardsDAO();
	TripAwardsDTO insertFirstAward(TripAwardsDTO dto);
	List<TripAwardsDTO> selectAwardsRankingBySearch(Map<String, Object> searchParams);
	Map<String, Object>selectAwardsRankingBySearch();
	List<TripAwardsDTO> AllAwardsList();
	List<TripAwardsDTO> searchAwards(String trip_articleno, String title, String trip_imgfileno);
	static List<TripAwardsDTO> searchTripAwards(String trip_articleno, String title, String trip_imgfileno, String trip_content) {
		// TODO Auto-generated method stub
		return null;
	} 
	List<TripAwardsDTO> getAwardsByCategory1(String string);
	List<TripAwardsDTO> getAwardsByCategory(String string);
	static List<TripAwardsDTO> SearchAwards(String string, String string2, String string3, String string4) {
		// TODO Auto-generated method stub
		return null;
	}
	TripAwardsDTO getFirstAward();
	TripAwardsDTO getSecondAward();
	TripAwardsDTO getPhotoAward();
	TripAwardsDTO getMonthlyAward();
	List<TripAwardsDTO> getFirstPostedReview();
	List<TripAwardsDTO> getSecondPostedReview();
	List<TripAwardsDTO> getTopViewedThisMonth();
	List<TripAwardsDTO> getMostLikedPhotos();
	List<TripAwardsDTO> SearchAwards(int articleno, int imgfileno);
	
	


}