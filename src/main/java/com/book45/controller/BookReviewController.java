package com.book45.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.book45.domain.BookReviewDTO;
import com.book45.domain.BookReviewPageDTO;
import com.book45.domain.Criteria;
import com.book45.service.BookReviewService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/bookReview")
@Log4j
public class BookReviewController {
	@Autowired
	private BookReviewService service;
	
	/* 리뷰 등록 */
	@PostMapping("/enroll")
	public void enrollBookReviewPOST(BookReviewDTO dto) {
		log.info("리뷰 등록");
		service.enrollBookReview(dto);
	}
	
	/* 리뷰 체크 */
	/* memberId, bookId 파라미터 */
	/* 존재 : 1 / 존재x : 0 */
	@PostMapping("/check")
	public String bookReviewCheckPOST(BookReviewDTO dto) {
		return service.checkBookReview(dto);
	}
	
	/* 리뷰 페이징 */
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_VALUE)
	public BookReviewPageDTO bookReviewListPOST(Criteria cri) {
		log.info("도서 리뷰 들어가기");
		return service.bookReviewList(cri);
	}
	
	/* 리뷰 수정 */
	@PostMapping("/update")
	public void bookReviewModifyPOST(BookReviewDTO dto) {
		log.info("리뷰 수정 중");
		service.updateBookReview(dto);
	}
	
	/* 리뷰 삭제 */
	@PostMapping("/delete")
	public void bookReviewDeletePOST(BookReviewDTO dto) {
		log.info("리뷰 삭제 중");
		service.deleteBookReview(dto);
	}

}
