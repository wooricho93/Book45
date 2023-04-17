package com.book45.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {
	//주문 번호
	private String orderNum;
	private String id;
	private String name;
	private String zipCode;
	private String addressRoad;
	private String addressDetail;
	private String phone;
	
	private String orderState;
	//주문한 상품
	private List<OrderItemDTO> orders;
	//사용 포인트
	private int usePoint; 
	private int deliveryCost;
	private Date orderDate;
	
	//DB테이블에 존재하지 않는 데이터
	//price * amount
	private int totalPrice;
	
	//배송비, 사용 포인트까지 합한 최종 판매가
	private int finalTotalPrice;
	
	public void getOrderPriceInfo() {
		
		/* 상품 비용 */
		for(OrderItemDTO order : orders) {
			totalPrice += order.getTotalPrice();
		}
		/* 배송비 */
		if(totalPrice >= 20000) {
			deliveryCost = 0;
		} else {
			deliveryCost = 3000;
		}
		/* 최종 비용(상품 비용 + 배송비 - 사용 포인트) */
		this.finalTotalPrice = totalPrice + deliveryCost - usePoint;
	}
}
