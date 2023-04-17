package com.book45.domain;

import lombok.Data;

@Data
public class AlbumVO {

	private int num;
	private Long productNum;
	
	private String category;
	private String albumTitle;
	private int albumPrice;
	
	private String singer;
	private String ent;
	private String releaseDate;
	private String albumPictureUrl;
	private int stock;
	
	private double ratingAvg;
}
