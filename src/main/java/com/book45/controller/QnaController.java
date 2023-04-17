package com.book45.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.domain.QnaReplyDTO;
import com.book45.domain.QnaVO;
import com.book45.service.QnaReplyService;
import com.book45.service.QnaService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/qna/*")
@AllArgsConstructor
public class QnaController {
	@Autowired
	private QnaService service;
	
	@Autowired
	private QnaReplyService replyService;
	
	@GetMapping("/list")	//QnA 게시판리스트
	public void list(Criteria cri, Model model) {
		log.info("QnA_List 이동==============>");
		
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotalCount(cri);
		
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")	//QnA글 작성
	public String register(QnaVO qVo, RedirectAttributes rttr) {
		log.info("QnA_Register=========> " + qVo);
		service.register(qVo);
		
		rttr.addFlashAttribute("result", qVo.getQnum());
		
		return "redirect:/qna/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam(value="qnum") int qnum, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("문의 게시판 상세페이지 이동 / 문의 게시판 등록페이지 이동");
		model.addAttribute("qna", service.get(qnum));
	}

	
	@PostMapping("/modify")	//수정
	public String modify(@ModelAttribute("qVo") QnaVO qVo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("QnA_수정===>");
		
		if (service.modify(qVo)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/qna/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")	//삭제
	public String remove(@RequestParam("qnum") int qnum, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("QnA_remove==>>");
		
		if (service.remove(qnum)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/qna/list" + cri.getListLink();
	}
	
	// 답변 달기 팝업창 요청
	@GetMapping("/qnaReplyEnroll/{id}")
	public String qnaReplyEnrollWindowGET(@PathVariable("id")String id, int qnum, Model model) {
		QnaVO qna = service.getQnaTitle(qnum);
		
		model.addAttribute("qnaInfo", qna);
		model.addAttribute("id", id);
		
		return "/qna/qnaReplyEnroll";
	}
	                                                           
	/* 리뷰 수정 팝업창 */
	@GetMapping("/qnaReplyUpdate")
	public String replyUpdateWindowGET(QnaReplyDTO dto, Model model) {
		QnaVO qna = service.getQnaTitle(dto.getQnum());
		model.addAttribute("qnaInfo", qna);
		model.addAttribute("qnaReplyInfo", replyService.getUpdateReply(dto.getRenum()));
		model.addAttribute("id", dto.getId());
		
		return "/qna/qnaReplyUpdate";
	}
}
