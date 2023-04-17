package com.book45.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
//import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Select;

import com.book45.domain.BoardVO;
import com.book45.domain.Criteria;

public interface BoardMapper {
public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(int num);
	
	public int delete(int num);
	
	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);

	public void updateReplyCnt(@Param("num") int num, @Param("amount") int amount);
	
	public void updateReadCnt(int num);
	
	public BoardVO getBoardNumTitle(int num);
}
