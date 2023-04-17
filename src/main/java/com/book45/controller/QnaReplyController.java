package com.book45.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.book45.domain.Criteria;
import com.book45.domain.QnaReplyDTO;
import com.book45.domain.QnaReplyPageDTO;
import com.book45.service.QnaReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController 
@Log4j
@RequestMapping("/qnareply")
@AllArgsConstructor // 매개변수가 있는 생성자
public class QnaReplyController {
	private QnaReplyService service;

	/* 등록 */
	@PostMapping("/enroll")
	public void enrollReplyPOST(QnaReplyDTO dto) {
		log.info("enrollReplyPOST controller 실행 ->"+dto);
		service.enrollReply(dto);
	}

	/* 리스트 */
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_VALUE)
	public QnaReplyPageDTO replyListPOST(Criteria cri) {
		return service.replyList(cri);
	}   

	/* 수정 */
	@PostMapping("/update")
	public void replyModifyPOST(QnaReplyDTO dto) {
		service.updateReply(dto);
	}   

	@PostMapping("/delete")
	public void replyDeletePOST(QnaReplyDTO dto) {
		service.deleteReply(dto);
	}   
}