package com.book45.service;

import java.util.List;

import com.book45.domain.Criteria;
import com.book45.domain.OrderDTO;

public interface AdminService {

	public int getOrderTotal(Criteria cri);
	
	public List<OrderDTO> getOrderList(Criteria cri);
}
