package com.book45.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.book45.domain.AlbumVO;
import com.book45.domain.BookVO;
import com.book45.domain.CartDTO;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderCancelDTO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;
import com.book45.domain.OrderListDTO;
import com.book45.domain.OrderPageItemDTO;
import com.book45.mapper.AlbumMapper;
import com.book45.mapper.BookMapper;
import com.book45.mapper.CartMapper;
import com.book45.mapper.MemberMapper;
import com.book45.mapper.OrderMapper;

import lombok.extern.log4j.Log4j;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderMapper orderMapper;

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private CartMapper cartMapper;

	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private AlbumMapper albumMapper;

	@Override
	public List<OrderPageItemDTO> getBooksInfo(List<OrderPageItemDTO> orders) {
		List<OrderPageItemDTO> result = new ArrayList<>();

		for (OrderPageItemDTO opi : orders) {
			OrderPageItemDTO booksInfo = orderMapper.getBooksInfo(opi.getIsbn());
			booksInfo.setAmount(opi.getAmount());
			booksInfo.initTotal();
			result.add(booksInfo);
		}

		return result;
	}

	@Override
	public List<OrderPageItemDTO> getAlbumsInfo(List<OrderPageItemDTO> orderPageItem) {
		List<OrderPageItemDTO> result = new ArrayList<>();

		for (OrderPageItemDTO opi : orderPageItem) {
			OrderPageItemDTO albumsInfo = orderMapper.getAlbumsInfo(opi.getProductNum());
			albumsInfo.setAmount(opi.getAmount());
			albumsInfo.initTotal();
			result.add(albumsInfo);
		}

		return result;
	}

	/* 도서 주문 */
	@Override
	@Transactional
	public void orderBook(OrderDTO ord) {
		/* 사용할 데이터 가져오기 */
		/* 회원 정보 */
		/* 주문한 사람의 정보를 id를 통해 가져온다. */
		MemberVO member = memberMapper.getMember(ord.getId());
		
		System.out.println("member: " + member);
		System.out.println("주문 내역: " + ord.getOrders());
		
		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItems = orderMapper.getOrderBooksInfo(oit.getIsbn());
	
			// 수량 셋팅
			orderItems.setAmount(oit.getAmount());
			// 기본 정보 셋팅
			orderItems.initTotal();
			// List객체 추가
			ords.add(orderItems);
		}
		
		// OrderDTO 셋팅
		ord.setOrders(ords);
		
		ord.getOrderPriceInfo();
	
		/* DB 주문, 주문상품(,배송정보) 넣기 */
		/* orderNum만들기 및 OrderDTO객체 orderNum에 저장 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyMMddhhmmss");
		String orderNum = member.getId() + format.format(date);
		String id = member.getId();
		ord.setOrderNum(orderNum);
	
		/* DB넣기 */
		orderMapper.enrollOrder(ord);
		for (OrderItemDTO oit : ord.getOrders()) { // orderItem 등록
			oit.setOrderNum(orderNum);
			oit.setId(id);
			orderMapper.enrollOrderBookItem(oit);
		}
	
		/* 비용 포인트 변동 적용 */
	
		/* 포인트 차감, 포인트 증가 & 변동 포인트(point) Member객체 적용 */
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint(); // 기존 포인트 - 사용 포인트
		member.setPoint(calPoint);
	
		/* 변동 포인트 DB적용 */
		orderMapper.deductPoint(member);
	
		/* 재고 변동 적용 */
		for (OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			BookVO book = bookMapper.read(oit.getIsbn());
			book.setStock(book.getStock() - oit.getAmount());
			/* 변동 값 DB 적용 */
			orderMapper.deductBookStock(book);
		}
	
		/* 장바구니 제거 */
		for (OrderItemDTO oit : ord.getOrders()) {
			CartDTO cart = new CartDTO();
			cart.setId(ord.getId());
			cart.setIsbn(oit.getIsbn());
	
			cartMapper.deleteBookOrderCart(cart);
		}
	}
	
	/* 앨범 주문 */
	@Override
	@Transactional
	public void orderAlbum(OrderDTO ord) {
		/* 사용할 데이터 가져오기 */
		/* 회원 정보 */
		/* 주문한 사람의 정보를 id를 통해 가져온다. */
		MemberVO member = memberMapper.getMember(ord.getId());
		
		System.out.println("member: " + member);
		System.out.println("주문 내역: " + ord.getOrders());
		
		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItems = orderMapper.getOrderAlbumsInfo(oit.getProductNum());
	
			// 수량 셋팅
			orderItems.setAmount(oit.getAmount());
			// 기본 정보 셋팅
			orderItems.initTotal();
			// List객체 추가
			ords.add(orderItems);
		}
		
		// OrderDTO 셋팅
		ord.setOrders(ords);
		
		ord.getOrderPriceInfo();
	
		/* DB 주문, 주문상품(,배송정보) 넣기 */
		/* orderNum만들기 및 OrderDTO객체 orderNum에 저장 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyMMddhhmmss");
		String orderNum = member.getId() + format.format(date);
		String id = member.getId();
		ord.setOrderNum(orderNum);
	
		/* DB넣기 */
		orderMapper.enrollOrder(ord);
		for (OrderItemDTO oit : ord.getOrders()) { // orderItem 등록
			oit.setOrderNum(orderNum);
			oit.setId(id);
			orderMapper.enrollOrderAlbumItem(oit);
		}
	
		/* 비용 포인트 변동 적용 */
	
		/* 포인트 차감, 포인트 증가 & 변동 포인트(point) Member객체 적용 */
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint(); // 기존 포인트 - 사용 포인트
		member.setPoint(calPoint);
	
		/* 변동 포인트 DB적용 */
		orderMapper.deductPoint(member);
	
		/* 재고 변동 적용 */
		for (OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			AlbumVO album = albumMapper.read(oit.getProductNum());
			album.setStock(album.getStock() - oit.getAmount());
			/* 변동 값 DB 적용 */
			orderMapper.deductAlbumStock(album);
		}
	
		/* 장바구니 제거 */
		for (OrderItemDTO oit : ord.getOrders()) {
			CartDTO cart = new CartDTO();
			cart.setId(ord.getId());
			cart.setProductNum(oit.getProductNum());
	
			cartMapper.deleteAlbumOrderCart(cart);
		}
	}
	
	/* 상품 주문 */
	@Override
	@Transactional
	public void orderItem(OrderDTO ord) {
		/* 사용할 데이터 가져오기 */
		/* 회원 정보 */
		/* 주문한 사람의 정보를 id를 통해 가져온다. */
		MemberVO member = memberMapper.getMember(ord.getId());
		
		System.out.println("member: " + member);
		System.out.println("주문 내역: " + ord.getOrders());
		
		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		OrderItemDTO orderItems = new OrderItemDTO();
		
		for(OrderItemDTO oit : ord.getOrders()) {
			orderItems = orderMapper.getOrderBooksInfo(oit.getIsbn());
			
			// 수량 셋팅
			orderItems.setAmount(oit.getAmount());
			// 기본 정보 셋팅
			orderItems.initTotal();
			
			// List객체 추가 
			ords.add(orderItems);
		}
		
		for (OrderItemDTO oit : ord.getOrders()) {
			orderItems = orderMapper.getOrderAlbumsInfo(oit.getProductNum());
			
			// 수량 셋팅
			orderItems.setAmount(oit.getAmount());
			// 기본 정보 셋팅
			orderItems.initTotal();
			// List객체 추가
			ords.add(orderItems);
		}
		
		ord.setOrders(ords);
		
		ord.getOrderPriceInfo();
	
		/* DB 주문, 주문상품(,배송정보) 넣기 */
		/* orderNum만들기 및 OrderDTO객체 orderNum에 저장 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyMMddhhmmss");
		String orderNum = member.getId() + format.format(date);
		String id = member.getId();
		ord.setOrderNum(orderNum);
	
		/* DB넣기 */
		orderMapper.enrollOrder(ord);
		for (OrderItemDTO oit : ord.getOrders()) { // orderItem 등록
			oit.setOrderNum(orderNum);
			oit.setId(id);
			orderMapper.enrollOrderBookItem(oit);
			orderMapper.enrollOrderAlbumItem(oit);
		}
	
		/* 비용 포인트 변동 적용 */
	
		/* 포인트 차감, 포인트 증가 & 변동 포인트(point) Member객체 적용 */
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint(); // 기존 포인트 - 사용 포인트
		member.setPoint(calPoint);
	
		/* 변동 포인트 DB적용 */
		orderMapper.deductPoint(member);
	
		/* 재고 변동 적용 */
		for (OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			BookVO book = bookMapper.read(oit.getIsbn());
			AlbumVO album = albumMapper.read(oit.getProductNum());
			book.setStock(book.getStock() - oit.getAmount());
			album.setStock(album.getStock() - oit.getAmount());
			/* 변동 값 DB 적용 */
			orderMapper.deductBookStock(book);
			orderMapper.deductAlbumStock(album);
		}
	
		/* 장바구니 제거 */
		for (OrderItemDTO oit : ord.getOrders()) {
			CartDTO cart = new CartDTO();
			cart.setId(ord.getId());
			cart.setIsbn(oit.getIsbn());
			cart.setProductNum(oit.getProductNum());
			
			cartMapper.deleteBookOrderCart(cart);
			cartMapper.deleteAlbumOrderCart(cart);
		}
	}
		
	@Override
	public void orderCancel(OrderCancelDTO orderCancel) {
		/* 주문, 주문상품 객체 */
		/* 회원 */
		MemberVO member = memberMapper.getMember(orderCancel.getId());
		/* 주문 상품 */
		List<OrderItemDTO> ords = orderMapper.getOrderItemInfo(orderCancel.getOrderNum());
		
		for(OrderItemDTO ord : ords) {
			ord.initTotal();
		}
		
		/* 주문 */
		OrderDTO orders = orderMapper.getOrder(orderCancel.getOrderNum());
		orders.setOrders(ords);
		orders.getOrderPriceInfo();

		/* 주문상품 취소 DB */
		orderMapper.orderCancel(orderCancel.getOrderNum());
		
		/* 포인트, 재고 반환 */
		/* 포인트 */
		int calPoint = member.getPoint();
		calPoint = calPoint + orders.getUsePoint();
		member.setPoint(calPoint);
		
		/* DB적용 */
		orderMapper.deductPoint(member);
		/* 재고 */
		for(OrderItemDTO ord : orders.getOrders()) {
			if (ord.getProductNum() == null) {
				BookVO book = bookMapper.read(ord.getIsbn());
				book.setStock(book.getStock() + ord.getAmount());
				orderMapper.deductBookStock(book);
			} else if (ord.getIsbn() == null) {
				AlbumVO album = albumMapper.read(ord.getProductNum());
				album.setStock(album.getStock() + ord.getAmount());
				orderMapper.deductAlbumStock(album);
			} else if (ord.getIsbn() != null && ord.getProductNum() != null) {
				BookVO book = bookMapper.read(ord.getIsbn());
				book.setStock(book.getStock() + ord.getAmount());
				orderMapper.deductBookStock(book);
				
				AlbumVO album = albumMapper.read(ord.getProductNum());
				album.setStock(album.getStock() + ord.getAmount());
				orderMapper.deductAlbumStock(album);
			}
		}
	}

	@Override
	public int enrollOrder(OrderDTO ord) {
		return orderMapper.enrollOrder(ord);
	}

	@Override
	public int enrollOrderBookItem(OrderItemDTO orderItem) {
		return orderMapper.enrollOrderBookItem(orderItem);
	}

	@Override
	public int enrollOrderAlbumItem(OrderItemDTO orderItem) {
		return orderMapper.enrollOrderAlbumItem(orderItem);
	}

	@Override
	public List<OrderListDTO> bookOrderDetail(OrderDTO order) {
		return orderMapper.bookOrderDetail(order);
	}
   
	@Override
	public List<OrderListDTO> albumOrderDetail(OrderDTO order) {
		return orderMapper.albumOrderDetail(order);
	}
}
