package com.book45.mapper;

import java.util.List;

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
public class CartMapperTest {
	@Autowired
	private CartMapper cartMapper;
	
	@Test
	public void testAddBookCart() throws Exception {
		CartDTO cart = new CartDTO();
		cart.setId("abc123");
		cart.setIsbn(9791140701490L);
		cart.setAmount(1);
		
		cartMapper.addBookCart(cart);
		log.info("장바구니 번호: " + cart.getCartNum());
	}
	
	@Test
	public void testAddAlbumCart() throws Exception {
		CartDTO cart = new CartDTO();
		cart.setId("abc123");
		cart.setProductNum(115399619L);
		cart.setAmount(2);
		
		cartMapper.addAlbumCart(cart);
		log.info(cart);
	}
	
	@Test
	public void testModifyCount() {
		CartDTO cart = new CartDTO();
		cart.setCartNum(22);
		cart.setAmount(2);
		
		cartMapper.modifyCount(cart);
		
		log.info(cart);
	}
	
	@Test
	public void testDeleteCart() {
		int result = cartMapper.deleteCart(21);
		
		log.info("result: " + result);
	}
	
	@Test
	public void testDeleteAll() {
		cartMapper.deleteAll("admin");
	}
	
	@Test
	public void testGetCartList() {
		List<CartDTO> list = cartMapper.getCartList("abc123");
		for (CartDTO cart : list) {
			log.info(cart);
			cart.initTotal();
			log.info("init cart: " + cart);
		}
	}
	
	@Test
	public void testCheckBookCart() {
		CartDTO cart = new CartDTO();
		cart.setId("abc123");
		cart.setIsbn(9788959897094L);
		
		CartDTO resultCart = cartMapper.checkBookCart(cart);
		log.info("result: " + resultCart);
	}
	
	@Test
	public void testCheckAlbumCart() {
		CartDTO cart = new CartDTO();
		cart.setId("abc123");
		cart.setProductNum(115399619L);
		
		CartDTO resultCart = cartMapper.checkAlbumCart(cart);
		log.info("result: " + resultCart);
	}
	
	@Test
	public void deleteOrderBookCart() {
		CartDTO cart = new CartDTO();
		cart.setId("admin");
		cart.setIsbn(9791161571379L);
		
		cartMapper.deleteBookOrderCart(cart);
	}
}
