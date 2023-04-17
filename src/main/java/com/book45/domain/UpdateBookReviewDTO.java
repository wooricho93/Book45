package com.book45.domain;

import lombok.Data;

@Data
public class UpdateBookReviewDTO {
	private Long isbn;
	private double ratingAvg;
}
