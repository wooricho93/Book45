package com.book45.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

import com.book45.domain.AlbumReviewDTO;
import com.book45.domain.AlbumVO;
import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.service.AlbumReviewService;
import com.book45.service.AlbumService;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/album/*")
@AllArgsConstructor
public class AlbumController {
	@Autowired
	private AlbumService service;
	
	@Autowired
	private AlbumReviewService reviewService;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) throws Exception {

		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);

		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	public void register() {
		
	}

	@PostMapping("/register")
	public String register(AlbumVO album, RedirectAttributes rttr) {

		log.info("register : " + album);

		service.register(album);

		rttr.addFlashAttribute("result", album.getNum());

		return "redirect:/album/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("productNum") Long productNum, @ModelAttribute("cri") Criteria cri, Model model) {

		log.info("/get or /modify");
		AlbumVO album = service.get(productNum);
		model.addAttribute("album", album);
	}

	@PostMapping("/modify")
	public String modify(AlbumVO album, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		log.info("Modify : " + album);

		if (service.modify(album)) {
			rttr.addFlashAttribute("result", "modify");
		}

		return "redirect:/album/list" + cri.getListLink();
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("productNum") Long productNum, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {

		log.info("remove..." + productNum);

		if (service.remove(productNum)) {
			rttr.addFlashAttribute("result", "delete");
		}
		
		return "redirect:/album/list" + cri.getListLink();
	}
	
	/* 리뷰 등록 */
	@GetMapping("/albumReviewEnroll/{id}")
	public String albumReviewEnrollWindowGET(@PathVariable("id") String id, Long productNum, Model model) {
			AlbumVO album = service.getProductNumName(productNum);
			
			model.addAttribute("album", album);
			model.addAttribute("id", id);
			
			return "/album/albumReviewEnroll";
	}
	
	/* 리뷰 수정 팝업창 */
	@GetMapping("/albumReviewUpdate")
	public String albumReviewUpdateWindowGET(AlbumReviewDTO dto, Model model) {
			AlbumVO album = service.getProductNumName(dto.getProductNum());
			model.addAttribute("album", album);
			model.addAttribute("albumReview", reviewService.getUpdateAlbumReview(dto.getNum()));
			model.addAttribute("id", dto.getId());
			
			return "/album/albumReviewUpdate";
	}

	/* 카테고리 조회 */
	@RequestMapping(value = "/categoryList/{catNum}", method = RequestMethod.GET)
	public String getCategoryInfo(@PathVariable("catNum") int catNum, HttpSession session, Criteria cri, Model model) {
		log.info("카테고리 선택 시 동작");

		String catName = "";
		
		switch(catNum) { case 1: catName = "Blu-ray"; break; case 2: catName = "J-POP"
		; break; case 3: catName = "LP(Vinyl) 전문관"; break; case 4: catName = "OST";
		break; case 5: catName = "POP"; break; case 6: catName = "가요"; break; case
		7: catName = "뮤직 DVD"; break; case 8: catName = "스타샵"; break; case 9:
		catName = "스페셜샵"; break; case 10: catName = "예약CD/LP"; break; case 11: catName =
		"재즈"; break; case 12: catName = "클래식"; break; }
		

		List<AlbumVO> albumCateList = service.getCategory(catName);
		model.addAttribute("category", albumCateList);
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		session.setAttribute("category", catName);
		albumCateList.forEach(n -> log.info(n));
		return "/album/categoryList";
	}
	
	/* 음반 베스트셀러 이동 */
	@GetMapping("/best")
	public void getBest(Criteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
	}
	
	/* 음반 신간 이동 */
	@GetMapping("/new")
	public void getNew(Criteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
	}
}
