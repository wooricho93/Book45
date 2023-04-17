package com.book45.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.book45.domain.CartDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartServiceTest {
	@Autowired
	private CartService cartService;
	
	@Test
	public void testAddBookCart() {
		CartDTO cart = new CartDTO();
		cart.setId("admin");
		cart.setIsbn(9788901260716L);
		cart.setAmount(1);
		
		int result = cartService.addBookCart(cart);
		log.info("result: " + result);
	}
	
	@Test
	public void testAddAlbumCart() {
		CartDTO cart = new CartDTO();
		cart.setId("admin");
		cart.setProductNum(115259173L);
		cart.setAmount(1);
		
		cartService.addAlbumCart(cart);
		log.info(cart);
	}
	
	@Test
	public void testModifyCount() {
		CartDTO cart = new CartDTO();
		cart.setCartNum(22);
		cart.setAmount(3);
		
		cartService.modifyCount(cart);
	}
	
	@Test
	public void testDeleteCart() {
		int result = cartService.deleteCart(23);
		log.info("result: " + result);
	}
	
	@Test
	public void testGetCartList() {
		cartService.getCartList("abc123").forEach(n -> log.info(n));
	}
}
