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

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class AlbumControllerTests {

	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/album/list"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testRegister() throws Exception {
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/album/register")
				.param("productNum","345")
				.param("albumTitle", "테스트 새글 제목dd")
				.param("category", "테스트 새글 카테고리dd")
				.param("albumPrice", "3333")
				.param("singer", "나야나")
				.param("ent","이젠")
				.param("releaseDate","20202020")
				.param("albumPictureUrl","img")
				.param("stock","10"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testGet() throws Exception {
		
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/album/get")
				.param("productNum", "115258870"))
				.andReturn().getModelAndView().getModelMap()
				);
	}
	
	@Test
	public void testModify() throws Exception {
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/album/modify")
				.param("num","205")
				.param("productNum", "212121")
				.param("category","제발")
				.param("albumTitle","제발 제발2")
				.param("albumPrice","00")
				.param("singer", "컨트롤러 수정테스트2")
				.param("ent","00")
				.param("releaseDate", "00")
				.param("albumPictureUrl", "")
				.param("stock", "1")
				)
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
				
	}
	
	@Test
	public void testRemove() throws Exception {
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/album/remove")
				.param("num", "205"))
				.andReturn().getModelAndView().getViewName();
			
		log.info(resultPage);
	}
	
	@Test
	public void testListPaging() throws Exception {
		
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/album/list")
				.param("pageNum","2")
				.param("amount", "50"))
				.andReturn().getModelAndView().getModelMap());
	}
}
