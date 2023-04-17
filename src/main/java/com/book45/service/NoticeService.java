package com.book45.service;

import java.util.List;

import com.book45.domain.Criteria;
import com.book45.domain.NoticeVO;

public interface NoticeService {
	public void register(NoticeVO nVo);
	
	public NoticeVO get(Long num);
	
	public boolean modify(NoticeVO nVo);
	
	public boolean remove(Long num);
	
	public List<NoticeVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public void updateReadCnt(Long num);
}

