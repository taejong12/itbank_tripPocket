package Review.Service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import Review.dto.ReviewDTO;

@Service 
public abstract class ReviewServiceImpl implements ReviewService {
    
	 //검색하기
	List<ReviewDTO> result = new ArrayList();
	@Override
	public List<ReviewDTO> SearchReview(String keyword) {
	   // TODO Auto-generated method stub
		return result;
				
	}

   //리뷰쓰기
	@Override
	public void WriteReview(ReviewDTO review) {
		List<ReviewDTO> reviews;
		// TODO Auto-generated method stub
		return;
	}

    //리뷰삭제하기
	@Override
	public boolean DeleteReview(ReviewDTO review) {
       List<ReviewDTO> reviews;
		// TODO Auto-generated method stub
		return reviews.remove(review);
		ReviewDTO[] Reviews;
		for(ReviewDTO r = Reviews)
		if (r.getReviewSearch().equals(review.getReviewList())) {  // ID로 해당 리뷰 찾기
            r.setReviewContent(review.getReviewContent());  // 리뷰 내용 수정
            return true; // 수정 성공
	   
	}
           return false; 
		
        
            
		
	}

    //리뷰수정하기
	@Override
	public boolean ModifyReview(ReviewDTO review) {
			ReviewDTO[] reviews;
			for(ReviewDTO r = reviews)
			if (r.getReviewSearch().equals(review.getReviewList())) {  // ID로 해당 리뷰 찾기
	            r.setReviewContent(review.getReviewContent());  // 리뷰 내용 수정
	            return true; // 수정 성공
		   
		}
	           return false; 
	}
	
	}

	