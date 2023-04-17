package com.book45.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyDTO {
	private int replyNum;
	   private int boardNum;
	   private String memberId;
	   private String nickname;
	   private String content;
	   
	   @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	   private Date replyDate;
	   
	   private boolean secret;
}
