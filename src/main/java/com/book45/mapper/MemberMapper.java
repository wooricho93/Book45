package com.book45.mapper;

import java.util.List;

import com.book45.domain.Criteria;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;

public interface MemberMapper {
	public MemberVO memberLogin(MemberVO member); // 완료
	
	public void memberJoin(MemberVO member); // 완료
	
	public int idCheck(String id); // 완료
	
	public int nicknameCheck(String nickname);
	
	public MemberVO getMember(String id); // 완료
	
	public int updateMypage(MemberVO member); // 완료 
	
	public int deleteMember(String id); // 완료
	
	public MemberVO checkPass(String id, String pass);
	
	public List<MemberVO> getMemberList(); // 완료 -> 페이징 처리 필요해보임
	
	public int updateByAdmin(MemberVO member); // 완료
	
	public List<OrderDTO> getOrderList(String id); // 완료
	
	public int getOrderTotal(Criteria cri); // 완료
	
	//주문 취소
	public int orderCancel(String orderNum);
      
	//주문 상품 정보(주문 취소)
	public List<OrderItemDTO> getOrderItemInfo(String orderNum);
   
	//주문 정보(주문 취소)
	public OrderDTO getOrder(String orderNum);
}
