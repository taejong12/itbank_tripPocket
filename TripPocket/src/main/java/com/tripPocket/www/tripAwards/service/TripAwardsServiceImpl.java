package com.tripPocket.www.tripAwards.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tripPocket.www.tripAwards.dao.TripAwardsDAO;
import com.tripPocket.www.tripAwards.dto.TripAwardsDTO;


@Service
public class TripAwardsServiceImpl implements TripAwardsService {
	 
	public TripAwardsDAO getTripawardsDAO() {
		return tripawardsDAO;
	}

	public void setTripawardsDAO(TripAwardsDAO tripawardsDAO) {
		this.tripawardsDAO = tripawardsDAO;
	}

	@Autowired
	  private TripAwardsDAO tripawardsDAO;
	
		@Override
	    public void FirstAwards(TripAwardsDTO selectOne) {
		// TODO Auto-generated method stub
	     tripawardsDAO.insertFirstAward(selectOne);
		
		}
		
		@Override
		public void TripAwardsDAO() {
			// TODO Auto-generated method stub
			
	}

		@Override
		public TripAwardsDTO selectOne(TripAwardsDTO dto) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public TripAwardsDTO insertFirstAward(TripAwardsDTO dto) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<TripAwardsDTO> selectAwardsRankingBySearch(Map<String, Object> searchParams) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public Map<String, Object> selectAwardsRankingBySearch() {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<TripAwardsDTO> AllAwardsList() {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<TripAwardsDTO> getAwardsByCategory1(String string) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<TripAwardsDTO> getAwardsByCategory(String string) {
			// TODO Auto-generated method stub
			return null;
		}

		
		@Override
		public TripAwardsDTO getFirstAward() {
			// TODO Auto-generated method stub
			return tripawardsDAO.selectAwardByOrder();
		}

		@Override
		public TripAwardsDTO getSecondAward() {
			// TODO Auto-generated method stub
			return tripawardsDAO.selectAwardByOrder();
		}
		
		@Override
		public TripAwardsDTO getMonthlyAward() {
			// TODO Auto-generated method stub
			return tripawardsDAO.MonthlyAwardsNo();
			
		}
		
		@Override
		public TripAwardsDTO getPhotoAward() {
			// TODO Auto-generated method stub
			return tripawardsDAO.PhotoAwardsNo();
				
					
	}
		
		
		@Override
		public List<TripAwardsDTO> getSecondPostedReview() {
			// TODO Auto-generated method stub
		    return tripawardsDAO.selectSecondPostedReview();
		}
		@Override
		public List<TripAwardsDTO> getTopViewedThisMonth() {
			// TODO Auto-generated method stub
		    return tripawardsDAO.selectMonthlyAwardsByHits();
		}
		@Override
		public List<TripAwardsDTO> getMostLikedPhotos() {
			// TODO Auto-generated method stub
		    return tripawardsDAO.selectPhotoAwardsByLikes();
		}

		@Override
		public List<TripAwardsDTO> searchAwards(String trip_articleno, String title, String trip_imgfileno) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<TripAwardsDTO> getFirstPostedReview() {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<TripAwardsDTO> SearchAwards(int articleno, int imgfileno) {
			// TODO Auto-generated method stub
			return null;
		}

		
		}

	
		
		
