package com.book45.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book45.domain.BookReviewDTO;
import com.book45.domain.BookVO;
import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.service.BookReviewService;
import com.book45.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/book/*")
@AllArgsConstructor
public class BookController {
	private BookService service;
	
	private BookReviewService reviewService;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list : "+ cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BookVO book, RedirectAttributes rttr) {
		log.info("register: " + book);
		
		service.register(book);
		
		rttr.addFlashAttribute("result: " + book.getNum());
		
		return "redirect:/book/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam Long isbn, @ModelAttribute("cri") Criteria cri ,Model model) {
		log.info("/get or /modify");
		model.addAttribute("book", service.get(isbn));
	}
	
	@PostMapping("/modify")
	public String modify(BookVO book, @ModelAttribute("cri") Criteria cri ,RedirectAttributes rttr) {
		log.info("modify : "+book);
		
		if(service.modify(book)) {
			rttr.addFlashAttribute("result", "modify");
		}
		
		return "redirect:/book/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("isbn") Long isbn, @ModelAttribute("cri") Criteria cri , RedirectAttributes rttr) {
		log.info("remove : " + isbn);
		
		if(service.remove(isbn)) {
			rttr.addFlashAttribute("result","delete");
		}
		
		return "redirect:/admin/manageBook" +cri.getListLink();
	}
	
	/* 리뷰 등록 */
	@GetMapping("/bookReviewEnroll/{id}")
	public String bookReviewEnrollWindowGET(@PathVariable("id") String id, Long isbn, Model model) {
			BookVO book = service.getIsbnName(isbn);
			model.addAttribute("book", book);
			model.addAttribute("id", id);
			
			return "/book/bookReviewEnroll";
	}
	
	/* 리뷰 수정 팝업창 */
	@GetMapping("/bookReviewUpdate")
	public String bookReviewUpdateWindowGET(BookReviewDTO dto, Model model) {
			BookVO book = service.getIsbnName(dto.getIsbn());
			model.addAttribute("book", book);
			model.addAttribute("bookReview", reviewService.getUpdateBookReview(dto.getNum()));
			model.addAttribute("id", dto.getId());
			
			return "/book/bookReviewUpdate";
	}
	
	/* 카테고리 조회 */
	@RequestMapping(value = "/categoryList/{catNum}", method = RequestMethod.GET)
	public String getCategoryInfo(@PathVariable("catNum") int catNum, HttpSession session, Criteria cri, Model model) {
		log.info("카테고리 선택 시 동작");

		String catName = "";
		
		switch(catNum) { case 1: catName = "IT 모바일"; break; case 2: catName = "가정 살림"
		; break; case 3: catName = "경제 경영"; break; case 4: catName = "국어 외국어 사전";
		break; case 5: catName = "만화/라이트노벨"; break; case 6: catName = "사회 정치"; break; case
		7: catName = "소설/시/희곡"; break; case 8: catName = "수험서 자격증"; break; case 9:
		catName = "어린이"; break; case 10: catName = "에세이"; break; case 11: catName =
		"예술"; break; case 12: catName = "유아"; break;
		case 13: catName = "인문"; break; case 14: catName = "자기계발"; break;
		case 15: catName = "자연과학"; break; case 16: catName = "종교"; break;
		case 17: catName = "청소년"; break; }
		

		List<BookVO> bookCateList = service.getCategory(catName);
		model.addAttribute("category", bookCateList);
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
		model.addAttribute("catNum", catNum);
		session.setAttribute("category", catName);
		bookCateList.forEach(n -> log.info(n));
		return "/book/categoryList";
	}
	
	/* 도서 베스트셀러 이동 */
	@GetMapping("/best")
	public void getBest(Criteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
	}
	
	/* 도서 신간 이동 */
	@GetMapping("/new")
	public void getNew(Criteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
	}
}
