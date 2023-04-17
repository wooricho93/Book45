package com.book45.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class MemberControllerTest {
	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testGetMember() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/member/myPage").param("id", "admin")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testUpdateMyInfo() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/member/update").param("id", "admin").param("pass", "1234").param("nickname", "관리자").param("phone", "010-1234-5678").param("email", "admin@book45.com").param("zipCode", "06634").param("addressRoad", "서울특별시 서초구 서초중앙로 130").param("addressDetail", "일이타워 12층")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testDeleteMember() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/member/delete").param("id", "abc123")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testGetMemberList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/admin/memberList")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testUpdateByAdmin() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/admin/update").param("id", "admin1").param("name", "관리자").param("pass", "1111").param("nickname", "관리자").param("phone", "010-1234-5678").param("email", "admin@book45.com").param("zipCode", "06634").param("addressRoad", "서울특별시 서초구 서초중앙로 130").param("addressDetail", "일이타워 12층").param("lev", "A").param("point", "1000000")).andReturn().getModelAndView().getModelMap());
	}
}
