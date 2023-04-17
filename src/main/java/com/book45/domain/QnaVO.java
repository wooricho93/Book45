package com.book45.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QnaVO {
	private int qnum;
	private String id;
	private String title;
	private String content;
	private Date writeDate;
	private Date updateDate;
	private String secret;
	private boolean replyCnt;	//리플수 : 1 로 제한 == 답변상태 : 0(= 처리중) or 1(= 답변완료)
}
