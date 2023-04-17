package com.book45.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book45.domain.AlbumVO;
import com.book45.domain.Criteria;
import com.book45.mapper.AlbumMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AlbumServiceImpl implements AlbumService {
	@Autowired
	private AlbumMapper mapper;

	@Override
	public void register(AlbumVO album) {
		log.info("register.. " + album);
		mapper.insertSelectKey(album);
	}

	@Override
	public AlbumVO get(Long productNum) {
		log.info("get...." + productNum);
		return mapper.read(productNum);
	}

	@Override
	public boolean modify(AlbumVO album) {
		log.info("modify...." + album);
		return mapper.update(album) == 1;
	}

	@Override
	public boolean remove(Long productNum) {
		log.info("remove..." + productNum);
		return mapper.delete(productNum) == 1;
	}
	
	@Override
	public List<AlbumVO> getList(Criteria cri) {
		log.info("get List with criteria : " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<AlbumVO> getListDesc(Criteria cri) {
		return mapper.getListDesc(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public AlbumVO getProductNumName(Long productNum) {
		return mapper.getProductNumName(productNum);
	}

	@Override
	public List<AlbumVO> getCategory(String category) {
		return mapper.getCategory(category);
	}
}
