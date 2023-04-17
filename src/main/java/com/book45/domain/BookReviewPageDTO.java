package com.book45.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class BookReviewPageDTO {
	private List<BookReviewDTO> list;
	private PageDTO pageInfo;
}
