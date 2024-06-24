package com.spring.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.model.AmadoDAO_NR;

@Service
public class AmadoService_imple_NR implements AmadoService_NR {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AmadoDAO_NR dao;
	// 원래대로라면 field 명은 bean에 올라간 대로 boardDAO_imple로 해야 하지만 어차피 BoardDAO에서 bean에 올린 것이 한 개밖에 없으므로 이름을 마음대로 해도 괜찮다.
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
    @Autowired
    private AES256 aES256;
    // Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aES256 에 주입시켜준다. 
    // 그러므로 aES256 는 null 이 아니다.
   // com.spring.app.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
	
	
	@Override
	public ModelAndView index(ModelAndView mav) {
		
		mav.setViewName("main/index.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		return mav;
	}
	
}
