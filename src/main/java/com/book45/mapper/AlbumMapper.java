package com.book45.mapper;

import java.util.List;

import com.book45.domain.AlbumVO;
import com.book45.domain.Criteria;

public interface AlbumMapper {
	public List<AlbumVO> getListWithPaging(Criteria cri);
	
	public List<AlbumVO> getListDesc(Criteria cri);
	
	public void insert(AlbumVO album);
	
	public void insertSelectKey(AlbumVO album);
	
	public AlbumVO read(Long productNum);
	
	public int delete(Long productNum);
	
	public int update(AlbumVO album);
	
	public int getTotalCount(Criteria cri);
	
	public AlbumVO getProductNumName(Long productNum);
	
	public List<AlbumVO> getCategory(String Category);
}
