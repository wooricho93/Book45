package com.book45.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.book45.domain.Criteria;
import com.book45.domain.QnaVO;
import com.book45.mapper.QnaMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QnaServiceImpl implements QnaService {
	@Autowired
	public QnaMapper mapper;

	@Transactional
	@Override
	public void register(QnaVO qVo) {
		mapper.updateReplyCnt(qVo.getQnum(), 1);
		mapper.insertSelectKey(qVo);
	}

	@Override
	public QnaVO get(int qnum) {
		return mapper.read(qnum);
	} 

	@Override
	public boolean modify(QnaVO qVo) {
		return mapper.update(qVo) == 1;
	}

	@Override
	public boolean remove(int qnum) {
		log.info("문의글 삭제 --> "+qnum	+"번");
		return mapper.delete(qnum);
	}

	@Override
	public List<QnaVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public QnaVO getQnaTitle(int qnum) {
		return mapper.getQnaTitle(qnum);
	}
}
