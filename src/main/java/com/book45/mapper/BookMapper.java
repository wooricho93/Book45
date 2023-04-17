package com.book45.mapper;

import java.util.List;

import com.book45.domain.BookVO;
import com.book45.domain.Criteria;

public interface BookMapper {
	public void insert(BookVO book);
	
	public void insertSelectKey(BookVO book);
	
	public BookVO read(Long isbn);
	
	public int delete(Long isbn);
	
	public int update(BookVO book);
	
	public List<BookVO> getListWithPaging(Criteria cri);
	
	public List<BookVO> getListDesc(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public BookVO getIsbnName(Long isbn);
	
	public List<BookVO> getCategory(String Category);
}
