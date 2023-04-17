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

import com.book45.domain.BoardVO;
import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.domain.ReplyDTO;
import com.book45.service.BoardService;
import com.book45.service.ReplyService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@Autowired
	private ReplyService replyService;
	
	@GetMapping("/boardList")
	public void list(Criteria cri, Model model) {
		log.info("자유 게시판 목록 사이트로 이동함" + cri);
		model.addAttribute("list" , service.getList(cri));
		
		int total = service.getTotal(cri);
		
		log.info("total");
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PostMapping("/boardRegister")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("자유 게시판 등록 중" + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result : ", board.getNum());
		
		return "redirect:/board/boardList";
	}
	
	@GetMapping({"/boardGet", "/boardModify"})
	public void get(@RequestParam("num") int num, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("자유 게시판 상세페이지 이동 / 자유 게시판 등록페이지 이동");
		
		model.addAttribute("board", service.get(num));
	}
	
	@PostMapping("/boardModify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("자유 게시판 수정 중" + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/boardList" + cri.getListLink();
	}
	
	@PostMapping("/boardRemove")
	public String remove(@RequestParam("num") int num, Criteria cri, RedirectAttributes rttr) {
		log.info("자유 게시판 삭제 중" + num);
		
		if (service.remove(num)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/boardList" + cri.getListLink();
	}
	
	@GetMapping("/boardRegister")
	public void register() {
		
	}
	
	/* 댓글 작성 */
	@GetMapping("/boardReplyEnroll/{memberId}")
	public String replyWindowGet(@PathVariable("memberId")String memberId, int num, Model model) {
		BoardVO board = service.getBoardNumTitle(num);
		
		model.addAttribute("boardInfo", board);
		model.addAttribute("memberId", memberId);
		
		return "/board/boardReplyEnroll";
	}
	
	/* 댓글 수정 팝업창 */
	@GetMapping("/boardReplyUpdate")
	public String replyUpdateWindowGET(ReplyDTO dto, Model model) {
		BoardVO board = service.getBoardNumTitle(dto.getBoardNum());
		model.addAttribute("boardInfo", board);
		model.addAttribute("replyInfo", replyService.getUpdateReply(dto.getReplyNum()));
		model.addAttribute("memberId", dto.getMemberId());
		
		return "/board/boardReplyUpdate";
	}
}
