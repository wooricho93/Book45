package com.book45.mapper;

import java.util.List;

import com.book45.domain.AlbumVO;
import com.book45.domain.BookVO;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;
import com.book45.domain.OrderListDTO;
import com.book45.domain.OrderPageItemDTO;

public interface OrderMapper {
	//주문한 도서 상품 정보(주문페이지)
	public OrderPageItemDTO getBooksInfo(Long isbn);
	
	//주문한 앨범 상품 정보(주문페이지)
	public OrderPageItemDTO getAlbumsInfo(Long productNum);
	
	//도서 주문 상품 정보(주문 처리). 도서의 아이디, 가격, 할인율을 가져오는 메서드
	public OrderItemDTO getOrderBooksInfo(Long isbn);
	
	//앨범 주문 상품 정보(주문 처리). 앨범의 아이디, 가격, 할인율을 가져오는 메서드
	public OrderItemDTO getOrderAlbumsInfo(Long productNum);
	
	//주문 테이블 등록
	public int enrollOrder(OrderDTO ord);
	
	//도서 주문아이템 테이블 등록
	public int enrollOrderBookItem(OrderItemDTO orderItem);
	
	//주문아이템 테이블 등록
	public int enrollOrderAlbumItem(OrderItemDTO orderItem);
	
	//주문 금액 차감
	public int deductPoint(MemberVO member);
	
	//도서 주문 재고 차감
	public int deductBookStock(BookVO book);
	
	//앨범 주문 재고 차감
	public int deductAlbumStock(AlbumVO album);
	
	//주문 취소
	public int orderCancel(String orderNum);
	
	//주문 상품 정보(주문 취소)
	public List<OrderItemDTO> getOrderItemInfo(String orderNum);
	
	//주문 정보(주문 취소)
	public OrderDTO getOrder(String orderNum);
	
	public List<OrderListDTO> bookOrderDetail(OrderDTO order);
	
	public List<OrderListDTO> albumOrderDetail(OrderDTO order);
}
