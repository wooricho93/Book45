package com.book45.service;

import java.util.List;

import com.book45.domain.OrderCancelDTO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;
import com.book45.domain.OrderListDTO;
import com.book45.domain.OrderPageItemDTO;

public interface OrderService {
	/* 주문 정보 */
	public List<OrderPageItemDTO> getBooksInfo(List<OrderPageItemDTO> orders);
	
	/* 앨범 주문 정보 */
	public List<OrderPageItemDTO> getAlbumsInfo(List<OrderPageItemDTO> orders);
	
	/* 주문 */
	public void orderBook(OrderDTO ord);
	
	public void orderAlbum(OrderDTO ord);
	
	public void orderItem(OrderDTO ord);
	
	/* 주문 테이블 등록 */
	public int enrollOrder(OrderDTO ord);
	
	/* 도서 주문아이템 테이블 등록 */
	public int enrollOrderBookItem(OrderItemDTO orderItem);
	
	/* 주문아이템 테이블 등록 */
	public int enrollOrderAlbumItem(OrderItemDTO orderItem);
	
	/* 주문 취소 */
	public void orderCancel(OrderCancelDTO orderCancel);
	
	/* 도서 주문내역 상세보기 */
	public List<OrderListDTO> bookOrderDetail(OrderDTO order);
   
   /* 앨범 주문내역 상세보기 */
	public List<OrderListDTO> albumOrderDetail(OrderDTO order);
}
