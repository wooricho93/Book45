package com.book45.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.book45.domain.MemberVO;
import com.book45.domain.OrderCancelDTO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;
import com.book45.domain.OrderListDTO;
import com.book45.domain.OrderPageDTO;
import com.book45.domain.OrderPageItemDTO;
import com.book45.service.MemberService;
import com.book45.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
public class OrderController {
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	/* 결제 창으로 이동 */
	@RequestMapping(value="/orderPage/{id}", method = RequestMethod.GET)
    public String orderPage(@PathVariable("id") String id, @RequestParam(required=false, value="isbn") Long isbn , @RequestParam(required=false, value="productNum") Long productNum, OrderPageDTO orderPage, Model model) {
       log.info("주문 페이지"); 
       log.info("id: " + id);
       log.info("orders: " + orderPage.getOrders());
       
       Long inputIsbn = null;
       Long inputProductNum = null;
       
       for(OrderPageItemDTO or : orderPage.getOrders()) {
          
          if(inputIsbn == null)
             inputIsbn = or.getIsbn();
          if(inputProductNum == null)
             inputProductNum = or.getProductNum();
          
          log.info("도서번호: " + inputIsbn);
          log.info("상품번호: " + inputProductNum);
       }
       
       if (inputProductNum == null) {
          if(inputIsbn != null) {
             model.addAttribute("orderBookList", orderService.getBooksInfo(orderPage.getOrders()));
             model.addAttribute("member", memberService.getMember(id));
          
             log.info("getBooksInfo: "+ orderService.getBooksInfo(orderPage.getOrders()));
          }
       } else if (inputIsbn == null) {
          if(inputProductNum != null) {
             model.addAttribute("orderAlbumList", orderService.getAlbumsInfo(orderPage.getOrders()));
             model.addAttribute("member", memberService.getMember(id));
          
             log.info("getAlbumsInfo: "+ orderService.getAlbumsInfo(orderPage.getOrders()));
          }
       } else if (inputIsbn != null && inputProductNum != null){
          
          List<OrderPageItemDTO> IsbnDTOList = new ArrayList<>();
          List<OrderPageItemDTO> ProductDTOList = new ArrayList<>();
          
          for(OrderPageItemDTO or : orderPage.getOrders()) {
             if(or.getIsbn() != null) IsbnDTOList.add(or);
             else if (or.getProductNum() != null) ProductDTOList.add(or);
          }
          
          model.addAttribute("orderBookList", orderService.getBooksInfo(IsbnDTOList)); 
          model.addAttribute("orderAlbumList", orderService.getAlbumsInfo(ProductDTOList));
          model.addAttribute("member", memberService.getMember(id));      
             
          log.info("getBooksInfo: "+ orderService.getBooksInfo(IsbnDTOList));
          log.info("getAlbumsInfo: "+ orderService.getAlbumsInfo(ProductDTOList));
       }
       
       return "/order/orderPage";
    }
	
	/* 결제 기능 동작 */
	@RequestMapping(value="/order", method = {RequestMethod.POST, RequestMethod.GET})
	public String orderPagePost(OrderDTO ord, HttpSession session, Model model) {
		Long isbn = null;
		Long productNum = null;
		
		for (OrderItemDTO oit : ord.getOrders()) {
			if (isbn == null) {
				isbn = oit.getIsbn();
			}
			
			if (productNum == null) {
				productNum = oit.getProductNum();
			}
		}
		
		if (productNum == null) {
			if (isbn != null) {
				orderService.orderBook(ord);
			}
		} else if (isbn == null) {
			if (productNum != null) {
				orderService.orderAlbum(ord);
			}
		}
		
		session.setAttribute("totalPrice", ord.getTotalPrice());
		
		log.info("주문내역: " + ord);
		
		return "redirect:/main";
	}
	
	/* 회원 주문 삭제 */
	@RequestMapping(value="/memberOrderCancel")
	public String membeOrderCancelPOST(OrderCancelDTO orderCancel) {
		log.info(orderCancel.getId());
		orderService.orderCancel(orderCancel);
		return "redirect:/member/orderList?id=" + orderCancel.getId();
	}
	
	/* 관리자 주문 삭제 */
	@RequestMapping(value="/adminOrderCancel")
	public String adminOrderCancelPOST(OrderCancelDTO orderCancel) {
		
		orderService.orderCancel(orderCancel);
		return "redirect:/admin/orderList?keyword=" + orderCancel.getKeyword() + "&amount="+orderCancel.getAmount() + "&pageNum="+orderCancel.getPageNum();
	}
	
	/* 회원 주문 상세보기 */
	@RequestMapping(value="/orderDetail", method=RequestMethod.GET)
	public void orderDetail(@RequestParam("orderNum") String orderNum, HttpSession session, Model model, OrderDTO order) {
		log.info("주문 내역 상세보기 페이지");
		log.info("주문번호: " + orderNum);
		MemberVO member = (MemberVO)session.getAttribute("member");
		log.info(member);
		String id = member.getId();
	  
		order.setId(id);
		order.setOrderNum(orderNum);

    	List<OrderListDTO> orderBookDetail = orderService.bookOrderDetail(order);
    	if (orderBookDetail.size() != 0) {
    		if (orderBookDetail.get(0).getIsbn() != null && orderBookDetail.get(0).getProductNum() == null) {
	    		model.addAttribute("orderBookDetail", orderBookDetail);
	    		model.addAttribute("orderDate", orderBookDetail.get(0).getOrderDate());
	    		model.addAttribute("orderNum", orderBookDetail.get(0).getOrderNum());
	    		model.addAttribute("name", orderBookDetail.get(0).getName());
	    		model.addAttribute("zipCode", orderBookDetail.get(0).getZipCode());
	    		model.addAttribute("addressRoad", orderBookDetail.get(0).getAddressRoad());
	    		model.addAttribute("addressDetail", orderBookDetail.get(0).getAddressDetail());
	    		model.addAttribute("phone", orderBookDetail.get(0).getPhone());
	    		model.addAttribute("orderState", orderBookDetail.get(0).getOrderState());
	    		model.addAttribute("orderBookDetail", orderBookDetail);
	    	}
    	}
    	
		List<OrderListDTO> orderAlbumDetail = orderService.albumOrderDetail(order);
		if (orderAlbumDetail.size() != 0) {
			if (orderAlbumDetail.get(0).getProductNum() != null && orderAlbumDetail.get(0).getIsbn() == null) {
	    		model.addAttribute("orderAlbumDetail", orderAlbumDetail);
	    		model.addAttribute("orderDateA", orderAlbumDetail.get(0).getOrderDate());
	    		model.addAttribute("orderNumA", orderAlbumDetail.get(0).getOrderNum());
	    		model.addAttribute("nameA", orderAlbumDetail.get(0).getName());
	    		model.addAttribute("zipCodeA", orderAlbumDetail.get(0).getZipCode());
	    		model.addAttribute("addressRoadA", orderAlbumDetail.get(0).getAddressRoad());
	    		model.addAttribute("addressDetailA", orderAlbumDetail.get(0).getAddressDetail());
	    		model.addAttribute("phoneA", orderAlbumDetail.get(0).getPhone());
	    		model.addAttribute("orderStateA", orderAlbumDetail.get(0).getOrderState());
	    		model.addAttribute("orderAlbumDetail", orderAlbumDetail);
	    	}
		}
	}
}
