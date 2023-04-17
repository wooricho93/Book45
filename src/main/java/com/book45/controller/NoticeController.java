package com.book45.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book45.domain.Criteria;
import com.book45.domain.NoticeVO;
import com.book45.domain.PageDTO;
import com.book45.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {
	@Autowired
	private NoticeService service;
	
	@GetMapping("/list")
	public void list(Criteria cri,  Model model) {
		log.info("NoticeList==============>");
		
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(NoticeVO nVo, RedirectAttributes rttr) {
		log.info("NoticeRegister=========> " + nVo);
		service.register(nVo);
		
		rttr.addFlashAttribute("result", nVo.getNum());
		
		return "redirect:/notice/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("num") Long num, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("get or modify======>");
		model.addAttribute("notice", service.get(num));
	}

	/* 공지글 수정하기 */
	@PostMapping("/modify")
	public String modify(@ModelAttribute("nVo") NoticeVO nVo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify===>");
		
		if (service.modify(nVo)) {
			rttr.addFlashAttribute("result", "modify");
		}
		
		return "redirect:/notice/list"+ cri.getListLink();
	}
	/* 공지글 삭제 */
	@PostMapping("/remove")
	public String remove(@RequestParam("num") Long num, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove==>>");
		
		if(service.remove(num)) {
			rttr.addFlashAttribute("result", "delete");
			
		};
		
		return "redirect:/notice/list"+ cri.getListLink();
	}
}
