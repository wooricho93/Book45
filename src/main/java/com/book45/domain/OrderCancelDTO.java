package com.book45.domain;

import lombok.Data;

@Data
public class OrderCancelDTO {
	private String id;
	private String orderNum;
	private String keyword;
	private int amount;
	private int pageNum;
}
