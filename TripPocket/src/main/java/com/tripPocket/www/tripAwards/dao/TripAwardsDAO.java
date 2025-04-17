package com.tripPocket.www.tripAwards.dao;

import java.util.List;

import com.tripPocket.www.tripAwards.dto.TripAwardsDTO;

public interface TripAwardsDAO {

	

	int ArticleNo(TripAwardsDTO tripawardsDTO);
    void AwardsOne(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO FirstAwards(TripAwardsDTO tripawardsDTO);
	void selectByArticleNo();
	void updateAward();
	void deleteAward();
	TripAwardsDTO FirstAwardsNo(TripAwardsDTO tripawardsDTO);
	void insertFirstAward(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO selectOne(TripAwardsDTO dto);
	void TripAwardsResult();
	void FirstAwards();
	void selectOne();
	TripAwardsDTO SecondAwardsNo(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO MonthlyAwardsNo(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO PhotoAwardsNo(Runnable runnable);
	TripAwardsDTO selectAwardByOrder();
	TripAwardsDTO MonthlyAwardsNo();
	TripAwardsDTO selectAwardByOrder1();
	TripAwardsDTO PhotoAwardsNo(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO PhotoAwardsNo();
	TripAwardsDTO SecondAwards(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO MonthlyAwards(TripAwardsDTO tripawardsDTO);
	TripAwardsDTO PhotoAwards(TripAwardsDTO tripawardsDTO);
	List<TripAwardsDTO> selectFirstPostedReview1();
	List<TripAwardsDTO> selectSecondPostedReview2();
	List<TripAwardsDTO> selectMonthlyAwardsByHits();
	List<TripAwardsDTO> selectPhotoAwardsByLikes();
	List<TripAwardsDTO> selectFirstPostedReview();
	List<TripAwardsDTO> selectSecondPostedReview3();
	List<TripAwardsDTO> selectSecondPostedReview();
	

}


