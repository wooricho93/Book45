package com.book45.mapper;

import java.util.List;

import com.book45.domain.CartDTO;

public interface CartMapper {
	public int addBookCart(CartDTO cart) throws Exception; // 완료
	
	public int addAlbumCart(CartDTO cart) throws Exception; // 완료
	
	public int deleteCart(int cartNum); // 완료
	
	public int selectDelete(CartDTO cart);
	
	public int deleteAll(String id); // 완료
	
	public int modifyCount(CartDTO cart); // 완료
	
	public List<CartDTO> getCartList(String id); // 완료
	
	public CartDTO checkBookCart(CartDTO cart); // 완료 
	
	public CartDTO checkAlbumCart(CartDTO cart); // 완료
	
	/* 도서 카트 제거(주문 후) */
	public int deleteBookOrderCart(CartDTO cart);
	   
	/* 앨범 카트 제거(주문 후) */
	public int deleteAlbumOrderCart(CartDTO cart);
}
