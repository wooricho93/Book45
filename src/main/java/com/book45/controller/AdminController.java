package com.book45.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book45.domain.Criteria;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderListDTO;
import com.book45.domain.PageDTO;
import com.book45.service.AdminService;
import com.book45.service.AlbumService;
import com.book45.service.BookService;
import com.book45.service.MemberService;
import com.book45.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private AlbumService albumService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void adminMain() {
		log.info("관리자 페이지");
	}

	/* 관리자 페이지 - 회원 목록 */
	@GetMapping("/memberList")
	public void getMemberList(Model model) {
		log.info("회원 목록");
		List<MemberVO> list = memberService.getMemberList();
		model.addAttribute("memberList", list);
	}
	
	/* 관리자 - 회원 정보 수정 페이지 이동 */
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateByAdminGet(@RequestParam("id") String id, HttpSession session, Model model) {
		log.info("관리자 - 회원 정보 수정");
		MemberVO member = memberService.getMember(id);
		log.info(member);
		model.addAttribute("member2", member);
	}
	
	/* 관리자 - 회원 정보 수정 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateByAdminPost(@ModelAttribute("member") MemberVO member, RedirectAttributes rttr) {
		log.info("관리자 - 회원 정보 수정 중");
		log.info("member: " + member);
		
		String rawPw = "";
		String encodePw = "";
		
		rawPw = member.getPass();
		encodePw = pwEncoder.encode(rawPw);
		member.setPass(encodePw);
		
		if (memberService.updateByAdmin(member) == 1) {
			rttr.addFlashAttribute("result", "update");
		}
		log.info("updating member: " + member);
		log.info("관리자 - 회원 정보 수정 완료");
		return "redirect:/admin/memberList";
	}
	
   /* 관리자 - 회원 삭제 페이지로 이동 */
   @RequestMapping(value = "/delete", method = RequestMethod.GET)
   public void deleteMemberGet(@RequestParam("id") String id, HttpServletRequest request, Model model) {
      log.info("관리자 - 회원 삭제 페이지 이동");
      MemberVO member = memberService.getMember(id);
      log.info("member: " + member);
      HttpSession session = request.getSession();
      session.setAttribute("id", member.getId());
      model.addAttribute("member2", member);
   }
   
   /* 관리자 - 회원 삭제 */
   @RequestMapping(value="/delete", method= RequestMethod.POST)
   public String deleteMemberPost(HttpServletRequest request, RedirectAttributes rttr) {
      log.info("관리자 - 회원 삭제");
      HttpSession session = request.getSession();
      String id = (String)session.getAttribute("id");
      log.info("id: " + id);
      if (memberService.deleteMember(id) == 1) {
         rttr.addFlashAttribute("result", "delete");
      }
      return "redirect:/admin/memberList";
   }
   
   /* 관리자 - 회원 주문리스트 */
   @GetMapping("/orderList")
   public void orderListByAdminGet(Criteria cri, Model model) {
	   
	   List<OrderDTO> list = adminService.getOrderList(cri);
	   
	   if(!list.isEmpty()) {
		   
		   model.addAttribute("list", list);
		   model.addAttribute("pageMaker", new PageDTO(cri, memberService.getOrderTotal(cri)));
	   }else {
		   model.addAttribute("listcheck", "empty");
	   }
   }
   
   /* 도서 관리 */
   @RequestMapping(value = "/manageBook", method = RequestMethod.GET)
   public void manageBook(Criteria cri, Model model) {
	   model.addAttribute("list", bookService.getListDesc(cri));
	   model.addAttribute("pageMaker", new PageDTO(cri, bookService.getTotal(cri)));
   }
   
   /* 앨범 관리 */
   @RequestMapping(value = "/manageAlbum", method = RequestMethod.GET)
   public void manageAlbum(Criteria cri, Model model) {
	   model.addAttribute("list", albumService.getListDesc(cri));
	   model.addAttribute("pageMaker", new PageDTO(cri, albumService.getTotal(cri)));
   }
}
