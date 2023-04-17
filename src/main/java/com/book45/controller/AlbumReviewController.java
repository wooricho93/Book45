package com.book45.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.book45.domain.AlbumReviewDTO;
import com.book45.domain.AlbumReviewPageDTO;
import com.book45.domain.Criteria;
import com.book45.service.AlbumReviewService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/albumReview")
@Log4j
public class AlbumReviewController {

	@Autowired
	private AlbumReviewService service;
	
	/* 리뷰 등록 */
	@PostMapping("/enroll")
	public void enrollAlbumReviewPOST(AlbumReviewDTO dto) {
		
		service.enrollAlbumReview(dto);
	}
	
	/* 리뷰 체크 */
	/* memberId, bookId 파라미터 */
	/* 존재 : 1 / 존재x : 0 */
	@PostMapping("/check")
	public String albumReviewCheckPOST(AlbumReviewDTO dto) {
		
		return service.checkAlbumReview(dto);
	}
	
	/* 리뷰 페이징 */
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_VALUE)
	public AlbumReviewPageDTO albumReviewListPOST(Criteria cri) {
		return service.albumReviewList(cri);
	}
	
	/* 리뷰 수정 */
	@PostMapping("/update")
	public void albumReviewModifyPOST(AlbumReviewDTO dto) {
		service.updateAlbumReview(dto);
	}
	
	/* 리뷰 삭제 */
	@PostMapping("/delete")
	public void albumReviewDeletePOST(AlbumReviewDTO dto) {
		service.deleteAlbumReview(dto);
	}

}
