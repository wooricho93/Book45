package com.book45.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book45.domain.CartDTO;
import com.book45.domain.MemberVO;
import com.book45.service.AlbumService;
import com.book45.service.BookService;
import com.book45.service.CartService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart/*")
public class CartController {
	@Autowired
	private CartService cartService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private AlbumService albumService;
	
	/* 장바구니 리스트 */
	@RequestMapping(value = "/cartList/{id}", method = RequestMethod.GET)
	public String getCartList(@PathVariable("id") String id, HttpServletRequest request, Model model) throws Exception {
		log.info("장바구니 리스트");
		List<CartDTO> list = cartService.getCartList(id);
		if(!list.isEmpty()) {
		model.addAttribute("cartList", list);
		} else {
			model.addAttribute("listCheck", "empty");
		}
		list.forEach(n -> log.info("장바구니 리스트: " + n));
		return "/cart/cartList";
	}
	
	/* 장바구니에 책 추가 */
	@ResponseBody
	@RequestMapping(value = "/addBookCart", method = RequestMethod.POST)
	public String addBookCart(CartDTO cart, HttpSession session, Model model) throws Exception {
		log.info("장바구니 책 추가");
		MemberVO member = (MemberVO)session.getAttribute("member");

		if (member == null) {
			return "5";
		}
		
		model.addAttribute("bookStock", bookService.get(cart.getIsbn()).getStock());
		log.info("장바구니에 담은 책: " + bookService.get(cart.getIsbn()).getStock());
		session.setAttribute("id", cart.getId());
		int result = cartService.addBookCart(cart);
		return result + "";
	}
	
	/* 장바구니에 앨범 추가 */
	@ResponseBody
	@RequestMapping(value = "/addAlbumCart", method = RequestMethod.POST)
	public String addAlbumCart(CartDTO cart, HttpSession session, Model model) {
		log.info("장바구니 앨범 추가");
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		if (member == null) {
			return "5";
		}
		
		model.addAttribute("albumStock", albumService.get(cart.getProductNum()));
		
		int result = cartService.addAlbumCart(cart);
		return result + "";
	}

	/* 장바구니 상품 수량 수정 */
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyCount(CartDTO cart, RedirectAttributes rttr) {
		log.info("장바구니 수량 수정");
		
		if (cartService.modifyCount(cart) == 1) {
			rttr.addFlashAttribute("result", "modify");
		}
		
		return "redirect:/cart/cartList/" + cart.getId();
	}
	
	/* 장바구니 상품 삭제 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteCart(CartDTO cart, RedirectAttributes rttr) {
		log.info("장바구니 상품 삭제");
		log.info("id: " + cart.getId());
		log.info("cartNum: " + cart.getCartNum());
		
		if (cartService.deleteCart(cart.getCartNum()) == 1) {
			rttr.addFlashAttribute("result", "delete");
		}
		return "redirect:/cart/cartList/" + cart.getId();
	}
	
	/* 장바구니 상품 선택 삭제 */
	@RequestMapping(value = "/selectDelete", method = RequestMethod.POST)
	@ResponseBody
	public int selectDelete(HttpSession session, @RequestParam(value = "checkBox[]") List<String> checkArr, CartDTO cart) {
		log.info("장바구니 선택 삭제");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String id = member.getId();
		
		int result = 0;
		int cartNum = 0;
		
		if (member != null) {
			cart.setId(id);
			
			for (String i : checkArr) {
				cartNum = Integer.parseInt(i);
				cart.setCartNum(cartNum);
				cartService.selectDelete(cart);
			}
			
			result = 1;
		}
		return result;
	}
	
	/* 장바구니 상품 전체 삭제 */
	@RequestMapping(value = "/deleteAll", method = RequestMethod.GET)
	public String deleteAll(CartDTO cart, HttpSession session, RedirectAttributes rttr) {
		log.info("장바구니 전체 삭제");
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String id = member.getId();
		
		log.info("아이디: " + id);
		if (cartService.deleteAll(id) == 1) {
			rttr.addFlashAttribute("result", "deleteAll");
		}
		
		log.info("아이디: " + id);
		return "redirect:/cart/cartList/" + id;
	}
}
