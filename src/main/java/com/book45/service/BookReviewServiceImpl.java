package com.book45.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book45.domain.BookReviewDTO;
import com.book45.domain.BookReviewPageDTO;
import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.domain.UpdateBookReviewDTO;
import com.book45.mapper.BookReviewMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BookReviewServiceImpl implements BookReviewService {
	@Autowired
	private BookReviewMapper mapper;

	/* 댓글 등록 */
	@Override
	public int enrollBookReview(BookReviewDTO dto) {
		int result = mapper.enrollBookReview(dto);
		
		setRating(dto.getIsbn());
		
		return result;
	}

	/* 댓글 존재 체크 */
	@Override
	public String checkBookReview(BookReviewDTO dto) {
		Integer result = mapper.checkBookReview(dto);
		
		if(result == null) {
			return "0";
		} else { 
			return "1";
		}
	}

	@Override
	public BookReviewPageDTO bookReviewList(Criteria cri) {
		BookReviewPageDTO dto = new BookReviewPageDTO();
		
		dto.setList(mapper.getBookReviewList(cri));
		dto.setPageInfo(new PageDTO(cri, mapper.getBookReviewTotal(cri.getIsbn())));
		
		return dto;
	}

	@Override
	public int updateBookReview(BookReviewDTO dto) {
		int result = mapper.updateBookReview(dto);
		
		setRating(dto.getIsbn());
		
		return result;
	}

	@Override
	public BookReviewDTO getUpdateBookReview(int num) {
		return mapper.getUpdateBookReview(num);
	}

	@Override
	public int deleteBookReview(BookReviewDTO dto) {
		int result  = mapper.deleteBookReview(dto.getNum());
		
		setRating(dto.getIsbn());
		
		return result;
	}
	
	/* 댓글 평균 */
	public void setRating(Long isbn) {
		Double ratingAvg = mapper.getRatingAverage(isbn);
		
		if(ratingAvg == null) {
			ratingAvg = 0.0;
		}
		
		ratingAvg = (double) (Math.round(ratingAvg*10));
		ratingAvg = ratingAvg / 10;
		
		UpdateBookReviewDTO urd = new UpdateBookReviewDTO();
		urd.setIsbn(isbn);
		urd.setRatingAvg(ratingAvg);
		
		mapper.updateRating(urd);
	}
}
