package com.book45.mapper;

import java.util.List;

import com.book45.domain.BookReviewDTO;
import com.book45.domain.Criteria;
import com.book45.domain.UpdateBookReviewDTO;

public interface BookReviewMapper {
	/* 댓글 등록 */
	public int enrollBookReview(BookReviewDTO dto);
	
	/* 댓글 존재 체크 */
	public Integer checkBookReview(BookReviewDTO dto);
	
	/* 댓글 페이징 */
	public List<BookReviewDTO> getBookReviewList(Criteria cri);
	
	/* 댓글 총 갯수(페이징) */
	public int getBookReviewTotal(Long isbn);
	
	/* 댓글 수정 */
	public int updateBookReview(BookReviewDTO dto);
	
	/* 댓글 한개 정보(수정페이지) */
	public BookReviewDTO getUpdateBookReview(int num);
	
	/* 댓글 삭제 */
	public int deleteBookReview(int num);

	/* 평점 평균 구하기 */
	public Double getRatingAverage(Long isbn);
	
	/* 평점 평균 반영하기 */
	public int updateRating(UpdateBookReviewDTO dto);
}
