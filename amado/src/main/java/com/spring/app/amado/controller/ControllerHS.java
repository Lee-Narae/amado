package com.spring.app.amado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControllerHS {
	// 한솔 컨트롤러
	
	
	@GetMapping(value="/gym/rental_gym.do")
	   public ModelAndView rental_gym(ModelAndView mav) {
	      
		
		
		mav.setViewName("/gym/rental_gym.tiles2");
		
		
	      return mav;
	       //  /WEB-INF/views/tiles1/opendata/korea_tour_api.jsp 페이지를 만들어야 한다.
	   }  

}
