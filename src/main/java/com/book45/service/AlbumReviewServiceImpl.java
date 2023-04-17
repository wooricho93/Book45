package com.book45.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book45.domain.AlbumReviewDTO;
import com.book45.domain.AlbumReviewPageDTO;
import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.domain.UpdateAlbumReviewDTO;
import com.book45.mapper.AlbumReviewMapper;

import lombok.extern.log4j.Log4j;

@Service
public class AlbumReviewServiceImpl implements AlbumReviewService {
	@Autowired
	private AlbumReviewMapper mapper;

	/* 댓글 등록 */
	@Override
	public int enrollAlbumReview(AlbumReviewDTO dto) {
		int result = mapper.enrollAlbumReview(dto);
		
		setRating(dto.getProductNum());
		
		return result;
	}

	/* 댓글 존재 체크 */
	@Override
	public String checkAlbumReview(AlbumReviewDTO dto) {
		Integer result = mapper.checkAlbumReview(dto);
		
		if(result == null) {
			return "0";
		} else { 
			return "1";
		}
	}

	@Override
	public AlbumReviewPageDTO albumReviewList(Criteria cri) {
		AlbumReviewPageDTO dto = new AlbumReviewPageDTO();
		
		dto.setList(mapper.getAlbumReviewList(cri));
		dto.setPageInfo(new PageDTO(cri, mapper.getAlbumReviewTotal(cri.getProductNum())));
		
		return dto;
	}

	@Override
	public int updateAlbumReview(AlbumReviewDTO dto) {
		int result = mapper.updateAlbumReview(dto);
		
		setRating(dto.getProductNum());
		
		return result;
	}

	@Override
	public AlbumReviewDTO getUpdateAlbumReview(int num) {
		return mapper.getUpdateAlbumReview(num);
	}

	@Override
	public int deleteAlbumReview(AlbumReviewDTO dto) {
		int result  = mapper.deleteAlbumReview(dto.getNum());
		
		setRating(dto.getProductNum());
		
		return result;
	}
	
	/* 댓글 평균 */
	public void setRating(Long productNum) {
		Double ratingAvg = mapper.getRatingAverage(productNum);
		
		if(ratingAvg == null) {
			ratingAvg = 0.0;
		}
		
		ratingAvg = (double) (Math.round(ratingAvg*10));
		ratingAvg = ratingAvg / 10;
		
		UpdateAlbumReviewDTO urd = new UpdateAlbumReviewDTO();
		urd.setProductNum(productNum);
		urd.setRatingAvg(ratingAvg);
		
		mapper.updateRating(urd);
	}
}
