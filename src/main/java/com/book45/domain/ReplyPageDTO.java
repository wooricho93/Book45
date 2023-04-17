package com.book45.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
public class ReplyPageDTO {
	private List<ReplyDTO> list;
	private PageDTO pageInfo;
	private int replyCnt;
}
