package com.book45.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.book45.domain.Criteria;
import com.book45.domain.PageDTO;
import com.book45.domain.ReplyPageDTO;
import com.book45.domain.ReplyDTO;
import com.book45.mapper.BoardMapper;
import com.book45.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private ReplyMapper mapper;
	
	private BoardMapper boardMapper;
	
	/* 댓글등록 */
	@Transactional
	@Override
	public int enrollReply(ReplyDTO dto) {
		boardMapper.updateReplyCnt(dto.getBoardNum(), 1);
		
		return mapper.enrollReply(dto);
	}
	
	@Override
	public ReplyPageDTO replyList(Criteria cri) {
		ReplyPageDTO dto = new ReplyPageDTO();
		
		dto.setList(mapper.getReplyList(cri));
		dto.setPageInfo(new PageDTO(cri, mapper.getReplyTotal(cri.getBoardNum())));
		
		return dto;
	}
	
	@Override
	public int updateReply(ReplyDTO dto) {
		int result = mapper.updateReply(dto);
		
		return result;
	}
	
	@Override
	public ReplyDTO getUpdateReply(int replyNum) {
		return mapper.getUpdateReply(replyNum);
	}
	
	@Transactional
	@Override
	public int deleteReply(ReplyDTO dto) {
		int result = mapper.deleteReply(dto.getReplyNum());
		
		boardMapper.updateReplyCnt(dto.getBoardNum(), -1);
		
		return result;
	}
}
