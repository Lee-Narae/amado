package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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

	@Autowired
	private AmadoService_SJ service;

	// 게시판 목록보기
	@GetMapping("/community/list.do")
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

		mav.setViewName("community/list.tiles2");
		return mav;
	}

	// 글쓰기
	@GetMapping("/community/add.do")
	public ModelAndView add(ModelAndView mav) {
		mav.setViewName("community/add.tiles2");
		return mav;
	}

	// 회원가입
	@GetMapping("/member/memberRegister.do")
	public ModelAndView memberRegister(ModelAndView mav) {
		mav.setViewName("member/memberRegister.tiles1");
		return mav;
	}

	// 회원가입
	@PostMapping("/member/memberRegister.do")
	public ModelAndView memberRegisterEnd(MemberVO membervo, ModelAndView mav) {
		
//		int n = service.memberRegisterEnd(membervo);
		
		mav.setViewName("member/memberRegister.tiles1");
		return mav;
	}

	@ResponseBody
	@PostMapping(value = "/idDuplicateCheck.do", produces = "text/plain;charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		int n = 0;
		// 아이디 중복 체크
		n = service.idDuplicateCheck(userid);

		JSONObject jsonObj = new JSONObject(); // {}

		jsonObj.put("n", n); // {"n":1} 또는 {"n":0}

		return jsonObj.toString();
	}

	@ResponseBody
	@PostMapping(value = "/emailDuplicateCheck.do", produces = "text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request) {

		String email = request.getParameter("email");

		int n = 0;
		// 이메일 중복 체크
		n = service.emailDuplicateCheck(email);

		JSONObject jsonObj = new JSONObject(); // {}

		jsonObj.put("n", n); // {"n":1} 또는 {"n":0}

		return jsonObj.toString();
	}
//
//	@ResponseBody
//	@PostMapping(value = "//phonecheck.do.do", produces = "text/plain;charset=UTF-8")
//	public String phonecheck(HttpServletRequest request) {
//
//		String hp2 = request.getParameter("hp2");
//		String hp3 = request.getParameter("hp3");
//
//		String mobile = "010" + hp2 + hp3;
//		
//		String smsContent = "";
//
//		// String api_key = "발급받은 본인의 API Key"; // 발급받은 본인 API Key
//		String api_key = "NCS99JFFEHGKULTI"; // 김승진꺼임
//
//		// String api_secret = "발급받은 본인의 API Secret"; // 발급받은 본인 API Secret
//		String api_secret = "AJOF1YU7ZJFPPSZPLG1HERVWOEDNKSHW"; // 김승진꺼임
//
//		Message coolsms = new Message(api_key, api_secret);
//
//		boolean sendSmsSuccess = false; // 문자가 정상적으로 전송되었는지 유무를 알아오기 위한 용도
//
//		
//	      // == 4개 파라미터(to, from, type, text)는 필수사항이다. == 
//	      HashMap<String, String> paraMap = new HashMap<>();
//	      paraMap.put("to", mobile); // 수신번호
//	      paraMap.put("from", "01022796802"); // 발신번호
//	      // 2020년 10월 16일 이후로 발신번호 사전등록제로 인해 등록된 발신번호로만 문자를 보내실 수 있습니다
//	      paraMap.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
//	      paraMap.put("text", smsContent); // 문자내용  
//	      
//	      String datetime = request.getParameter("datetime");
//	      if(datetime != null) {
//	         paraMap.put("datetime", datetime); // 예약일자및시간
//	      }
//	      
//	      paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version 
//
////	      JSONObject jsobj = (JSONObject) coolsms.send(paraMap);
//		
//		
//		
////		////////////////////////////
////		JSONObject jsonObj = new JSONObject(); // {}
////
////		jsonObj.put("n", n); // {"n":1} 또는 {"n":0}
//
//		return jsonObj.toString();
//	}

	// 동호회 찾가
	@GetMapping("/club/findClub.do")
	public ModelAndView findClub(ModelAndView mav) {

		mav.setViewName("/club/findClub.tiles2");
		// /WEB-INF/views/test/modelandview_select.jsp 페이지를 만들어야 한다.

		return mav;
	}

}
