package com.book45.domain;

import lombok.Data;

@Data
public class CartDTO {
	private int cartNum;
	private String id;
	private Long isbn;
	private Long productNum;
	private int amount;
	
	/* Book 테이블에서 받아올 값 */
	private String bookTitle;
	private int bookPrice;
	private String bookPictureUrl;
	
	/* Album 테이블에서 받아올 값 */
	private String albumTitle;
	private int albumPrice;
	private String albumPictureUrl;
	
	private int totalPrice;
	
	public void initTotal() {
		this.totalPrice = (this.bookPrice * this.amount) + (this.albumPrice * this.amount);
	}
}
