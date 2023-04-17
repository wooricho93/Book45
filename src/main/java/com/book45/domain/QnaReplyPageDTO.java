package com.book45.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class QnaReplyPageDTO {
	private int replyCnt;
	private List<QnaReplyDTO> list;
	private PageDTO PageInfo;
}
