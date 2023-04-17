package com.book45.mapper;

import java.util.List;

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
public class AlbumMapperTests {

	@Autowired
	private AlbumMapper mapper;
	
//	@Test
//	public void testGetList() {
//		
//		mapper.getList().forEach(album -> log.info(album));	
//	
//	}
	
	@Test
	public void testInsert() {
		
		AlbumVO album = new AlbumVO();
		
		album.setProductNum(12336333L);
		album.setCategory("재시도");
		album.setAlbumTitle("재시도");
		album.setAlbumPrice(300);
		album.setSinger("재시도");
		album.setEnt("재시도");
		album.setReleaseDate("230202");
		album.setAlbumPictureUrl("");
		album.setStock(12);
		
		mapper.insert(album);
		
		log.info(album);
		
	}
	
	@Test
	public void testInsertSelectKey() {
		
		AlbumVO album = new AlbumVO();
		
		album.setProductNum(22242L);
		album.setCategory("재시도 selectkey");
		album.setAlbumTitle("재시도 selectkey");
		album.setAlbumPrice(300);
		album.setSinger("재시도 selectkey");
		album.setEnt("재시도 selectkey");
		album.setReleaseDate("재시도 selectkey");
		album.setAlbumPictureUrl("");
		album.setStock(12);
		
		mapper.insertSelectKey(album);
		
		log.info(album);
	}
	
	@Test
	public void testRead() {
		
		AlbumVO album = mapper.read(115258870L);
		
		log.info(album);
	}
	
	@Test
	public void testDelete() {
		
		log.info("DELETE : " +mapper.delete(202L));
	}
	
	@Test
	public void testUpdate() {
		
		AlbumVO album = new AlbumVO();
		
		//AlbumMapper.xml에 수정할 칼럼 값을 같이 수정해야함(같게 만들어야함)
	
		album.setCategory("수정된 카테고리33");
		album.setAlbumTitle("수정된 제목33");
		album.setAlbumPrice(3);
		album.setSinger("ss");
		album.setEnt("마이티마우스33");
		album.setReleaseDate("34");
		album.setAlbumPictureUrl("");
		album.setStock(3);
		album.setProductNum(202L);
		
		
		int count = mapper.update(album);
		log.info("UPDATE  : " + count);
	}
	
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		
		cri.setPageNum(4);
		cri.setAmount(10);
		
		List<AlbumVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(album -> log.info(album.getNum()));
	}
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("미니");
		cri.setType("CT");
		
		List<AlbumVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(album -> log.info(album));
	}
	
//	@Test
//	public void testCategory() {
//		
//		AlbumVO album = new AlbumVO();
//		
//		List<AlbumVO> category = mapper.getCategory(album);
//		
//		//mapper.getCategory().forEach(album -> log.info(album));	
//		
//	}
}
