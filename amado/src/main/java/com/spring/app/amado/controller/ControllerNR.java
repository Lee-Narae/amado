package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.Sha256;
import com.spring.app.domain.MemberVO;
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
	public ModelAndView requiredLogin_myClub(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", loginuser.getUserid());
		
		String sportseq = request.getParameter("sportseq");
		// System.out.println("sportseq: "+sportseq); 확인 완료
		paramap.put("sportseq", sportseq);
		
		String clubseq = service.getClubseq(paramap);
		// System.out.println("clubseq: "+clubseq); 확인 완료
		
		if(clubseq != null) {
			Map<String, String> club = service.getClubInfo(clubseq);
			mav.addObject("club", club);
		}
		
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
	
	@PostMapping("/member/loginEnd.do")
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		// === 클라이언트의 IP 주소를 알아오는 것 === //
		String clientip = request.getRemoteAddr();
		
		Map<String, String> paramap = new HashMap<>();
		paramap.put("userid", userid);
		paramap.put("password", Sha256.encrypt(password));
		paramap.put("clientip", clientip);
		
		mav = service.loginEnd(paramap, mav, request);
		
		return mav;
	}
	
	
	@GetMapping("/member/logout.do")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		String message = "로그아웃되었습니다.";
		String loc = request.getContextPath()+"/index.do";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		// /WEB-INF/views/msg.jsp
		
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
	
	
	@ResponseBody
	@GetMapping("/searchAllMatching.do")
	public String searchAllMatching() {
		
		List<Map<String,String>> matchList = service.searchAllMatching();
		
		
		return "";
	}
	
}
