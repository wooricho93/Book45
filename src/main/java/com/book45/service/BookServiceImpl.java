package com.book45.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.book45.domain.BookVO;
import com.book45.domain.Criteria;
import com.book45.mapper.BookMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BookServiceImpl implements BookService {
	@Autowired
	private BookMapper mapper;
	
	@Transactional
	@Override
	public void register(BookVO book) {
		mapper.insertSelectKey(book);
	}

	@Override
	public BookVO get(Long isbn) {
		return mapper.read(isbn);
	}

	@Override
	public boolean modify(BookVO book) {
		return mapper.update(book) == 1;
	}

	@Override
	public boolean remove(Long isbn) {
		return mapper.delete(isbn) == 1;
	}

	@Override
	public List<BookVO> getList(Criteria cri) {

		log.info("get List with criteria : " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<BookVO> getListDesc(Criteria cri) {
		return mapper.getListDesc(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("페이징 댓글 갯수처리" );
		return mapper.getTotalCount(cri);
	}

	@Override
	public BookVO getIsbnName(Long isbn) {
		return mapper.getIsbnName(isbn);
	}

	@Override
	public List<BookVO> getCategory(String Category) {
		return mapper.getCategory(Category);
	}
}
