package com.book45.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int num;
	private String memberId;
	private String pass;
	private String title;
	private String content;
	private Date writeDate;
	private Date updateDate;
	private int readCount;
	private int replyCnt;
	private boolean blind;
}
