package com.book45.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.book45.domain.Criteria;
import com.book45.domain.QnaVO;

public interface QnaMapper {
	public List<QnaVO> getList();
	
	public void insert(QnaVO qVo);
	
	public void insertSelectKey(QnaVO qVo);
	
	public QnaVO read(int qnum);
	
	public boolean delete(int qnum);
	
	public int update(QnaVO qVo);
	
	public List<QnaVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	//추가 답변 상태확인을 위한 replyCnt
	public void updateReplyCnt(@Param("qnum")int qnum, @Param("amount")int amount);
	//updateReplyCnt( )는 해당 게시물의 번호인 bno와 증가나 감소를 의미하는 amount 변수에 파라미터를 받을 수 있도록 처리한다. 댓글이 등록하면 1이 증가하고, 삭제 되면 1이 감소하기 때문
	
	//Qna title 추가(답글 수정 추가)
	public QnaVO getQnaTitle(int qnum);
}


