package com.spring.app.amado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControllerJY {
	// 지윤컨트롤러
	
	//dkdkkkk지윤이다
	///////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/club/oldshop.do")
	public ModelAndView oldshop(ModelAndView mav) {
		mav.setViewName("club/oldshop.tiles2");
		//    /WEB-INF/views/oldshop.jsp
		return mav;
		
	}
	
	
}
