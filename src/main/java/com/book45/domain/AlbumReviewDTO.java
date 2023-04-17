package com.book45.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class AlbumReviewDTO {
	private int num;
	private Long productNum;
	
	private String id;
	private String nickname;
	private String content;
	
	private double rating;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd",timezone="Asia/seoul")
	private Date writeDate;
}
