package com.book45.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.service.AlbumService;
import com.book45.service.BookService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private BookService bookService;
	
	@Autowired
	private AlbumService albumService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Criteria cri, Model model) {
		model.addAttribute("bookList", bookService.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, bookService.getTotal(cri)));
		model.addAttribute("albumList", albumService.getList(cri));
		model.addAttribute("albumPageMaker", new PageDTO(cri, albumService.getTotal(cri)));
		
		return "main";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void main() {
		
	}
}
