package com.spring.app.amado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControllerSJ {
	// 승진님 컨트롤러
	
	@GetMapping("/list.do")
	public ModelAndView index(ModelAndView mav) {

		mav.setViewName("board/list.tiles2");
		
		return mav;
	}	
}
