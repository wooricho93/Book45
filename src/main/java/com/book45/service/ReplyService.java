package com.book45.service;

import com.book45.domain.Criteria;
import com.book45.domain.ReplyPageDTO;
import com.book45.domain.ReplyDTO;

public interface ReplyService {
	//댓글 등록
	public int enrollReply(ReplyDTO dto);
	
	//댓글 페이징
	public ReplyPageDTO replyList(Criteria cri);
	
	//댓글 수정
	public int updateReply(ReplyDTO dto);
	
	//댓글 한개 선택 수정
	public ReplyDTO getUpdateReply(int replyNum);
	
	//댓글 삭제
	public int deleteReply(ReplyDTO dto);
}
