package com.book45.service;

import com.book45.domain.AlbumReviewDTO;
import com.book45.domain.AlbumReviewPageDTO;
import com.book45.domain.Criteria;

public interface AlbumReviewService {
	/* 댓글 등록 */
	public int enrollAlbumReview(AlbumReviewDTO dto);
	
	/* 댓글 존재 체크 */
	public String checkAlbumReview(AlbumReviewDTO dto);
	
	/* 댓글 페이징 */
	public AlbumReviewPageDTO albumReviewList(Criteria cri);
	
	/* 댓글 수정 */
	public int updateAlbumReview(AlbumReviewDTO dto);
	
	/* 댓글 한개 정보 수정 */
	public AlbumReviewDTO getUpdateAlbumReview(int num);

	/* 댓글 삭제 */
	public int deleteAlbumReview(AlbumReviewDTO dto);
}
