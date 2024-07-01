package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.MyUtil;

@Controller
public class ControllerJY {
	// 지윤컨트롤러
	
	//dkdkkkk지윤이다
	///////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/club/oldshop.do")
	public ModelAndView oldshop(ModelAndView mav) { //중고상품 리스트 보요주기


		
		mav.setViewName("club/oldshop.tiles2");
		//    /WEB-INF/views/club/oldshop.jsp
		
		return mav;
		
	}
	
	
	@RequestMapping(value="/club/viewclub.do")
	public ModelAndView viewclub(ModelAndView mav) {
		mav.setViewName("club/viewclub.tiles2");
		//    /WEB-INF/views/club/viewclub.jsp
		return mav;
		
	}

	@RequestMapping(value="/club/registerclub.do")
	public ModelAndView registerclub(ModelAndView mav) {
		mav.setViewName("club/registerclub.tiles2");
		//    /WEB-INF/views/club/viewclub.jsp
		return mav;
		
	}
	
	
	
}
