package com.book45.service;

import com.book45.domain.BookReviewDTO;
import com.book45.domain.BookReviewPageDTO;
import com.book45.domain.Criteria;

public interface BookReviewService {
	/* 댓글 등록 */
	public int enrollBookReview(BookReviewDTO dto);
	
	/* 댓글 존재 체크 */
	public String checkBookReview(BookReviewDTO dto);
	
	/* 댓글 페이징 */
	public BookReviewPageDTO bookReviewList(Criteria cri);
	
	/* 댓글 수정 */
	public int updateBookReview(BookReviewDTO dto);
	
	/* 댓글 한개 정보 수정 */
	public BookReviewDTO getUpdateBookReview(int num);

	/* 댓글 삭제 */
	public int deleteBookReview(BookReviewDTO dto);
}
