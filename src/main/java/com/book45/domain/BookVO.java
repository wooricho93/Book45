package com.book45.domain;

import lombok.Data;

@Data
public class BookVO {
	private int num;
	private Long isbn;
	private String category;
	private String title;
	private int price;
	private String summary;
	private String author;
	private String pub;
	private double ratingAvg;
	private String pictureUrl;
	private int stock;
}
