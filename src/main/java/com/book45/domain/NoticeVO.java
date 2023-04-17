package com.book45.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private Long num;
	private String title;
	private String content;
	private Date writeDate;
	private Date updateDate;
	private String id;
	private Long readCount;
}
