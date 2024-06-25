package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.MemberVO;
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
	
	
	// 글쓰기
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
	
	@ResponseBody
	@PostMapping(value="/idDuplicateCheck.do", produces = "text/plain;charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request) {
		
		System.out.println("왔다~~~~~~~~~");
		String userid = request.getParameter("userid");
		
		// 아이디 중복 체크
		int n = service.idDuplicateCheck(userid);
		
		JSONObject jsonObj = new JSONObject(); // {}
		
		if(Objects.nonNull(n)) {
			jsonObj.put("n", 1);
		}
		else {
			jsonObj.put("n", 0);
		}
		
		return jsonObj.toString();
	}
	
	
	
	
}
