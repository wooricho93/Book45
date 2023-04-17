package com.book45.service;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.book45.domain.AlbumVO;
import com.book45.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AlbumServiceTests {

	@Autowired
	private AlbumService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		
	}
	
	@Test
	public void testRegister() {
		
		AlbumVO album = new AlbumVO();
		
		album.setProductNum(1111111L);
		album.setCategory("꺼억2");
		album.setAlbumTitle("배불러2");
		album.setAlbumPrice(3000);
		album.setSinger("꺼억꺼억2");
		album.setEnt("이젠");
		album.setReleaseDate("230202");
		album.setAlbumPictureUrl("");
		album.setStock(10);
		
		service.register(album);
		
		log.info("생성된 게시물의 번호 : " +album.getNum());
	}
	
	@Test
	public void testGetList() {
		
		//service.getList().forEach(album->log.info(album));
		service.getList(new Criteria(2,10)).forEach(album -> log.info(album));
	}
	
	@Test
	public void testGet() {
		
		log.info(service.get(22L));
	}
	
	@Test
	public void testDelete() {
		
		log.info("remove result : " +service.remove(203L));
	}
	
	@Test
	public void testUpdate() {
		
		AlbumVO album = service.get(202L);
		
		if(album == null) {
			return;
		}
		
		album.setNum(202);
		album.setCategory("카테고리가 수정됐는디용");
		album.setAlbumTitle("제목이 수정됐는디용");
		album.setAlbumPrice(3);
		album.setSinger("ss");
		album.setEnt("마이티마우스33");
		album.setReleaseDate("34");
		album.setAlbumPictureUrl("");
		album.setStock(3);
		
		
		log.info("modify result : " +service.modify(album));
	}
	
	@Test
	public void testGetCategory() {
		log.info(service.getCategory("OST"));
	}
}
