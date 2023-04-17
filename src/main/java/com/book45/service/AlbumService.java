package com.book45.service;

import java.util.List;

import com.book45.domain.AlbumVO;
import com.book45.domain.Criteria;

public interface AlbumService {

	public void register(AlbumVO album);
	
	public AlbumVO get(Long productNum);
	
	public boolean modify(AlbumVO album);
	
	public boolean remove(Long productNum);
	
	public List<AlbumVO> getList(Criteria cri);
	
	public List<AlbumVO> getListDesc(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public AlbumVO getProductNumName(Long productNum);
	
	public List<AlbumVO> getCategory(String Category);
}
