package com.book45.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.book45.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTest {
	@Autowired
	private MemberMapper memberMapper;
	
	@Test
	public void testMemberLogin() throws Exception {
		MemberVO member = new MemberVO();
		
		member.setId("admin");
		member.setPass("1111");
		
		memberMapper.memberLogin(member);
		log.info(memberMapper.memberLogin(member));
	}
	
	@Test
	public void testMemberJoin() {
		MemberVO member = new MemberVO();
		member.setId("abc123");
		member.setPass("1234");
		member.setName("가나다");
		member.setNickname("한글");
		member.setPhone("010-1111-2222");
		member.setEmail("abc123@naver.com");
		member.setZipCode("16455");
		member.setAddressRoad("경기도 수원시 팔달구 덕영대로 899");
		member.setAddressDetail("3층");
		
		memberMapper.memberJoin(member);
		
		log.info(member);
	}
	
	@Test
	public void testIdCheck() {
		String id1 = "abc123";
		String id2 = "abc123";
		memberMapper.idCheck(id1);
		memberMapper.idCheck(id2);
	}
	
	@Test
	public void testNicknameCheck() {
		String n1 = "바보";
		String n2 = "바보";
		memberMapper.nicknameCheck(n1);
		memberMapper.nicknameCheck(n2);
	}
	
	@Test
	public void testGetMember() {
		MemberVO member = memberMapper.getMember("admin");
		
		log.info(member);
	}
	
	@Test
	public void testUpdateMypage() {
		MemberVO member = new MemberVO();
		member.setId("abc123");
		member.setPass("1111");
		member.setNickname("겨울");
		member.setPhone("010-1111-2222");
		member.setEmail("abc123@naver.com");
		member.setZipCode("16455");
		member.setAddressRoad("경기도 수원시 팔달구 덕영대로 899");
		member.setAddressDetail("3층");
		
		memberMapper.updateMypage(member);
		
		log.info(member);
	}
	
	@Test
	public void testDeleteMember() {
		int result = memberMapper.deleteMember("admin1");
		log.info(result);
	}
	
	@Test
	public void testGetMemberList() {
		List<MemberVO> list = memberMapper.getMemberList();
		list.forEach(n -> log.info(n));
	}
	
	@Test
	public void testUpdateByAdmin() {
		MemberVO member = new MemberVO();
		member.setId("minho");
		member.setPass("1234");
		member.setName("윤민호");
		member.setNickname("못생김");
		member.setPhone("010-1234-1234");
		member.setEmail("minho@nate.com");
		member.setZipCode("18123");
		member.setAddressRoad("경기도 수원시 팔달구 덕영대로 899");
		member.setAddressDetail("3층");
		member.setLev("B");
		member.setPoint(1);
		
		memberMapper.updateByAdmin(member);
		
		log.info(member);
	}
	
	@Test
	public void testGetOrderList() {
		
	}
}
