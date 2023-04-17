package com.book45.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book45.domain.Criteria;
import com.book45.domain.NoticeVO;
import com.book45.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	public NoticeMapper mapper;

	@Override
	public void register(NoticeVO nVo) {
		mapper.insertSelectKey(nVo);
	}

	@Override
	public NoticeVO get(Long num) {
		mapper.updateReadCnt(num);
		return mapper.read(num);
	} 

	@Override
	public boolean modify(NoticeVO nVo) {
		return mapper.update(nVo) == 1;
	}

	@Override
	public boolean remove(Long num) {
		return mapper.delete(num);
	}

	@Override
	public List<NoticeVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override	//조회수
	public void updateReadCnt(Long num) {
		mapper.updateReadCnt(num);
	}
}
