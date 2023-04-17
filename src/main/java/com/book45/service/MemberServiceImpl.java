package com.book45.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.book45.domain.AlbumVO;
import com.book45.domain.BookVO;
import com.book45.domain.Criteria;
import com.book45.domain.KakaoDTO;
import com.book45.domain.MemberOrderCancelDTO;
import com.book45.domain.MemberVO;
import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;
import com.book45.mapper.AlbumMapper;
import com.book45.mapper.BookMapper;
import com.book45.mapper.KakaoMapper;
import com.book45.mapper.MemberMapper;
import com.book45.mapper.OrderMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private KakaoMapper kakaoMapper;
	
	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private AlbumMapper albumMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public void memberJoin(MemberVO member) {
		memberMapper.memberJoin(member);
	}

	@Override
	public int idCheck(String id) throws Exception {
		return memberMapper.idCheck(id);
	}
	
	@Override
	public int nicknameCheck(String nickname) {
		return memberMapper.nicknameCheck(nickname);
	}
	
	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception {
		return memberMapper.memberLogin(member);
	}

	@Override
	public MemberVO getMember(String id) {
		return memberMapper.getMember(id);
	}

	@Override
	public int updateMypage(MemberVO member) {
		return memberMapper.updateMypage(member);
	}

	@Override
	public int deleteMember(String id) {
		return memberMapper.deleteMember(id);
	}

	@Override
	public List<MemberVO> getMemberList() {
		return memberMapper.getMemberList();
	}

	@Override
	public int updateByAdmin(MemberVO member) {
		return memberMapper.updateByAdmin(member);
	}

	@Override
	public List<OrderDTO> getOrderList(String id) {
		return memberMapper.getOrderList(id);
	}

	@Override
	public int getOrderTotal(Criteria cri) {
		return memberMapper.getOrderTotal(cri);
	}

	@Override
	public String getAccessToken(String authorizeCode) {
		String accessToken = "";
		String refreshToken = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=f7e37b028d7961466d599e8f8452424c");
			sb.append("&redirect_uri=http://localhost:8081/member/kakaoLogin");
			sb.append("&code=" + authorizeCode);
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode: " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			
			System.out.println("response body: " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();
			
			System.out.println("accessToken: " + accessToken);
			System.out.println("refreshToken: " + refreshToken);
			
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return accessToken;
	}

	@Override
	public KakaoDTO getUserInfo(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode: " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			
			System.out.println("response body: " + responseCode);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
			
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		KakaoDTO result = kakaoMapper.findKakao(userInfo);
		log.info("result: " + result);
		
		if (result == null) {
			kakaoMapper.kakaoInsert(userInfo);
			return kakaoMapper.findKakao(userInfo);
		} else {
			return result;
		}
	}
	
	public void kakaoLogout(String accessToken) {
	    String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        
	        System.out.println(result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	@Transactional
	public void orderCancel(MemberOrderCancelDTO orderCancel) {
		 /* 주문, 주문상품 객체 */
	      /* 회원 */
	      MemberVO member = memberMapper.getMember(orderCancel.getId());
	      /* 주문 상품 */
	      List<OrderItemDTO> ords = memberMapper.getOrderItemInfo(orderCancel.getOrderNum());
	      
	      for(OrderItemDTO ord : ords) {
	         ord.initTotal();
	      }
	      /* 주문 */
	      OrderDTO orders = memberMapper.getOrder(orderCancel.getOrderNum());
	      orders.setOrders(ords);
	      orders.getOrderPriceInfo();

	/* 주문상품 취소 DB */
	      memberMapper.orderCancel(orderCancel.getOrderNum());
	      
	/* 포인트, 재고 반환 */
	      /* 포인트 */
	      int calPoint = member.getPoint();
	      calPoint = calPoint + orders.getUsePoint();
	      member.setPoint(calPoint);
	      
         /* DB적용 */
         orderMapper.deductPoint(member);
         /* 재고 */
         for(OrderItemDTO ord : orders.getOrders()) {
            
            if(ord.getProductNum() == null) {
               
               BookVO book = bookMapper.read(ord.getIsbn());
               book.setStock(book.getStock() + ord.getAmount());
               orderMapper.deductBookStock(book);
            
            }else if(ord.getIsbn() == null) {
               
               AlbumVO album = albumMapper.read(ord.getProductNum());
               album.setStock(album.getStock() + ord.getAmount());
               orderMapper.deductAlbumStock(album);
               
            }else if(ord.getIsbn() != null && ord.getProductNum() != null) {
               
               BookVO book = bookMapper.read(ord.getIsbn());
               book.setStock(book.getStock() + ord.getAmount());
               orderMapper.deductBookStock(book);
               
               AlbumVO album = albumMapper.read(ord.getProductNum());
               album.setStock(album.getStock() + ord.getAmount());
               orderMapper.deductAlbumStock(album);
            }
        } 
	}
}
