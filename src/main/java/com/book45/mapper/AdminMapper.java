package com.book45.mapper;

import java.util.List;

import com.book45.domain.Criteria;
import com.book45.domain.OrderDTO;

public interface AdminMapper {

	public int getOrderTotal(Criteria cri); // 완료
	
	//관리자 페이지-주문 상품 리스트
	public List<OrderDTO> getOrderList(Criteria cri);
}
