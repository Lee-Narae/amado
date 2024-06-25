package com.spring.app.amado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControllerJH {
	
	
	@GetMapping("/saleview/sale.do")
	public ModelAndView index(ModelAndView mav) {

		mav.setViewName("saleview/sale.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
}
