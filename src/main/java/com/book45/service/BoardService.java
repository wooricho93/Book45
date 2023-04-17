package com.book45.service;

import java.util.List;

import com.book45.domain.BoardVO;
import com.book45.domain.Criteria;


public interface BoardService {
public void register(BoardVO board);
	
	public BoardVO get(int num);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(int num);
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public void updateReadCnt(int num);
	
	public BoardVO getBoardNumTitle(int num);
}
