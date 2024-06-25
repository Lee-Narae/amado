package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.service.AmadoService_SJ;

@Controller
public class ControllerSJ {
	// 승진님 컨트롤러
	
	private AmadoService_SJ service;
	
	// 게시판 목록보기
	@GetMapping("/list.do")
	public ModelAndView index(ModelAndView mav) {
		
		String content = "제목";
		String name = "김승진";
		String regDate = "2024-06-24";
		String readCount = "20";
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("content", content);
		paraMap.put("name", name);
		paraMap.put("regDate", regDate);
		paraMap.put("readCount", readCount);
		mav.addObject("paraMap", paraMap);	
		
		mav.setViewName("board/list.tiles2");
		return mav;
	}	
	
	
	// 회원가입
	@GetMapping("/add.do")
	public ModelAndView add(ModelAndView mav) {
		mav.setViewName("member/add.tiles1");
		return mav;
	}
	
	
	// 회원가입
	@GetMapping("/member/memberRegister.do")
	public ModelAndView memberRegister(ModelAndView mav) {
		mav.setViewName("member/memberRegister.tiles1");
		return mav;
	}	
}
