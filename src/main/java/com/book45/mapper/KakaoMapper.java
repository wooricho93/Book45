package com.book45.mapper;

import java.util.HashMap;

import com.book45.domain.KakaoDTO;

public interface KakaoMapper {
	public void kakaoInsert(HashMap<String, Object> userInfo);
	
	public KakaoDTO findKakao(HashMap<String, Object> userInfo);
}
