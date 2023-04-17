package com.book45.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book45.domain.CartDTO;
import com.book45.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	private CartMapper cartMapper;
	
	@Override
	public int addBookCart(CartDTO cart) {
		/* 장바구니 데이터 체크 */
		CartDTO checkCart = cartMapper.checkBookCart(cart);
		
		if (checkCart != null) {
			return 2;
		}
		
		/* 장바구니 등록 시 1 / 에러 시 0 반환 */
		try {
			return cartMapper.addBookCart(cart);
		} catch (Exception e) {
			return 0;
		}
		
	}

	@Override
	public int addAlbumCart(CartDTO cart) {
		CartDTO checkCart = cartMapper.checkAlbumCart(cart);
		
		if (checkCart != null) {
			return 2;
		}
		
		try {
			return cartMapper.addAlbumCart(cart);
		} catch (Exception e) {
			return 0;
		}
		
	}

	@Override
	public int deleteCart(int cartNum) {
		return cartMapper.deleteCart(cartNum);
	}

	@Override
	public int selectDelete(CartDTO cart) {
		return cartMapper.selectDelete(cart);
	}
	
	@Override
	public int deleteAll(String id) {
		return cartMapper.deleteAll(id);
	}

	@Override
	public int modifyCount(CartDTO cart) {
		return cartMapper.modifyCount(cart);
	}

	@Override
	public List<CartDTO> getCartList(String id) {
		List<CartDTO> list = cartMapper.getCartList(id);
		
		for (CartDTO cart : list) {
			cart.initTotal();
		}
		return list;
	}
	
	@Override
	public CartDTO checkBookCart(CartDTO cart) {
		return cartMapper.checkBookCart(cart);
	}

	@Override
	public CartDTO checkAlbumCart(CartDTO cart) {
		return cartMapper.checkAlbumCart(cart);
	}
}
