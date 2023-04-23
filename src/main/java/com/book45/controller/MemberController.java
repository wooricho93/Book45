package com.book45.controller;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book45.domain.KakaoDTO;
import com.book45.domain.MemberOrderCancelDTO;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;
import com.book45.domain.OrderListDTO;
import com.book45.domain.OrderPageItemDTO;
import com.book45.service.MemberService;
import com.book45.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	/* 회원 약관 페이지 이동 */
	@RequestMapping(value = "/terms", method = RequestMethod.GET)
	public void getTerms() {
		log.info("회원 가입 약관 페이지");
	}
	
	/* 회원가입 페이지 이동 */
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void joinGet() {
		log.info("회원가입 페이지");
	}
	
	/* 회원가입 */
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(MemberVO member) throws Exception {
		log.info("회원가입 진행 중");
		String rawPw = "";
		String encodePw = "";
		
		rawPw = member.getPass();
		encodePw = pwEncoder.encode(rawPw);
		member.setPass(encodePw);
		memberService.memberJoin(member);
		log.info("회원가입 성공");
		
		return "redirect:/main";
	}
	
	/* 아이디 중복체크 */
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public String idCheckPost(String id) throws Exception {
		log.info("아이디 중복체크");
		int result = memberService.idCheck(id);
		
		if (result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	/* 닉네임 중복체크 */
	@RequestMapping(value = "/nicknameCheck", method = RequestMethod.POST)
	@ResponseBody
	public String nickNameCheck(String nickname) {
		log.info("닉네임 중복체크");
		int result = memberService.nicknameCheck(nickname);
		
		if (result == 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	/* 이메일 인증 */
	@RequestMapping(value = "/emailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String emailCheckGet(String email) throws Exception {
		log.info("이메일 데이터 전송 확인");
		log.info("이메일 주소: " + email);
		
		Random random = new Random();
		int checkCode = random.nextInt(888888) + 111111;
		log.info("인증번호: " + checkCode);
		
		
		String setForm = "slim903@naver.com";
		String toEmail = email;
		String title = "BOOK45 회원가입 인증 이메일입니다.";
		String content = "BOOK45 홈페이지를 방문해 주셔서 감사합니다. <br><br> 인증번호는 " + checkCode + "입니다. <br> 해당 인증번호를 인증번호 확인란에 기입해 주시기 바랍니다.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(setForm);
            helper.setTo(toEmail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
		
		String code = Integer.toString(checkCode);
		
		return code;
	}
	
	/* 로그인 페이지 이동 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGet() {
		log.info("로그인 페이지");
	}
	
	/* 로그인 */
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginPost(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {
		HttpSession session = request.getSession();
		
		// 회원이 직접 정한 비밀번호
		String rawPw = "";
		// 암호화가 이루어진 비밀번호
		String encodePw = "";
		
		MemberVO member2 = memberService.memberLogin(member);
		
		if (member2 != null) {
			rawPw = member.getPass();
			encodePw = member2.getPass();
			
			if (pwEncoder.matches(rawPw, encodePw) == true) { // 비밀번호 일치 여부
				member2.setPass("");
				session.setAttribute("member", member2);
				return "redirect:/main";
			} else {
				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login";
			}
		} else { // 일치하는 아이디가 없을 때
			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login";
		}
	}
	
	/* 카카오 로그인 */
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code") String code, HttpSession session) {
		String accessToken = memberService.getAccessToken(code);
		log.info("code: " + code);
		KakaoDTO userInfo = memberService.getUserInfo(accessToken);
		log.info("accessToken: " + accessToken);
		log.info("nickname: " + userInfo.getNickname());
		log.info("email: " + userInfo.getEmail());
		
		String id = userInfo.getEmail().split("@")[0];
		
		session.setAttribute("kakaoNickname", userInfo.getNickname());
		session.setAttribute("kakaoEmail", userInfo.getEmail());
		session.setAttribute("kakaoId", id);
		
		MemberVO member = memberService.getMember(id);
		
		log.info("회원정보: " + member);
		
		if (member != null) {
			session.setAttribute("member", member);
			session.setAttribute("accessToken", accessToken);
			return "redirect:/main";
		} else {
			return "/member/kakaoJoin";
		}
	}
	
	/* 메인 페이지 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutGet(HttpSession session) {
		log.info("메인 페이지에서 로그아웃 시도 중");
		memberService.kakaoLogout((String)session.getAttribute("accessToken"));
		session.removeAttribute("accessToken");
		session.invalidate();
		
		return "redirect:/main";
	}
	
	/* 비동기 방식 로그아웃 */
	@RequestMapping(value = "/logout.do", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPost(HttpSession session) {
		log.info("비동기 방식 로그아웃 시도 중");
		memberService.kakaoLogout((String)session.getAttribute("accessToken"));
		session.removeAttribute("accessToken");
		session.removeAttribute("kakaoEmail");
		session.removeAttribute("kakaoNickname");
		session.invalidate();
	}
	
	/* 마이페이지 */
	@RequestMapping(value = "/myPage/{id}", method = RequestMethod.GET)
	public String myPage(@PathVariable("id") String id, Model model) {
		log.info("마이페이지");
		MemberVO member = memberService.getMember(id);
		
		log.info("member: " + member);
		log.info("id: " + id);
		model.addAttribute("member", member);
		return "/member/myPage";
	}
	
	@GetMapping("/myPage")
	public void myPageGet() {
		
	}
	
	/* 회원 정보 수정 페이지 이동 */
	@GetMapping("/update/{id}")
	public String updateMyInfoGet(@PathVariable("id") String id, Model model) {
		log.info("회원 정보 수정");
		MemberVO member = memberService.getMember(id);
		log.info("member: " + member);
		log.info("id: " + id);
		model.addAttribute("member", member);
		return "/member/update";
	}
	
	/* 회원 정보 수정 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateMyInfoPost(@ModelAttribute("member") MemberVO member, RedirectAttributes rttr) throws Exception {
		log.info("회원 정보 수정 중");
		
		String rawPw = "";
		String encodePw = "";
		
		rawPw = member.getPass();
		encodePw = pwEncoder.encode(rawPw);
		member.setPass(encodePw);
		
		if (memberService.updateMypage(member) == 1) {
			rttr.addFlashAttribute("result", "update");
		}
		
		log.info("member: " + member);
		return "/member/myPage";
	}
	
	/* 회원 탈퇴 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteMember(@RequestParam("id") String id, RedirectAttributes rttr) {
		log.info("회원 탈퇴");

		if (memberService.deleteMember(id) == 1) {
			rttr.addFlashAttribute("result", "delete");
		}
		
		return "redirect:/member/logout";
	}
	
	/* 회원 주문 리스트 */
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public void orderList(String id, HttpSession session, Model model) throws Exception {
		log.info("id: " + id);
	      
		List<OrderDTO> list = memberService.getOrderList(id);
		log.info("list: " + list);
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
		}
		
		model.addAttribute("list", list);
	}
	
	/* 회원 주문 취소 */
	@RequestMapping("/orderCancel")
	   public String orderCancel(MemberOrderCancelDTO orderCancel) {
	      memberService.orderCancel(orderCancel);
	      
	      return "redirect:/member/orderList";
	}
}
