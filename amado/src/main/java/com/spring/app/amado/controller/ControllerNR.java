package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
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
	
	
	@GetMapping("/club/matchRegister.do")
	public ModelAndView matchRegister(ModelAndView mav) {

		List<Map<String,String>> sportList = service.getSportList(); 
		mav.addObject("sportList", sportList);
		
		List<Map<String,String>> cityList = service.getCityList(); 
		mav.addObject("cityList", cityList);
		
		mav.setViewName("club/matchRegister.tiles2");
		return mav;
	}
	
	@ResponseBody
	@GetMapping("/club/getLocal.do")
	public String getLocal(HttpServletRequest request) {
		
		String cityname = request.getParameter("cityname");
		
		List<String> localList = service.getLocalList(cityname);
		 
		JSONArray jsonArr = new JSONArray(); 
		
		for(String local : localList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("local", local);
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	@ResponseBody
	@GetMapping("/searchMatch.do")
	public String searchMatch(HttpServletRequest request) {
		
		String sportname = request.getParameter("sportname");
		String cityname = request.getParameter("cityname");
		String localname = request.getParameter("localname");
		String matchdate = request.getParameter("matchdate");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("sportname", sportname);
		paramap.put("cityname", cityname);
		paramap.put("localname", localname);
		paramap.put("matchdate", matchdate);
		
		List<Map<String,String>> matchList = service.searchMatch(paramap);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> item :matchList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("matchingregseq", item.get("matchingregseq"));
			jsonObj.put("clubname", item.get("clubname"));
			jsonObj.put("membercount", item.get("membercount"));
			jsonObj.put("matchdate", item.get("matchdate"));
			jsonObj.put("matchtime", item.get("matchtime"));
			jsonObj.put("city", item.get("city"));
			jsonObj.put("local", item.get("local"));
			jsonObj.put("area", item.get("area"));
			jsonObj.put("status", item.get("status"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	

	@ResponseBody
	@PostMapping("/getClubseq.do")
	public String getClubseq(HttpServletRequest request) {
		
		String sportname = request.getParameter("sportname");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("sportname", sportname);
		paramap.put("userid", loginuser.getUserid());
		
		Map<String, String> club = service.getClubseq_forMatch(paramap);
		
		JSONObject jsonObj = new JSONObject();
		
		if(club != null) {
			jsonObj.put("clubseq", club.get("clubseq"));
			jsonObj.put("clubname", club.get("clubname"));
		}
		
		return jsonObj.toString();

	}

	
	
	@PostMapping("/club/matchRegister/reg.do")
	public ModelAndView reg(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<Map<String,String>> cityList = service.getCityList(); 
		mav.addObject("cityList", cityList);
		
		String sport = request.getParameter("sport");
		String city = request.getParameter("city");
		String local = request.getParameter("local");
		String date = request.getParameter("date");
		String clubseq = request.getParameter("clubseq");
		String clubname = request.getParameter("clubname");
		
		List<String> localList = service.getLocalList(city);
		mav.addObject("localList", localList);
		
		// System.out.println(clubseq+" and "+clubname); 확인 완료
		// System.out.println(sport+" "+city+" "+local+" "+date); 확인 완료
		
		mav.addObject("sportname", sport);
		mav.addObject("city", city);
		mav.addObject("local", local);
		mav.addObject("date", date);
		mav.addObject("clubseq", clubseq);
		mav.addObject("clubname", clubname);
		
		
		mav.setViewName("club/reg.tiles2");
		return mav;
	}

	
	
	@ResponseBody
	@PostMapping("/club/matchRegisterEnd.do")
	public String matchRegisterEnd(HttpServletRequest request) {

		String clubname = request.getParameter("clubname");
		String sportname = request.getParameter("sportname");
		String membercount = request.getParameter("membercount");
		String matchdate = request.getParameter("matchdate");
		String city = request.getParameter("city");
		String local = request.getParameter("local");
		String area = request.getParameter("area");
		String hour = request.getParameter("hour");
		hour = (Integer.parseInt(hour) < 10)?"0"+hour:hour;
		String minute = request.getParameter("minute");
		minute = (Integer.parseInt(minute) < 10)?"0"+minute:minute;
		
		matchdate = matchdate+" "+hour+":"+minute;
		
		String clubseq = service.getClubseq_forReg(clubname);
		String sportseq = service.getSportseq_forReg(sportname);
		
		// System.out.println(clubseq+","+sportseq); 확인 완료
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("clubseq", clubseq);
		paramap.put("sportseq", sportseq);
		paramap.put("membercount", membercount);
		paramap.put("matchdate", matchdate);
		paramap.put("city", city);
		paramap.put("local", local);
		paramap.put("area", area);
		
		int n = service.matchRegister(paramap);
		
		JSONObject jsonObj = new JSONObject();
		
		return jsonObj.toString();

	}
	
	
}
