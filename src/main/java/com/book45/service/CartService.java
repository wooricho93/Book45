package com.book45.service;

import java.util.List;

import com.book45.domain.CartDTO;

public interface CartService {
	public int addBookCart(CartDTO cart);
	
	public int addAlbumCart(CartDTO cart);
	
	public int deleteCart(int cartNum);
	
	public int selectDelete(CartDTO cart);
	
	public int deleteAll(String id);
	
	public int modifyCount(CartDTO cart);
	
	public List<CartDTO> getCartList(String id);
	
	public CartDTO checkBookCart(CartDTO cart);
	
	public CartDTO checkAlbumCart(CartDTO cart);
}
