package com.book45.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.book45.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AlbumReviewMapperTests {

	/*
	 * private Long[] productNumArr = {115544798L}; private String idArr = "admin";
	 * 
	 * @Autowired private AlbumReviewMapper mapper;
	 * 
	 * @Test public void testMapper() {
	 * 
	 * log.info(mapper); }
	 * 
	 * @Test public void testCreate() {
	 * 
	 * 
	 * Long productNum = 115258870L; String id = "member"; String nickname =
	 * "가상닉네임"; String content = "리뷰테스트";
	 * 
	 * 
	 * 
	 * AlbumReviewVO vo = new AlbumReviewVO();
	 * 
	 * vo.setProductNum(productNum); vo.setId(id); vo.setNickname(nickname);
	 * vo.setContent(content);
	 * 
	 * mapper.insert(vo);
	 * 
	 * 
	 * }
	 * 
	 * @Test public void testRead() {
	 * 
	 * Long targetNum = 5L;
	 * 
	 * AlbumReviewDTO vo = mapper.read(targetNum);
	 * 
	 * log.info(vo);
	 * 
	 * }
	 * 
	 * @Test public void testDelete() {
	 * 
	 * Long targetNum = 16L;
	 * 
	 * mapper.delete(targetNum); }
	 * 
	 * @Test public void testUpdate() {
	 * 
	 * Long targetNum = 15L;
	 * 
	 * AlbumReviewVO vo = mapper.read(targetNum);
	 * 
	 * vo.setContent("수정됨");
	 * 
	 * int count = mapper.update(vo);
	 * 
	 * log.info("수정 확인 : " +count); }
	 * 
	 * @Test public void testList() {
	 * 
	 * Criteria cri = new Criteria(2, 10);
	 * 
	 * List<AlbumReviewVO> reviews = mapper.getListWithPaging(cri,
	 * productNumArr[0]);
	 * 
	 * reviews.forEach(review ->log.info(review)); }
	 */
}
