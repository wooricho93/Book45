package com.book45.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.book45.domain.Criteria;
import com.book45.domain.QnaReplyDTO;

public interface QnaReplyMapper {
	//등록
	public int enrollReply(QnaReplyDTO dto);

	//페이징
	public List<QnaReplyDTO> getReplyList(Criteria cri);

	//답변 총 갯수
	public int getReplyTotal(int qnum);	

	//수정
	public int updateReply(QnaReplyDTO dto);	

	//힌개 정보 수정
	public QnaReplyDTO getUpdateReply(int renum);

	//삭제
	public int deleteReply(int renum);
}
