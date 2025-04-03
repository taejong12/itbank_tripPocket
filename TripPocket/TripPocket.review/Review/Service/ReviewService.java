package Review.Service;

import java.util.List;

import Review.dto.ReviewDTO;

public interface ReviewService {

	List<ReviewDTO> searchreview(String keyword);

	void WriteReview(ReviewDTO review);

	boolean DeleteReview(ReviewDTO review);

	boolean ModifyReview(ReviewDTO review);

	List<ReviewDTO> searchReview1(String keyword);

	void Writereview(ReviewDTO review);

	boolean deleteReview(ReviewDTO review);

	List<ReviewDTO> SearchReview(String keyword);

}
