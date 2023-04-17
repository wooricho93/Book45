package com.book45.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.book45.domain.Criteria;
import com.book45.domain.NoticeVO;

public interface NoticeMapper {

	public List<NoticeVO> getList();
	
	public void insert(NoticeVO nVo);
	
	public void insertSelectKey(NoticeVO nVo);
	
	public NoticeVO read(Long num);
	
	public boolean delete(Long num);
	
	public int update(NoticeVO nVo);
	
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReadCnt(Long num);
	}
