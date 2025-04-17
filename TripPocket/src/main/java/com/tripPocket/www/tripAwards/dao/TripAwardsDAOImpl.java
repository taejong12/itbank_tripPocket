package com.tripPocket.www.tripAwards.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tripPocket.www.tripAwards.dto.TripAwardsDTO;

@Repository
public class TripAwardsDAOImpl implements TripAwardsDAO{
	
	@Autowired
	private SqlSession sqlSession;


	@Override
	public TripAwardsDTO FirstAwardsNo(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectFirstTrip", tripawardsDTO);
	}
   
	@Override
	public TripAwardsDTO SecondAwardsNo(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectSecondTrip", tripawardsDTO);
	}
	
	@Override
	public TripAwardsDTO MonthlyAwardsNo(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectMonthlyTrip", tripawardsDTO);
	}
	
	@Override
	public TripAwardsDTO PhotoAwardsNo(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectPhotoTrip", tripawardsDTO);
	}
	
	@Override
	public int ArticleNo(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectArticleNo", tripawardsDTO);
	}


	@Override
	public TripAwardsDTO FirstAwards(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectFirstAwards", tripawardsDTO);
	}
	
	@Override
	public TripAwardsDTO SecondAwards(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectSecondAwards", tripawardsDTO);
	}
	
	@Override
	public TripAwardsDTO PhotoAwards(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectPhotoAwards", tripawardsDTO);

	}
	
	@Override
	public TripAwardsDTO MonthlyAwards(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.tripawards.selectMonthlyAwards", tripawardsDTO);

	
	}

	@Override
	public void AwardsOne(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void selectByArticleNo() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateAward() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAward() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertFirstAward(TripAwardsDTO tripawardsDTO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public TripAwardsDTO selectOne(TripAwardsDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void TripAwardsResult() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void FirstAwards() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void selectOne() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public TripAwardsDTO PhotoAwardsNo(Runnable runnable) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TripAwardsDTO selectAwardByOrder() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TripAwardsDTO MonthlyAwardsNo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TripAwardsDTO selectAwardByOrder1() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TripAwardsDTO PhotoAwardsNo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectFirstPostedReview() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectSecondPostedReview() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectMonthlyAwardsByHits() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectPhotoAwardsByLikes() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectFirstPostedReview1() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectSecondPostedReview2() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TripAwardsDTO> selectSecondPostedReview3() {
		// TODO Auto-generated method stub
		return null;
	}

	}


	
	
	