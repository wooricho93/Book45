package com.book45.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.book45.domain.OrderDTO;
import com.book45.domain.OrderItemDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderMapperTest {
	@Autowired
	private OrderMapper orderMapper;
	
	@Test
	public void getOrderBooksInfoTest() {
		OrderItemDTO orderInfo = orderMapper.getOrderBooksInfo(9791161571379L);
		log.info("주문 정보: " + orderInfo);
	}
	
	@Test
	public void enrollOrderTest() {
		OrderDTO order = new OrderDTO();
		List<OrderItemDTO> list = new ArrayList();
		
		/* OrderItemDTO 객체를 통해 set으로 값을 넣어주고, 그 값을 OrderItemDTO 타입인 List list 객체에서 꺼내 OrderDTO로 전달한다. */
		OrderItemDTO orderItem = new OrderItemDTO();
		
		orderItem.setIsbn(9791161571379L);
		orderItem.setAmount(2);
		orderItem.setPrice(12600);
		orderItem.initTotal();
		
		list.add(orderItem);
		
		order.setOrders(list);
		
		order.setOrderNum("admin_20230301");
		order.setName("관리자");
		order.setId("admin");
		order.setPhone("010-1111-1111");
		order.setZipCode("11111");
		order.setAddressRoad("몰라");
		order.setAddressDetail("모른다고");
		order.setOrderState("배송준비");
		/* orderItem에서 넘겨받은 값을 토대로 가격 결정 */
		order.getOrderPriceInfo();
		order.setUsePoint(0);
		
		/* order에 담긴 값을 enrollOrder를 통해 데이터베이스로 전송 */
		orderMapper.enrollOrder(order);
	}
	
	@Test
	/* OrderItem 테이블에 값 전송 */
	public void enrollOrderBookItemTest() {
		OrderItemDTO orderItem = new OrderItemDTO();
		
		orderItem.setOrderNum("admin_20230228");
		orderItem.setIsbn(9791161571379L);
		orderItem.setAmount(2);
		orderItem.setPrice(12600);
		orderItem.initTotal();
		
		orderMapper.enrollOrderBookItem(orderItem);
	}
}
