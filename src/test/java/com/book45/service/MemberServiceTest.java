package com.book45.service;

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
public class MemberServiceTest {
	@Autowired
	private MemberService memberService;
	
	@Test
	public void testMemberLogin() throws Exception {
		MemberVO member = new MemberVO();
		
		member.setId("admin");
		member.setPass("1111");
		
		memberService.memberLogin(member);
		log.info(memberService.memberLogin(member));
	}
	
	@Test
	public void testMemberJoin() throws Exception {
		MemberVO member = new MemberVO();
		member.setId("admin1");
		member.setPass("1234");
		member.setName("관리자");
		member.setNickname("운영자");
		member.setPhone("010-1111-2222");
		member.setEmail("admin1@book45.com");
		member.setZipCode("16455");
		member.setAddressRoad("경기도 수원시 팔달구 덕영대로 899");
		member.setAddressDetail("3층");
		
		memberService.memberJoin(member);
		log.info(member);
	}
	
	@Test
	public void testIdCheck() throws Exception {
		String id1 = "abc123";
		String id2 = "abc123";
		
		memberService.idCheck(id1);
		memberService.idCheck(id2);
	}
	
	@Test
	public void testNicknameCheck() {
		String n1 = "미미	";
		String n2 = "미미";
		
		memberService.nicknameCheck(n1);
		memberService.nicknameCheck(n2);
	}
	
	@Test
	public void testGetMember() {
		MemberVO member = memberService.getMember("admin");
		log.info(member);
	}
	
	@Test
	public void testGetMemberList() {
		List<MemberVO> list = memberService.getMemberList();
		list.forEach(n -> log.info(n));
	}
}
