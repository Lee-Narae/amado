package com.spring.app.amado.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.service.AmadoService_NR;

@Controller
public class ControllerNR {
// 나래컨트롤러 메롱

	@Autowired
	private AmadoService_NR service;
	
	
	// 먼저 com.spring.app.HomeController에 가서 @Controller를 주석처리해야 한다.(스프링 기본 제공)
	@GetMapping("/")
	public ModelAndView home(ModelAndView mav) {
		
		mav.setViewName("redirect:/index.do");
		return mav;
	}
	
	@GetMapping("/index.do")
	public ModelAndView index(ModelAndView mav) {

		mav = service.index(mav);
		
		return mav;
	}	
	
	@GetMapping("/club/myClub.do")
	public ModelAndView myClub(ModelAndView mav) {
		
		
		mav.setViewName("club/myClub.tiles2");
		// /WEB-INF/views/tiles2/club/myClub.jsp
		return mav;
	}
		
	
	@GetMapping("/club/matchRegister.do")
	public ModelAndView matchRegister(ModelAndView mav) {
		
		mav.setViewName("club/matchRegister.tiles2");
		return mav;
	}
	
	@GetMapping("/member/login.do")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("member/login.tiles1");
		return mav;
	}
	
	@GetMapping("/admin")
	public ModelAndView admin(ModelAndView mav) {
		
		mav.setViewName("admin_login");
		return mav;
	}
	
	@GetMapping("/admin/main")
	public ModelAndView test(ModelAndView mav) {
		
		mav.setViewName("adminMain.tiles3");
		return mav;
	}
	
}
