package com.book45.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book45.domain.BoardVO;
import com.book45.domain.Criteria;
import com.book45.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register" + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(int num) {
		log.info("get : " + num);
		mapper.updateReadCnt(num);
		return mapper.read(num);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modity : " + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(int num) {
		log.info("remove : " + num);
		
		return mapper.delete(num) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with Criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public void updateReadCnt(int num) {
		mapper.updateReadCnt(num);
	}
	
	@Override
	public BoardVO getBoardNumTitle(int num) {
		return mapper.getBoardNumTitle(num);
	}
}
