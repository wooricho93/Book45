package com.book45.service;

import java.util.List;

import com.book45.domain.Criteria;
import com.book45.domain.KakaoDTO;
import com.book45.domain.MemberOrderCancelDTO;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderDTO;

public interface MemberService {
	public MemberVO memberLogin(MemberVO member) throws Exception;
	
	public void memberJoin(MemberVO member) throws Exception;
	
	public int idCheck(String id) throws Exception;
	
	public int nicknameCheck(String nickname);
	
	public MemberVO getMember(String id);
	
	public int updateMypage(MemberVO member);
	
	public int deleteMember(String id);
	
	public List<MemberVO> getMemberList();
	
	public int updateByAdmin(MemberVO member);
	
	public List<OrderDTO> getOrderList(String id);
	
	public int getOrderTotal(Criteria cri);
	
	public String getAccessToken(String authorizeCode);
	
	public KakaoDTO getUserInfo(String accessToken);
	
	public void kakaoLogout(String accessToken);
	
	public void orderCancel(MemberOrderCancelDTO orderCancel);
}
