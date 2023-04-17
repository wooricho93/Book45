package com.book45.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.book45.domain.AlbumReviewDTO;
import com.book45.domain.Criteria;
import com.book45.domain.UpdateAlbumReviewDTO;

public interface AlbumReviewMapper {
	/* 댓글 등록 */
	public int enrollAlbumReview(AlbumReviewDTO dto);
	
	/* 댓글 존재 체크 */
	public Integer checkAlbumReview(AlbumReviewDTO dto);
	
	/* 댓글 페이징 */
	public List<AlbumReviewDTO> getAlbumReviewList(Criteria cri);
	
	/* 댓글 총 갯수(페이징)*/
	public int getAlbumReviewTotal(Long productNum);
	
	/* 댓글 수정 */
	public int updateAlbumReview(AlbumReviewDTO dto);
	
	/* 댓글 한개 정보(수정페이지) */
	public AlbumReviewDTO getUpdateAlbumReview(int num);
	
	/* 댓글 삭제 */
	public int deleteAlbumReview(int num);

	/* 평점 평균 구하기 */
	public Double getRatingAverage(Long productNum);
	
	/* 평점 평균 반영하기 */
	public int updateRating(UpdateAlbumReviewDTO dto);
}
