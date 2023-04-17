package com.book45.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class AlbumReviewPageDTO {
	private List<AlbumReviewDTO> list;
	private PageDTO pageInfo;
}
