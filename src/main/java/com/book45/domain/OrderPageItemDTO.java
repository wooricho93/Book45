package com.book45.domain;

import lombok.Data;

@Data
public class OrderPageItemDTO {
	// 뷰에서 전달받을 값: isbn, productNum, amount
	private Long isbn;
	private Long productNum;
	private int amount; 
	
	// DB에서 꺼내올 값
	private String title;
	private int price;
	private String pictureUrl;

	private String albumTitle;
	private int albumPrice;
	private String albumPictureUrl;
	
	// 만들어 낼 값
	private int totalPrice;
	
	public void initTotal() {
		this.totalPrice = this.price * this.amount + this.albumPrice * this.amount;
	}
}
