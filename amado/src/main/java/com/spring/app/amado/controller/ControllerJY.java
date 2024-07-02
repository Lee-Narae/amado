package com.spring.app.amado.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.MyUtil;
import com.spring.app.domain.ClubVO;
import com.spring.app.service.AmadoService_JY;
import com.spring.app.service.AmadoService_SJ;



@Controller
public class ControllerJY {
	// 지윤컨트롤러
	//dkdkkkk지윤이다
	
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AmadoService_JY service;
	
	///////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/club/fleamarket.do")
	public ModelAndView fleamarket(ModelAndView mav) { //중고상품 리스트 보요주기
		
		mav.setViewName("club/fleamarket.tiles2");
		//    /WEB-INF/views/club/fleamarket  .jsp
		
		return mav;
		
	}
	
	
	@RequestMapping(value="/club/viewclub.do")
	public ModelAndView viewclub(ModelAndView mav) {
		mav.setViewName("club/viewclub.tiles2");
		//    /WEB-INF/views/club/viewclub.jsp
		return mav;
		
	}

	
	// ========== 동호회 등록 ==========
	//게시판 글쓰기 폼페이지 요청
	@ResponseBody
	@RequestMapping(value="/club/clubRegister.do" , produces="text/plain;charset=UTF-8")
	public ModelAndView clubRegister(Map<String, String> paraMap, ModelAndView mav, ClubVO clubvo, MultipartHttpServletRequest mrequest) {
		
		mav.setViewName("club/clubRegister.tiles2");
		//    /WEB-INF/views/club/clubRegister.jsp
		return mav;
	}	
	
	/*
	// 동호회명 중복체크
	@ResponseBody
	@PostMapping(value = "/clubnameDuplicateCheck.do", produces = "text/plain;charset=UTF-8")
	public String clubnameDuplicateCheck(HttpServletRequest request) {

		String clubname = request.getParameter("clubname");

		int n = 0;
		
		n = service.clubnameDuplicateCheck(clubname);

		JSONObject jsonObj = new JSONObject(); // {}

		jsonObj.put("n", n); // {"n":1} 또는 {"n":0}

		return jsonObj.toString();
	}
*/
	
	//게시판 글쓰기 완료 요청 //첨부파일 있는
	
	
	
}
