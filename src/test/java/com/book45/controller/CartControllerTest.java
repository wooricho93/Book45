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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class CartControllerTest {
	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	@Transactional
	public void testGetCartList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/cart/cartList/").param("id", "abc123")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testAddBookCart() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/cart/addBookCart").param("id", "pinksung").param("isbn", "9791140701490").param("amount", "3")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testAddAlbumCart() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/cart/addAlbumCart").param("id", "minho").param("productNum", "115440942").param("amount", "1")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testDeleteCart() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/cart/delete").param("cartNum", "3")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testModifyCount() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/cart/modify").param("cartNum", "6")).andReturn().getModelAndView().getModelMap());
	}
}
