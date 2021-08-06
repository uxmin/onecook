package oc.md.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import oc.md.domain.User_tb;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class LoginAdmissionTests {
	@Autowired
	private LoginAdmissionMapper mapper;
	
//	@Test
//	public void testSelectCheckEmailS() {
//		String aaa = "b@naver.com";
//		
//		String eee = mapper.selectCheckEmail(aaa);
//		log.info("####### eeee " + eee);
//	}
//	@Test
//	public void testAdmissionOkUser() {
//		User_tb ut = new User_tb("111@naver.com", "111", "네임", "01023459090", "서울시 마포구 창전로 9길 45", null, null, "MEMBER", 0);
//	log.info("##########################ut"+ut);
//		mapper.admissionOkUser(ut);
//	}
}
