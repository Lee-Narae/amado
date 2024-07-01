package com.spring.app.amado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.service.AmadoService_JH;


@Controller
public class ControllerJH {
	
	@GetMapping("/club/sale.do")
	public ModelAndView sale(ModelAndView mav) {

		//AmadoService_JH.sale();
		
		mav.setViewName("club/sale.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
	
	@GetMapping("/club/myClub_plus.do")
	public ModelAndView myClub_plus(ModelAndView mav) {

		mav.setViewName("club/myClub_plus.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
}
