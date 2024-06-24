package com.spring.app.amado.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.service.AmadoService_NR;

@Controller
public class ControllerNR {
// 나래컨트롤러

	@Autowired
	private AmadoService_NR service;
	
	
	// 먼저 com.spring.app.HomeController에 가서 @Controller를 주석처리해야 한다.(스프링 기본 제공)
		@GetMapping("/")
		public ModelAndView home(ModelAndView mav) {
			
			mav.setViewName("redirect:/index.action");
			return mav;
		}
		
		@GetMapping("/index.do")
		public ModelAndView index(ModelAndView mav) {

			mav = service.index(mav);
			
			return mav;
		}	
		
		
}
