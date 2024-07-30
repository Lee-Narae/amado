package com.spring.app.amado.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
import com.spring.app.common.GoogleMail;
import com.spring.app.common.MyUtil;
import com.spring.app.common.Sha256;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;
import com.spring.app.service.AmadoService_NR;

@Controller
public class ControllerNR {
// 나래컨트롤러 메롱

	@Autowired
	private AmadoService_NR service;
	
	@Autowired
	private FileManager fileManager;
	
    @Autowired
    private AES256 aES256;
	
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
		mav.addObject("sportseq", sportseq);
		
		String clubseq = service.getClubseq(paramap);
		// System.out.println("clubseq: "+clubseq); 확인 완료
		
		if(clubseq != null) {
			Map<String, String> club = service.getClubInfo(clubseq);
			mav.addObject("club", club);
		}
		
		// 동호회장 한정 알림 불러오기(매치요청, 매치결과)
		if("1".equals(loginuser.getMemberrank())) {
			List<Map<String,String>> alarmList = service.getClubAlarm(loginuser.getUserid());
			mav.addObject("alarmList", alarmList);
		
			List<Map<String, String>> matchResultList = service.getMatchResult(loginuser.getUserid());
			mav.addObject("matchResultList", matchResultList);
		}
		
		// 우리팀 매치일정 불러오기
		if(clubseq != null) {
			List<Map<String, String>> matchList = service.getMatchList(clubseq);
			mav.addObject("matchList", matchList);
		}
		
		
		// 동호회 최신글 불러오기
		if(clubseq != null) {
			List<Map<String, String>> clubBoardList = service.getClubBoard(clubseq);
			mav.addObject("clubBoardList", clubBoardList);
		}
		
		mav.setViewName("club/myClub.tiles2");
		// /WEB-INF/views/tiles2/club/myClub.jsp
		return mav;
	}

	
	@GetMapping("/member/IdPwfind.do")
	public ModelAndView IdPwfind(ModelAndView mav, HttpServletRequest request) {
		
		String way = request.getParameter("find");
		
		mav.addObject("way", way);		
		mav.setViewName("member/idpwfind.tiles1");
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping(value="/member/findId.do", produces="text/plain;charset=UTF-8")
	public String findId(HttpServletRequest request) {
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		Map<String, String> paramap = new HashMap<String, String>();

		try {
			paramap.put("name", name);
			paramap.put("email", aES256.encrypt(email));
		} catch (Exception e) {
			e.printStackTrace();
		}
		MemberVO member = service.findId(paramap);
		
		JSONObject jsonObj = new JSONObject();
		
		if(member == null) {
			jsonObj.put("exist", "no");
		}
		else {
			jsonObj.put("userid", member.getUserid());
			jsonObj.put("exist", "yes");
		}
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/idFind_sendEmail.do", produces="text/plain;charset=UTF-8")
	public String idFind_sendEmail(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		
        Random rnd = new Random();
        
        String certification_code = "";
        
        char randchar = ' ';
        for(int i=0; i<5; i++) {
           randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
           certification_code += randchar;
        }// end of for---------------------
        
        int randnum = 0;
        for(int i=0; i<7; i++) {
           randnum = rnd.nextInt(9 - 0 + 1) + 0;
           certification_code += randnum;
        }// end of for---------------------
        
        // 랜덤하게 생성한 인증코드(certification_code)를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
        GoogleMail mail = new GoogleMail();
        JSONObject jsonObj = new JSONObject();
        
        try {
        	mail.send_certification_code(email, certification_code);
        	sendMailSuccess = true;
        	jsonObj.put("certification_code", certification_code);
        	
        } catch (Exception e) {
        	e.printStackTrace();
        	sendMailSuccess = false;
        }
        
        
        if(sendMailSuccess == true) {
        	jsonObj.put("success", "yes");
        }
        else {
        	jsonObj.put("success", "no");
        }
        
		
        
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/findpw.do", produces="text/plain;charset=UTF-8")
	public String findpw(HttpServletRequest request) {
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String userid = request.getParameter("userid");
		
		Map<String, String> paramap = new HashMap<String, String>();

		try {
			paramap.put("name", name);
			paramap.put("email", aES256.encrypt(email));
			paramap.put("userid", userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		MemberVO member = service.findpw(paramap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("userid", userid);
		
		if(member == null) {
			jsonObj.put("exist", "no");
		}
		else {
			jsonObj.put("exist", "yes");
		}
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/pwFind_sendEmail.do", produces="text/plain;charset=UTF-8")
	public String pwFind_sendEmail(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		System.out.println("email: "+email);
		
		boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		
        Random rnd = new Random();
        
        String certification_code = "";
        
        char randchar = ' ';
        for(int i=0; i<5; i++) {
           randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
           certification_code += randchar;
        }// end of for---------------------
        
        int randnum = 0;
        for(int i=0; i<7; i++) {
           randnum = rnd.nextInt(9 - 0 + 1) + 0;
           certification_code += randnum;
        }// end of for---------------------
        
        // 랜덤하게 생성한 인증코드(certification_code)를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
        GoogleMail mail = new GoogleMail();
        JSONObject jsonObj = new JSONObject();
        
        try {
        	mail.send_certification_code(email, certification_code);
        	sendMailSuccess = true;
        	jsonObj.put("certification_code2", certification_code);
        	
        } catch (Exception e) {
        	e.printStackTrace();
        	sendMailSuccess = false;
        }
        
        
        if(sendMailSuccess == true) {
        	jsonObj.put("success", "yes");
        }
        else {
        	jsonObj.put("success", "no");
        }
        
		return jsonObj.toString();
		
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/findPwUpdatePw.do", produces="text/plain;charset=UTF-8")
	public String findPwUpdatePw(HttpServletRequest request) {
		
		String newpw = request.getParameter("password");
		String userid = request.getParameter("userid");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("newpw", Sha256.encrypt(newpw));
		
		JSONObject jsonObj = new JSONObject();

		// 이전 비밀번호와 동일한지 확인
		int n = service.checkBeforePw(paramap);
		
		System.out.println("n: "+n);
		
		if(n == 1) {
			jsonObj.put("n", 0);
		}
		
		else { // 이전과 일치하지 않는 ㄱㅊ은 비번일 때 비번 업데이트
			
			n = service.findPwUpdatePw(paramap);
			
			if(n != 1) {
				n = 2;
			}
			
			jsonObj.put("n", n);
		}
		
		return jsonObj.toString();
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
	public ModelAndView admin(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO admin = (MemberVO)session.getAttribute("admin");
		
		if(admin != null) {
			mav.setViewName("redirect:/admin/main");
		}
		
		else {
			mav.setViewName("admin_login");
		}
		return mav;
	}
	
	@GetMapping("/admin/main")
	public ModelAndView adminLogin_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		// 동호회 관련 메소드
		int clubCount = service.getClubCount();
		List<Map<String, String>> clubCountList = service.getSportPerClubCount();
		mav.addObject("clubCount", clubCount);
		mav.addObject("clubCountList", clubCountList);
		
		// 회원 관련 메소드
		int allMemberCount = service.getMemberCount(1); // 1: 전체 멤버수
		int weekMemberCount = service.getMemberCount(2); // 2: 일주일 가입 멤버수
		int status1MemberCount = service.getMemberCount(3); // 3: 탈퇴 멤버수
		int rank0MemberCount = service.getMemberCount(4); // 4: 일반회원 수
		int adminMemberCount = service.getMemberCount(5); // 5: 관리자  수
		mav.addObject("allMemberCount", allMemberCount);
		mav.addObject("weekMemberCount", weekMemberCount);
		mav.addObject("status1MemberCount", status1MemberCount);
		mav.addObject("rank0MemberCount", rank0MemberCount);
		mav.addObject("adminMemberCount", adminMemberCount);
		
		// 체육관 알림 관련 메소드
		List<GymVO> gymList = service.getGymStatus(); // 아직 등록 승인 안 된 체육관 불러오기
		mav.addObject("gymList", gymList);
		mav.addObject("gymCount", gymList.size());
		
		mav.setViewName("adminMain.tiles3");
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/admin/getMemberStatic", produces="text/plain;charset=UTF-8")
	public String getMemberStatic() {
		
		JSONArray jsonArr = new JSONArray();
 		
 		for(int i=13; i>=0; i--) {
 			
 			Calendar cal1 = Calendar.getInstance();
 			cal1.add(Calendar.DATE, -i);
 			
 			Date twoWeekBefore = new Date(cal1.getTimeInMillis());
 			
 			SimpleDateFormat sdfmt = new SimpleDateFormat("yy/MM/dd");
 	 		String str_twoWeekBefore = sdfmt.format(twoWeekBefore);
 			
 	 		String memberCount = service.getMemberStatic(str_twoWeekBefore);
 	 		
 	 		JSONObject jsonObj = new JSONObject();
 	 		jsonObj.put("date", str_twoWeekBefore);
 	 		jsonObj.put("cnt", memberCount);
 	 		
 	 		jsonArr.put(jsonObj);
 			
 		}
 		
		return jsonArr.toString();
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
	@GetMapping(value="/club/getLocal.do", produces="text/plain;charset=UTF-8")
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
	@GetMapping(value="/searchMatch.do", produces="text/plain;charset=UTF-8")
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
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			if(loginuser != null) {
				String matchingregseq = item.get("matchingregseq");
				String sportseq = service.getSportseq_forReg(sportname);
				
				Map<String, String> paramap2 = new HashMap<String, String>();
				paramap2.put("sportseq", sportseq);
				paramap2.put("userid", loginuser.getUserid());
				
				String userclubseq = service.getClubseq(paramap2);

				if(userclubseq != null) {
					paramap2.put("clubseq", userclubseq);
					paramap2.put("matchingregseq", matchingregseq);
					
					int n = service.searchApply(paramap2);
					
					if(n != 0) {
						jsonObj.put("applystatus", "1");
					}
					
					else {
						jsonObj.put("applystatus", "0");
					}
				}
			}
			
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
	@PostMapping(value="/getClubseq.do", produces="text/plain;charset=UTF-8")
	public String getClubseq(HttpServletRequest request) {
		
		String sportname = request.getParameter("sportname");
		
		System.out.println("sportname: "+sportname);
		
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
	@PostMapping(value="/club/matchRegisterEnd.do", produces="text/plain;charset=UTF-8")
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
		jsonObj.put("n", n);
		
		return jsonObj.toString();

	}
	
	
	
	
	@PostMapping("/admin/adminLogin")
	public ModelAndView adminLogin(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		// System.out.println(userid+", "+password); 확인 완료
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("password", Sha256.encrypt(password));
		
		String clientip = request.getRemoteAddr();
		paramap.put("clientip", clientip);
		
		MemberVO admin = service.adminLogin(paramap);
		
		if(admin == null) {
			String message = "아이디 또는 비밀번호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		else {
			
			HttpSession session = request.getSession();
			session.setAttribute("admin", admin); 
			
			mav.setViewName("redirect:/admin/main");
		}
		
		return mav;
	}
	
	
	@GetMapping("/admin/logout")
	public ModelAndView adminLogin_adminLogout(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		String message = "로그아웃되었습니다.";
		String loc = request.getContextPath()+"/index.do";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	@GetMapping("/admin/manage/member")
	public ModelAndView adminLogin_manage_member(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String sizePerPage = request.getParameter("sizePerPage");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(sizePerPage == null || !"3".equals(sizePerPage) && !"5".equals(sizePerPage) && !"10".equals(sizePerPage)) {
			sizePerPage = "10";
		}
		
		if(searchType == null || !"name".equals(searchType) && !"userid".equals(searchType) && !"email".equals(searchType)) {
			searchType = "";
		}
		
		if(searchWord == null || searchWord != null && searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		paramap.put("sizePerPage", sizePerPage);
		paramap.put("currentShowPageNo", currentShowPageNo);

		// 페이징처리를 한 모든 회원 or 검색한 회원 목록 보여주기
		int totalPage = service.getMemberTotalPage(paramap);
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 totalPage 값보다 더 큰 값을 입력하여 장난친 경우
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 0 또는 음수를 입력하여 장난친 경우
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자열을 입력하여 장난친 경우 
		// 아래처럼 막아주도록 하겠다.
		try {
			if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) < 0) {
				currentShowPageNo = "1";
				paramap.put("currentShowPageNo", currentShowPageNo);
			}
		}catch (NumberFormatException e) {
			currentShowPageNo = "1";
			paramap.put("currentShowPageNo", currentShowPageNo);
		}
		
		
		
		// 페이지바 만들기		
		String pageBar = "";
		int blockSize = 5; // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		int loop = 1;  // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.

		// pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1
		int pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;
		// pageNo는 페이지바에서 보여지는 첫 번째 번호이다.
		
		
		// *** [맨처음][이전] 만들기 *** //
		   
           pageBar += "<li class='page-item'><a class='page-link' href='member?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";

           if(pageNo != 1) {
              pageBar += "<li class='page-item'><a class='page-link' href='member?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
           }
   
           while(!(loop > blockSize || pageNo > totalPage)) {
              
              
              if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
                 pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
              }
              else {
                 pageBar += "<li class='page-item'><a class='page-link' href='member?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
              }
              
              loop++;
              
              pageNo++;
              
           }// end of while(!( )) {}------------------- 
           
           // *** [다음][마지막] 만들기 *** //
           // pageNo ==> 11
           if(pageNo <= totalPage) {
              pageBar += "<li class='page-item'><a class='page-link' href='member?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
           }
           pageBar += "<li class='page-item'><a class='page-link' href='member?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[맨마지막]</a></li>";
           
           
         // *** ==== 페이지바 만들기 끝 ==== *** //
		
           
           
        
           
        // *** ====== 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ======= *** //
        
        String currentURL = MyUtil.getCurrentURL(request);
        // 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
        
        // System.out.println(currentURL);
        // /member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15

		List<MemberVO> memberList = service.select_member_paging(paramap);
		
		mav.addObject("memberList", memberList);
		
		if(searchType != null && ("name".equals(searchType) ||"userid".equals(searchType)||"email".equals(searchType))) {
			mav.addObject("searchType", searchType);
		}
		
		if(searchWord != null && !searchWord.trim().isEmpty()) {
			mav.addObject("searchWord", searchWord);
		}
		
		mav.addObject("sizePerPage", sizePerPage);
		mav.addObject("pageBar", pageBar);
		
		mav.addObject("currentURL", currentURL); 
		
		
		
		/* >>> 뷰단(memberList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
        	        검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 <<< */
		int totalMemberCount = service.getTotalMemberCount(paramap);
		
		mav.addObject("totalMemberCount", totalMemberCount);
		mav.addObject("currentShowPageNo", currentShowPageNo);
		
		mav.setViewName("manage/member.tiles3");
		
		return mav;
	}
	
	
	
	
	@GetMapping("/admin/memberRegisterFrmDownload")
	public void memberRegisterFrmDownload(HttpServletRequest request, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		// 한글을 깨지지 않게 한다.
		
		PrintWriter out = null;
		
		String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";
		
		boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도 
        
		flag = fileManager.doFileDownload("회원 등록 양식.xlsx", "회원 등록 양식.xlsx", path, response); 
        // file 다운로드 성공시 flag 는 true,
        // file 다운로드 실패시 flag 는 false 를 가진다.
        
        if(!flag) {
            // 다운로드가 실패한 경우 메시지를 띄워준다. 
            try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
            // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
            
            out.println("<script type='text/javascript'>alert('파일다운로드가 실패하였습니다.'); history.back();</script>");
        }
	}
	
	
	@ResponseBody
	@PostMapping(value="/admin/memberInsert", produces="text/plain;charset=UTF-8")
	public String memberInsert(MultipartHttpServletRequest mrequest) {
		
		MultipartFile mtpExcelFile = mrequest.getFile("excelsheet"); // input:file 태그의 태그 name을 넣는다.
		
		JSONObject jsonObj = new JSONObject();
		
		if(mtpExcelFile != null) {
			
			// == MultipartFile 을 File 로 변환하기 시작 ==		==> spring - MultipartFile을 java - File 로 바꾸어야 한다. 
			try {
	            // WAS 의 webapp 의 절대경로를 알아와야 한다.
	            HttpSession session = mrequest.getSession();
	            String root = session.getServletContext().getRealPath("/");
	            String path = root + "resources" + File.separator + "files";
	            File excel_file = new File(path + File.separator + mtpExcelFile.getOriginalFilename());
				mtpExcelFile.transferTo(excel_file);
				
				OPCPackage opcPackage = OPCPackage.open(excel_file);
	            /* 아파치 POI(Apache POI)는 아파치 소프트웨어 재단에서 만든 라이브러리로서 마이크로소프트 오피스파일 포맷을 순수 자바 언어로서 읽고 쓰는 기능을 제공한다. 
	                                      주로 워드, 엑셀, 파워포인트와 파일을 지원하며 최근의 오피스 포맷인 Office Open XML File Formats
	               (OOXML, 즉 xml 기반의 *.docx, *.xlsx, *.pptx 등) 이나 아웃룩, 비지오, 퍼블리셔 등으로 지원 파일 포맷을 늘려가고 있다. 
	            */
				
				XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
				
				// 첫번째 시트 불러오기
	            XSSFSheet sheet = workbook.getSheetAt(0);
				
	            List<Map<String, String>> paraMapList = new ArrayList<Map<String,String>>();
	            
	            for(int i=3; i<sheet.getLastRowNum()+1; i++) {	// 시트의 가장 첫 번째 행은 insert할 데이터가 아니므로 i=0이 아닌 i=1로 시작
	            				// 마지막 열까지 읽어줘야하므로
	            	Map<String, String> paramap = new HashMap<String, String>();
	            	
	            	XSSFRow row = sheet.getRow(i);
	            	
	            	if(row == null) { // 행이 비어있다면
	            		continue;
	            	}
	            	
	            	// 행의 첫 번째 열(ID)
	            	XSSFCell cell = row.getCell(0);
	            	if(cell != null) {
	            		paramap.put("userid", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	// 행의 두 번째 열(비번)
	            	cell = row.getCell(1);
	            	if(cell != null) {
	            		paramap.put("password", Sha256.encrypt(String.valueOf(cellReader(cell))));
	            	}
	            	
	            	// 행의 세 번째 열(이름)
	            	cell = row.getCell(2);
	            	if(cell != null) {
	            		paramap.put("name", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	// 행의 네 번째 열(이메일)
	            	cell = row.getCell(3);
	            	if(cell != null) {
	            		paramap.put("email", aES256.encrypt(String.valueOf(cellReader(cell))));
	            	}
	            	
	            	// 행의 다섯 번째 열(우편번호)
	            	cell = row.getCell(4);
	            	if(cell != null) {
	            		paramap.put("postcode", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	// 행의 여섯 번째 열(address)
	            	cell = row.getCell(5);
	            	if(cell != null) {
	            		paramap.put("address", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	// 행의 일곱 번째 열(detailaddress)
	            	cell = row.getCell(6);
	            	if(cell != null) {
	            		paramap.put("detailaddress", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	// 행의 여덟 번째 열(extraaddress)
	            	cell = row.getCell(7);
	            	if(cell != null) {
	            		paramap.put("extraaddress", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	String mobile = "";
	            	
	            	// 행의 아홉 번째 열(phone1)
	            	cell = row.getCell(8);
	            	if(cell != null) {
	            		mobile += String.valueOf(cellReader(cell));
	            	}
	            	
	            	// 행의 열 번째 열(phone2)
	            	cell = row.getCell(9);
	            	if(cell != null) {
	            		mobile += String.valueOf(cellReader(cell));
	            	}
	            	
	            	// 행의 열한 번째 열(phone3)
	            	cell = row.getCell(10);
	            	if(cell != null) {
	            		mobile += String.valueOf(cellReader(cell));
	            	}
	            	
	            	paramap.put("mobile", aES256.encrypt(mobile));
	            	
	            	// 행의 열두 번째 열(gender)
	            	cell = row.getCell(11);
	            	if(cell != null) {
	            		paramap.put("gender", String.valueOf(cellReader(cell)));
	            	}
	            	
	            	paraMapList.add(paramap);
	            	
	            } // end of for
	            
	            workbook.close();
	            
	            int insertCount = service.addMemberList(paraMapList);
				
	            if(insertCount == paraMapList.size()) { // 삽입된 결과의 합이 처음에 넣고자 했던 데이터가 들어있는 리스트의 사이즈와 같다면(insert 성공)
	            	jsonObj.put("result", 1);
	            }
	            else {
	            	jsonObj.put("result", 0);
	            }
	            excel_file.delete(); // insert하는 데 다 썼으니 이젠 지운다.(insert하기 위해서 잠시 운영경로에 올려둔 것이므로)
	            
			} catch (Exception e) {
				e.printStackTrace();
				jsonObj.put("result", 0);
			}
			// == MultipartFile 을 File 로 변환하기 끝 == 
			
		}
		
		else {
			jsonObj.put("result", 0);
		}
		
		
		return jsonObj.toString();
		
	}
	
	
	
	
	@SuppressWarnings("incomplete-switch")
	private static String cellReader(XSSFCell cell) {

		String value = "";
		CellType ct = cell.getCellType();
		
		if(ct != null) {
			switch(cell.getCellType()) {
		        case FORMULA:
					value = cell.getCellFormula()+"";
					break;
		        case NUMERIC:
		            value = cell.getNumericCellValue()+"";
		            break;
		        case STRING:
		            value = cell.getStringCellValue()+"";
		            break;
		        case BOOLEAN:
		            value = cell.getBooleanCellValue()+"";
		            break;
		        case ERROR:
		            value = cell.getErrorCellValue()+"";
		            break;
			}
		}
		
		return value; 

	}
	
	
	
	
	
	
	// 관리자 - 회원 상세정보
	@PostMapping("/admin/manage/memberDetail")
	public ModelAndView adminLogin_memberDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String goBackURL = request.getParameter("goBackURL");
		
		// System.out.println("userid: "+userid+"/"+"goBackURL: "+goBackURL); 확인 완료
		
		MemberVO member = service.getMemberDetail(userid);
		
		try {
			member.setEmail(aES256.decrypt(member.getEmail()));
			member.setMobile(aES256.decrypt(member.getMobile()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		mav.addObject("member", member);
		mav.addObject("goBackURL", goBackURL);
		
		mav.setViewName("manage/memberDetail.tiles3");
		
		return mav;
	}
	

	@GetMapping("/admin/reg/notice")
	public ModelAndView notice(ModelAndView mav) {
		
		mav.setViewName("reg/notice.tiles3");
		
		return mav;
	}
	
	
	
	
	@PostMapping("/admin/reg/notice")
	public ModelAndView editNotice(HttpServletRequest request, ModelAndView mav) {
		
		String noticeseq = request.getParameter("noticeseq");
		
		NoticeVO editNotice = service.editNotice_get(noticeseq);
		
		if(editNotice != null) {
			mav.addObject("editNotice", editNotice);
		}
		mav.setViewName("reg/editNotice.tiles3");
		return mav;
	}
	
	
	
	@PostMapping("/admin/reg/noticeEnd")
	public ModelAndView noticeEnd(HttpServletRequest request, NoticeVO nvo, MultipartHttpServletRequest mrequest, ModelAndView mav) {
		
		MultipartFile attach = nvo.getAttach();

		if(attach != null) {
			
			HttpSession session = mrequest.getSession(); 
	        String root = session.getServletContext().getRealPath("/");
	        String path = root+"resources"+File.separator+"files";
			
	        String newFileName = "";
	        
	        byte[] bytes = null;
	        
	        long fileSize = 0;
			
	        try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어서 배열에 저장한다.
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				// System.out.println("originalFilename => " + originalFilename); 
	            // originalFilename => LG_싸이킹청소기_사용설명서.pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부된 파일을 업로드하는 것
				
				// System.out.println("newFileName => " + newFileName);
				
				/*
	             3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기  
	            */
				
				nvo.setFilename(newFileName); // WAS에 저장된 파일 이름(나노시분초) => 2024062712062911435437005500.png
				nvo.setOrgfilename(originalFilename); // 원래 파일명 => icons8-volleyball-96.png ==> 사용자가 다운받을 때 이 이름 사용
				
				fileSize = attach.getSize();
				nvo.setFilesize(String.valueOf(fileSize));
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
	        
		}
		
		int n = 0;
		
		if(attach.isEmpty()) { // null 과 비슷한데 ""이어도 해당됨. return 타입은 boolean
			// 파일 첨부가 없다면
			n = service.addNotice(nvo);
		}
		
		else {
			// 파일 첨부가 있다면
			n = service.addNoticeWithFile(nvo); 
			
		}
		
		if(n == 1) {
			mav.setViewName("redirect:/community/noticeList.do");
		    //  /list.action 페이지로 redirect(페이지이동)하라는 말이다.
		}
		
		else {
			String message = "공지사항 등록이 실패하였습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");			
		}
		
		return mav;
	}
	
	
	
	@GetMapping("/community/noticeList.do")
	public ModelAndView noticeList(HttpServletRequest request, ModelAndView mav) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "10";
		
		if(searchType == null || !"title".equals(searchType) && !"content".equals(searchType)) {
			searchType = "";
		}
		
		if(searchWord == null || searchWord != null && searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		paramap.put("currentShowPageNo", currentShowPageNo);
		paramap.put("sizePerPage", sizePerPage);
		
		// 페이징처리를 한 모든 회원 or 검색한 회원 목록 보여주기
		int totalPage = service.getNoticeTotalPage(paramap);
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 totalPage 값보다 더 큰 값을 입력하여 장난친 경우
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 0 또는 음수를 입력하여 장난친 경우
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자열을 입력하여 장난친 경우 
		// 아래처럼 막아주도록 하겠다.
		try {
			if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) < 0) {
				currentShowPageNo = "1";
				paramap.put("currentShowPageNo", currentShowPageNo);
			}
		}catch (NumberFormatException e) {
			currentShowPageNo = "1";
			paramap.put("currentShowPageNo", currentShowPageNo);
		}
		
		
		
		// 페이지바 만들기		
		String pageBar = "";
		int blockSize = 5; // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		int loop = 1;  // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.

		// pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1
		int pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;
		// pageNo는 페이지바에서 보여지는 첫 번째 번호이다.
		
		
		// *** [맨처음][이전] 만들기 *** //
		   
           pageBar += "<li class='page-item'><a class='page-link' href='noticeList.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";

           if(pageNo != 1) {
              pageBar += "<li class='page-item'><a class='page-link' href='noticeList.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
           }
   
           while(!(loop > blockSize || pageNo > totalPage)) {
              
              
              if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
                 pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
              }
              else {
                 pageBar += "<li class='page-item'><a class='page-link' href='noticeList.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
              }
              
              loop++;
              
              pageNo++;
              
           }// end of while(!( )) {}------------------- 
           
           // *** [다음][마지막] 만들기 *** //
           // pageNo ==> 11
           if(pageNo <= totalPage) {
              pageBar += "<li class='page-item'><a class='page-link' href='noticeList.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
           }
           pageBar += "<li class='page-item'><a class='page-link' href='noticeList.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[맨마지막]</a></li>";
           
           
         // *** ==== 페이지바 만들기 끝 ==== *** //
		
           
           
        
           
        // *** ====== 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ======= *** //
        
        String currentURL = MyUtil.getCurrentURL(request);
        // 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
        
        // System.out.println(currentURL);
        // /member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15

		List<NoticeVO> noticeList = service.select_notice_paging(paramap);
		
		mav.addObject("noticeList", noticeList);
		
		if(searchType != null && ("title".equals(searchType) ||"content".equals(searchType))) {
			mav.addObject("searchType", searchType);
		}
		
		if(searchWord != null && !searchWord.trim().isEmpty()) {
			mav.addObject("searchWord", searchWord);
		}
		
		mav.addObject("paramap", paramap);
		mav.addObject("pageBar", pageBar);
		
		mav.addObject("currentURL", currentURL); 
		
		
		
		/* >>> 뷰단(memberList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
        	        검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 <<< */
		int totalMemberCount = service.getTotalNoticeCount(paramap);
		
		mav.addObject("totalMemberCount", totalMemberCount);
		mav.addObject("currentShowPageNo", currentShowPageNo);
		
		mav.setViewName("community/noticeList.tiles2");
		
		return mav;
	}
	
	
	
	
	@PostMapping("/community/noticeDetail.do")
	public ModelAndView noticeDetail(ModelAndView mav, HttpServletRequest request) {
		
		String noticeseq = request.getParameter("noticeseq");
		String goBackURL = request.getParameter("goBackURL");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("noticeseq", noticeseq);
		paramap.put("goBackURL", goBackURL);
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		
		// 댓글
		List<Map<String,String>> commentList = service.getNoticeComment(noticeseq);
		
		// 댓글 수
		String commentCount = service.getNoticeCommentCount(noticeseq);
		
		if(commentList.size() > 0) {
			mav.addObject("commentList", commentList);
			mav.addObject("commentCount", commentCount);
		}
		
		
		// 게시글
		NoticeVO notice = service.getNoticeDetail(paramap);
		
		if(notice == null) {
			String message = "존재하지 않는 게시글입니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		// 조회수 (로그인 여부 상관 없이, 중복 상관 없이 무조건 1 증가)
		service.updateNoticeViewcount(noticeseq);
		
		
		mav.addObject("notice", notice);
		mav.addObject("noticeseq", noticeseq);
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		
		mav.setViewName("community/noticeDetail.tiles2");
		return mav;
	}
	
	
	@GetMapping("/community/noticeAttachDownload.do")
	public void noticeAttachDownload(HttpServletRequest request, HttpServletResponse response) {
		
		String noticeseq = request.getParameter("noticeseq");
	
		// 파일관련 이름 알아오기
		Map<String, String> filenameMap = service.getOrgfilename(noticeseq);
		
		String filename = filenameMap.get("filename");
		String orgfilename = filenameMap.get("orgfilename");
		
		HttpSession session = request.getSession(); 
        String root = session.getServletContext().getRealPath("/");
        String path = root+"resources"+File.separator+"files";
		
        fileManager.doFileDownload(filename, orgfilename, path, response);
		
	}
	
	
	@PostMapping("/community/deleteNotice.do")
	public ModelAndView deleteNotice(HttpServletRequest request, ModelAndView mav) {
	
		String noticeseq = request.getParameter("noticeseq");
		
		int n = service.deleteNotice(noticeseq);
		
		if(n == 1) {
			
			String message = "공지사항이 삭제되었습니다.";
			String loc = "noticeList.do";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		
		else {
			
			String message = "게시글 삭제가 실패하였습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		}
		
		return mav;
	}
	
	
	@PostMapping("/community/editNotice.do")
	public ModelAndView editNoticeEnd(MultipartHttpServletRequest mrequest, NoticeVO nvo, ModelAndView mav) {

		MultipartFile attach = nvo.getAttach();

		if(attach != null) {
			
			HttpSession session = mrequest.getSession(); 
	        String root = session.getServletContext().getRealPath("/");
	        String path = root+"resources"+File.separator+"files";
			
	        String newFileName = "";
	        
	        byte[] bytes = null;
	        
	        long fileSize = 0;
			
	        try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어서 배열에 저장한다.
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				// System.out.println("originalFilename => " + originalFilename); 
	            // originalFilename => LG_싸이킹청소기_사용설명서.pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부된 파일을 업로드하는 것
				
				// System.out.println("newFileName => " + newFileName);
				
				/*
	             3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기  
	            */
				
				nvo.setFilename(newFileName); // WAS에 저장된 파일 이름(나노시분초) => 2024062712062911435437005500.png
				nvo.setOrgfilename(originalFilename); // 원래 파일명 => icons8-volleyball-96.png ==> 사용자가 다운받을 때 이 이름 사용
				
				fileSize = attach.getSize();
				nvo.setFilesize(String.valueOf(fileSize));
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
	        
		}
		
		int n = 0;
		
		// 1. 기존 첨부파일을 삭제하고 아무것도 올리지 않은 경우 -> 행 update 시 filename, orgfilename, filesize 비우기 (확인 완료)
		if("1".equals(nvo.getDeleteAttach()) && "".equals(attach.getOriginalFilename())) {
			n = service.editNoticeBy1(nvo);
		}
		
		
		// 2. attach가 있는 경우 -> 행 update 시 filename, orgfilename, filesize 바꾸기 (확인 완료)
		else if(!"".equals(attach.getOriginalFilename())) {
			n = service.editNoticeBy2(nvo);
		}
		
		
		// 3. 기존 첨부파일을 지우지 않고 attach도 없는 경우 -> 행 update 시 filename, orgfilename, filesize 건들지 않기
		else if("0".equals(nvo.getDeleteAttach()) && "".equals(attach.getOriginalFilename())) {
			n = service.editNoticeBy3(nvo);
		}
		
		if(n == 1) {
			mav.setViewName("redirect:/community/noticeList.do");
		    //  /list.action 페이지로 redirect(페이지이동)하라는 말이다.
		}
		
		else {
			String message = "공지사항 수정이 실패하였습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");			
		}
		
		return mav;
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/community/regComment.do", produces="text/plain;charset=UTF-8")
	public String requiredLogin_regComment(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String comment_text = request.getParameter("comment_text");
		String parentseq = request.getParameter("parentseq");
		
		Map<String, String> paramap = new HashMap<String, String>();
		
		paramap.put("comment_text", comment_text);
		paramap.put("parentseq", parentseq);
		paramap.put("fk_userid", loginuser.getUserid());
		
		int n = service.insertNoticeComment(paramap);
		
		JSONArray jsonArr = new JSONArray();

		if(n == 1) {
			
			// tbl_notice commentcount 컬럼 1 올리기
			service.updateNoticeCommentcount(parentseq);
			
			List<Map<String,String>> commentList = service.getNoticeComment(parentseq);
			
			for(Map<String,String> commentmap : commentList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("noticecommentseq", commentmap.get("noticecommentseq"));
				jsonObj.put("parentseq", commentmap.get("parentseq"));
				jsonObj.put("comment_text", commentmap.get("comment_text"));
				jsonObj.put("registerdate", commentmap.get("registerdate"));
				jsonObj.put("fk_userid", commentmap.get("fk_userid"));
				jsonObj.put("memberimg", commentmap.get("memberimg"));
				
				jsonArr.put(jsonObj);
			}
			
		}
		
		
		return jsonArr.toString();
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/community/delNoticeComment.do", produces="text/plain;charset=UTF-8")
	public String delNoticeComment(HttpServletRequest request) {
		
		String noticecommentseq = request.getParameter("noticecommentseq");
		String parentseq = request.getParameter("parentseq");
		
		int n = service.delNoticeComment(noticecommentseq);
		
		service.updateNoticeCommentcount_del(parentseq);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@GetMapping(value="/community/viewCommentOnly.do", produces="text/plain;charset=UTF-8")
	public String viewCommentOnly(HttpServletRequest request) {
		String parentseq = request.getParameter("parentseq");
		
		List<Map<String,String>> commentList = service.getNoticeComment(parentseq);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> commentmap : commentList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("noticecommentseq", commentmap.get("noticecommentseq"));
			jsonObj.put("parentseq", commentmap.get("parentseq"));
			jsonObj.put("comment_text", commentmap.get("comment_text"));
			jsonObj.put("registerdate", commentmap.get("registerdate"));
			jsonObj.put("fk_userid", commentmap.get("fk_userid"));
			jsonObj.put("memberimg", commentmap.get("memberimg"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/community/editNoticeComment.do", produces="text/plain;charset=UTF-8")
	public String editNoticeComment(HttpServletRequest request) {
		
		String comment_text = request.getParameter("edit_comment_text");
		String noticecommentseq = request.getParameter("commentseq");
		
		Map<String, String> paramap = new HashMap<String, String>();
		
		paramap.put("comment_text", comment_text);
		paramap.put("noticecommentseq", noticecommentseq);
		
		int n = service.editNoticeComment(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@GetMapping(value="/club/getSportseq.do", produces="text/plain;charset=UTF-8")
	public String getSportseq(HttpServletRequest request) {
		
		String matchingregseq = request.getParameter("matchingregseq");
		
		String sportseq = service.getSportseq(matchingregseq);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("sportseq", sportseq);
		paramap.put("fk_userid", loginuser.getUserid());
		
		Map<String, String> resultmap = service.getUserClubname(paramap);

		JSONObject jsonObj = new JSONObject();

		if(resultmap != null) {
			jsonObj.put("clubname", resultmap.get("clubname"));
			jsonObj.put("clubseq", resultmap.get("clubseq"));
		}
		
		
		return jsonObj.toString();
	}
	
	
	@PostMapping("/club/goApply.do")
	public ModelAndView goApply(ModelAndView mav, HttpServletRequest request) {
		
		String membercount = request.getParameter("membercount");
		String message = request.getParameter("message");
		String appclubseq = request.getParameter("appclubseq");
		String matchingregseq = request.getParameter("matchingregseq");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("membercount", membercount);
		paramap.put("message", message);
		paramap.put("appclubseq", appclubseq);
		paramap.put("matchingregseq", matchingregseq);
		
		int n = service.applyMatch(paramap);
		
		if(n==1) {
			String message1 = "매치 신청이 완료되었습니다. 상대팀의 수락 여부에 따라 매치가 결정됩니다.";
			String loc = "matchRegister.do";
			
			mav.addObject("message", message1);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");	
		}
		
		return mav;
	}
	
	
	
	@ResponseBody
	@GetMapping(value="/admin/getGymInfo", produces="text/plain;charset=UTF-8")
	public String getGymInfo(HttpServletRequest request) {
		
		String gymseq = request.getParameter("gymseq");
		
		GymVO gym = service.getGymInfo(gymseq);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("gymseq", gym.getGymseq());
		jsonObj.put("gymname", gym.getGymname());
		jsonObj.put("fk_userid", gym.getFk_userid());
		jsonObj.put("postcode", gym.getPostcode());
		jsonObj.put("address", gym.getAddress());
		jsonObj.put("detailaddress", gym.getDetailaddress());
		jsonObj.put("status", gym.getStatus());
		jsonObj.put("info", gym.getInfo());
		jsonObj.put("cost", gym.getCost());
		jsonObj.put("caution", gym.getCaution());
		jsonObj.put("membercount", gym.getMembercount());
		jsonObj.put("likecount", gym.getLikecount());
		jsonObj.put("insidestatus", gym.getInsidestatus());
		jsonObj.put("orgfilename", gym.getOrgfilename());
		jsonObj.put("filename", gym.getFilename());
		jsonObj.put("filesize", gym.getFilesize());
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/admin/gymPermit", produces="text/plain;charset=UTF-8")
	public String gymPermit(HttpServletRequest request) {
		
		String gymseq = request.getParameter("gymseq");
		
		int n = service.gymPermit(gymseq);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/club/matching.do", produces="text/plain;charset=UTF-8")
	public String matching (HttpServletRequest request) {
		
		String matchingapplyseq = request.getParameter("matchingapplyseq");
		String matchingregseq = request.getParameter("matchingregseq");
		String Aseq = request.getParameter("Aseq");
		String Bseq = request.getParameter("Bseq");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("matchingapplyseq", matchingapplyseq);
		paramap.put("matchingregseq", matchingregseq);
		paramap.put("Aseq", Aseq);
		paramap.put("Bseq", Bseq);
		
		// 선택된 동호회의 tbl_matchingapplyseq 행 status는 1로, 선택받지 못한 동호회는 2로, tbl_matchingreg의  matchingregseq 행 status는 1로
		// 1. tbl_matchingapply
		int n = service.updateMatchingApply(paramap);

		if(n == 1) {
			// 2. tbl_matchingreg
			n = service.updateMatchingReg(matchingregseq);
			if(n == 1) {
				// 3. tbl_matching
				n = service.insertMatching(paramap);
			}
			
		}
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	

	@GetMapping("admin/reg/gym")
	public ModelAndView AdminGymRegister(ModelAndView mav) {
		
		
		mav.setViewName("reg/gym.tiles3");
		
		return mav;
		
	}
	
	
	@ResponseBody
	@PostMapping(value="/admin/reg/gymReg", produces="text/plain;charset=UTF-8")
	public String gymReg(GymVO gym, MultipartHttpServletRequest mrequest) {
		
		// gymseq 채번
		String gymseq = service.getGymseq();
		
		gym.setGymseq(gymseq);
		
		// 대표이미지
		MultipartFile attach = gym.getAttach();
		
		HttpSession session = mrequest.getSession(); 
        String root = session.getServletContext().getRealPath("/");
        String path = root+"resources"+File.separator+"files";
        
        String newFileName = "";
        byte[] bytes = null;
        long fileSize = 0;
        
        try {
            bytes = attach.getBytes();
            String originalFilename = attach.getOriginalFilename();
            newFileName = fileManager.doFileUpload(bytes, originalFilename, path); 
            fileSize = attach.getSize();  // 첨부파일의 크기(단위는 byte임)
            
            gym.setFilename(newFileName);
            gym.setOrgfilename(originalFilename);
            gym.setFilesize(String.valueOf(fileSize));
                     
        } catch (Exception e) {
           e.printStackTrace();
        }   
        
        int n = service.adminGymreg(gym);
        int n2 = 0;
        
        if(n == 1) {
        
			// 추가이미지
			List<MultipartFile> fileList = mrequest.getFiles("file_arr");
			
		    for(MultipartFile mtfile : fileList) {
		    	try {
		            bytes = mtfile.getBytes();
		            String originalFilename = mtfile.getOriginalFilename();
		            newFileName = fileManager.doFileUpload(bytes, originalFilename, path); 
		            fileSize = mtfile.getSize();  // 첨부파일의 크기(단위는 byte임)
		            
		            Map<String, String> paramap = new HashMap<String, String>();
		            paramap.put("gymseq", gymseq);
		            paramap.put("filename", newFileName);
		            paramap.put("orgfilename", originalFilename);
		            paramap.put("filesize", String.valueOf(fileSize));
		            
		            // tbl_gymimg DB insert
		            n2 = service.insertGymImg(paramap);
		            
		        } catch (Exception e) {
		           e.printStackTrace();
		        }  
		    }
		
        }	
	    	
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("n", n*n2);
		
		return jsonObj.toString();
	}
	
	
	@GetMapping("/opendata/opendata_JSON.do")
	public String opendata(HttpServletRequest request) throws IOException, ParseException {
		
		return "opendata.tiles1";
	}
	
	@ResponseBody
	@GetMapping("/opendata/insertData.do")
	public String insertData(HttpServletRequest request) {
		
		String city = request.getParameter("city");
		String newAdd = request.getParameter("newAdd");
		String oldAdd = request.getParameter("oldAdd");
		String postcode = request.getParameter("postcode");
		String status = request.getParameter("status");
		String type = request.getParameter("type");
		String name = request.getParameter("name");
		
		if(city == null) {
			city = "없음";
		}
		if(newAdd == null) {
			newAdd = "없음";
		}
		if(oldAdd == null) {
			oldAdd = "없음";
		}
		if(postcode == null) {
			postcode = "없음";
		}
		if(status == null) {
			status = "없음";
		}
		if(type == null) {
			type = "없음";
		}
		if(name == null) {
			name = "없음";
		}
		
		Map<String, String> paramap = new HashMap<String, String>();
        paramap.put("city", city);
        paramap.put("newAdd", newAdd);
        paramap.put("oldAdd", oldAdd);
        paramap.put("postcode", postcode);
        paramap.put("status", status);
        paramap.put("type", type);
        paramap.put("name", name);
        
        int n = service.insertOpendata(paramap);
		
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("n", n);
        
		return jsonObj.toString();
	}

	
	@GetMapping("/community/SportsFacilitiesInfo.do")
	public ModelAndView SportsFacilitiesInfo(ModelAndView mav, HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "10";
		
		if(searchType == null || !"name".equals(searchType) && !"type".equals(searchType) && !"newadd".equals(searchType)) {
			searchType = "";
		}
		
		if(searchWord == null || searchWord != null && searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		paramap.put("currentShowPageNo", currentShowPageNo);
		paramap.put("sizePerPage", sizePerPage);
		
		int totalPage = service.getfacTotalPage(paramap);
		
		try {
			if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) < 0) {
				currentShowPageNo = "1";
				paramap.put("currentShowPageNo", currentShowPageNo);
			}
		}catch (NumberFormatException e) {
			currentShowPageNo = "1";
			paramap.put("currentShowPageNo", currentShowPageNo);
		}
		
		// 페이지바 만들기		
		String pageBar = "";
		int blockSize = 10; // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		int loop = 1;  // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.

		// pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1
		int pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;
		// pageNo는 페이지바에서 보여지는 첫 번째 번호이다.
		
		
		// *** [맨처음][이전] 만들기 *** //
		   
           pageBar += "<li class='page-item'><a class='page-link' href='SportsFacilitiesInfo.do?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";

           if(pageNo != 1) {
              pageBar += "<li class='page-item'><a class='page-link' href='SportsFacilitiesInfo.do?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
           }
   
           while(!(loop > blockSize || pageNo > totalPage)) {
              
              
              if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
                 pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
              }
              else {
                 pageBar += "<li class='page-item'><a class='page-link' href='SportsFacilitiesInfo.do?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
              }
              
              loop++;
              
              pageNo++;
              
           }// end of while(!( )) {}------------------- 
           
           // *** [다음][마지막] 만들기 *** //
           // pageNo ==> 11
           if(pageNo <= totalPage) {
              pageBar += "<li class='page-item'><a class='page-link' href='SportsFacilitiesInfo.do?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
           }
           pageBar += "<li class='page-item'><a class='page-link' href='SportsFacilitiesInfo.do?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[맨마지막]</a></li>";
           
           
         // *** ==== 페이지바 만들기 끝 ==== *** //

        List<Map<String, String>> facList = service.getFacList(paramap);
		
		mav.addObject("facList", facList);
		
		if(searchType != null && ("name".equals(searchType) ||"type".equals(searchType) || "newadd".equals(searchType))) {
			mav.addObject("searchType", searchType);
		}
		
		if(searchWord != null && !searchWord.trim().isEmpty()) {
			mav.addObject("searchWord", searchWord);
		}
		
		mav.addObject("paramap", paramap);
		mav.addObject("pageBar", pageBar);
		
		/* >>> 뷰단(memberList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
        	        검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 <<< */
		int totalMemberCount = service.getTotalFacCount(paramap);
		
		mav.addObject("totalMemberCount", totalMemberCount);
		mav.addObject("currentShowPageNo", currentShowPageNo);
		
		
		mav.setViewName("opendata/SportsFacilitiesInfo.tiles1");
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/community/searchFacByCity.do", produces="text/plain;charset=UTF-8")
	public String searchFacByCity() {
		
		// 지역별 체육시설 현황
		List<Map<String, String>> cityFacList = service.searchFacByCity();
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> cityMap : cityFacList) {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("city", cityMap.get("city"));
			jsonObj.put("cnt", cityMap.get("cnt"));
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	@ResponseBody
	@GetMapping(value="/community/searchFacByLocal.do", produces="text/plain;charset=UTF-8")
	public String searchFacByLocal(HttpServletRequest request) {
		
		String city = request.getParameter("city");
		
		List<Map<String, String>> localFacList = service.searchFacByLocal(city);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> localMap : localFacList) {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("local", localMap.get("local"));
			jsonObj.put("cnt", localMap.get("cnt"));
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/club/matchResultInsert.do", produces="text/plain;charset=UTF-8")
	public String matchResultInsert(HttpServletRequest request) {
		
		String score1 = request.getParameter("score1");
		String score2 = request.getParameter("score2");
		String matchingseq = request.getParameter("matchingseq");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("score1", score1);
		paramap.put("score2", score2);
		paramap.put("matchingseq", matchingseq);
		
		String result1 = "";
		String result2 = "";
		
		if(Integer.parseInt(score1) > Integer.parseInt(score2)) {
			result1 = "1";
			result2 = "2";
		}
		
		else if (Integer.parseInt(score1) < Integer.parseInt(score2)) {
			result1 = "2";
			result2 = "1";
		}
		
		else if (Integer.parseInt(score1) == Integer.parseInt(score2)) {
			result1 = "3";
			result2 = "3";
		}
		
		paramap.put("result1", result1);
		paramap.put("result2", result2);
		
		
		int n = service.updateMatchResult(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@GetMapping("/member/myPage.do")
	public ModelAndView requiredLogin_myPage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("member/myPage_info.tiles1");
		return mav;
	}
	
	
	@PostMapping("/member/infoEdit.do")
	public ModelAndView infoEdit(HttpServletRequest request, MemberVO editMember, MultipartHttpServletRequest mrequest, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		editMember.setUserid(loginuser.getUserid());
		
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		
		try {
			editMember.setMobile(aES256.encrypt(phone1+phone2+phone3));
			editMember.setEmail(aES256.encrypt(editMember.getEmail()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		MultipartFile attach = editMember.getAttach();

		if(attach != null) {
			
	        String root = session.getServletContext().getRealPath("/");
	        String path = root+"resources"+File.separator+"files";
			
	        String newFileName = "";
	        
	        byte[] bytes = null;
	        
	        try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어서 배열에 저장한다.
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				// System.out.println("originalFilename => " + originalFilename); 
	            // originalFilename => LG_싸이킹청소기_사용설명서.pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부된 파일을 업로드하는 것
				
				// System.out.println("newFileName => " + newFileName);
				
				/*
	             3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기  
	            */
				
				editMember.setMemberimg(newFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
	        
		}
		
		int n = 0;
		
		if(attach.isEmpty()) { // null 과 비슷한데 ""이어도 해당됨. return 타입은 boolean
			// 파일 첨부가 없다면
			editMember.setMemberimg(null);
			n = service.updateMemberInfo_noAttach(editMember);
		}
		
		else {
			// 파일 첨부가 있다면
			n = service.updateMemberInfo_attach(editMember);
		}

		if(n == 1) {
			
			editMember.setName(loginuser.getName());
			editMember.setGender(loginuser.getGender());
			editMember.setBirthday(loginuser.getBirthday());
			editMember.setMemberrank(loginuser.getMemberrank());
			editMember.setPwdchangegap(loginuser.getPwdchangegap());
			editMember.setLastlogingap(loginuser.getLastlogingap());
			editMember.setMobile(phone1+phone2+phone3);
			try {
				editMember.setEmail(aES256.decrypt(editMember.getEmail()));
				editMember.setMobile(aES256.decrypt(editMember.getMobile()));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			session.setAttribute("loginuser", editMember);
			
			String msg = "회원정보 수정이 완료되었습니다.";
			String loc = request.getContextPath()+"/member/myPage.do";
			mav.addObject("message", msg);
			mav.addObject("loc", loc);
		}
		
		else {
			String msg = "회원정보 수정이 실패하였습니다.";
			String loc = request.getContextPath()+"/member/myPage.do";
			mav.addObject("message", msg);
			mav.addObject("loc", loc);
		}
		
		
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/changePw.do", produces="text/plain;charset=UTF-8")
	public String changePw(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String password = request.getParameter("password");
		String newPw = request.getParameter("newPw");
		
		Map<String, String> paramap = new HashMap<String, String>();

		paramap.put("userid", loginuser.getUserid());
		paramap.put("password", Sha256.encrypt(password));
		paramap.put("newPw", Sha256.encrypt(newPw));
	
		// 입력한 비밀번호가 일치하는지
		int n = service.checkPw(paramap);
	
		JSONObject jsonObj = new JSONObject();
		
		if(n == 1) {
			n = service.changePw(paramap);
			session.removeAttribute("loginuser");
			jsonObj.put("n", n);
		}
		
		else {
			jsonObj.put("n", 3);
		}

		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/checkPw.do", produces="text/plain;charset=UTF-8")
	public String checkPw(HttpServletRequest request) {
		
		String pwd = request.getParameter("pwd");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", loginuser.getUserid());
		paramap.put("password", Sha256.encrypt(pwd));
		
		int n = service.checkPw(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/member/memberQuit.do", produces="text/plain;charset=UTF-8")
	public String memberQuit(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		HttpSession session = request.getSession();
		
		int n = service.memberQuit(userid);
		
		if(n == 1) {
			session.removeAttribute("loginuser");
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@GetMapping("/member/myPage_club.do")
	public ModelAndView requiredLogin_myPage_club(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// 가입동호회 조회
		Map<String, String> soccer = service.getSoccer(loginuser.getUserid());
		Map<String, String> baseball = service.getBaseball(loginuser.getUserid());
		Map<String, String> volley = service.getVolley(loginuser.getUserid());
		Map<String, String> basket = service.getBasket(loginuser.getUserid());
		Map<String, String> tennis = service.getTennis(loginuser.getUserid());
		Map<String, String> bowling = service.getBowling(loginuser.getUserid());
		Map<String, String> jokgu = service.getJokgu(loginuser.getUserid());
		Map<String, String> minton = service.getMinton(loginuser.getUserid());
		
		mav.addObject("soccer", soccer);
		mav.addObject("baseball", baseball);
		mav.addObject("volley", volley);
		mav.addObject("basket", basket);
		mav.addObject("bowling", bowling);
		mav.addObject("jokgu", jokgu);
		mav.addObject("minton", minton);
		mav.addObject("tennis", tennis);
		
		
		// 내 동호회 관리
		List<ClubVO> clubList = service.getMyClub(loginuser.getUserid());
		mav.addObject("clubList", clubList);
		
		mav.setViewName("member/myPage_club.tiles1");
		return mav;
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/member/quitClub.do", produces="text/plain;charset=UTF-8")
	public String quitClub(HttpServletRequest request) {
		
		String clubseq = request.getParameter("clubseq");
		String userid = request.getParameter("userid");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("clubseq", clubseq);
		paramap.put("userid", userid);
		
		int n = service.quitClub(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/checkClubMaster.do", produces="text/plain;charset=UTF-8")
	public String checkClubMaster(HttpServletRequest request) {
		
		String clubseq = request.getParameter("clubseq");
		String userid = request.getParameter("userid");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("clubseq", clubseq);
		paramap.put("userid", userid);
		
		int n = service.checkClubMaster(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/clubEdit.do", produces="text/plain;charset=UTF-8")
	public String clubEdit(ClubVO club) {
		
		int n = service.updateClubInfo(club);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/deleteClub.do", produces="text/plain;charset=UTF-8")
	public String deleteClub(HttpServletRequest request) {
		
		String clubseq = request.getParameter("clubseq");
		
		int n = service.deleteClub(clubseq);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	@ResponseBody
	@GetMapping(value="/member/getClubmember.do", produces="text/plain;charset=UTF-8")
	public String getClubmember(HttpServletRequest request) {
		
		String clubseq = request.getParameter("clubseq");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "7";
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("currentShowPageNo", currentShowPageNo);
		paramap.put("sizePerPage", sizePerPage);
		paramap.put("clubseq", clubseq);
		
		int totalPage = service.getClubMemberTotalPage(paramap);
		
		try {
			if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) < 0) {
				currentShowPageNo = "1";
				paramap.put("currentShowPageNo", currentShowPageNo);
			}
		}catch (NumberFormatException e) {
			currentShowPageNo = "1";
			paramap.put("currentShowPageNo", currentShowPageNo);
		}
		
		// 페이지바 만들기		
		String pageBar = "";
		int blockSize = 3; // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		int loop = 1;  // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.

		// pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1
		int pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;
		// pageNo는 페이지바에서 보여지는 첫 번째 번호이다.
		
		
		// *** [맨처음][이전] 만들기 *** //
		   
           pageBar += "<li class='page-item'><a class='page-link' onclick='movePage(1,"+clubseq+")'>[맨처음]</a></li>";

           if(pageNo != 1) {
              pageBar += "<li class='page-item'><a class='page-link' onclick='movePage("+(pageNo-1)+","+clubseq+")'>[이전]</a></li>";
           }
   
           while(!(loop > blockSize || pageNo > totalPage)) {
              
              
              if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
                 pageBar += "<li class='page-item active'><a class='page-link'>"+pageNo+"</a></li>";
              }
              else {
                 pageBar += "<li class='page-item'><a class='page-link' onclick='movePage("+pageNo+","+clubseq+")'>"+pageNo+"</a></li>";
              }
              
              loop++;
              
              pageNo++;
              
           }// end of while(!( )) {}------------------- 
           
           // *** [다음][마지막] 만들기 *** //
           // pageNo ==> 11
           if(pageNo <= totalPage) {
              pageBar += "<li class='page-item'><a class='page-link' onclick='movePage("+pageNo+","+clubseq+")'>[다음]</a></li>";
           }
           pageBar += "<li class='page-item'><a class='page-link' onclick='movePage("+totalPage+","+clubseq+")'>[맨마지막]</a></li>";
           
           
         // *** ==== 페이지바 만들기 끝 ==== *** //

        List<Map<String, String>> memberList = service.getClubMember(paramap);
		
    	JSONArray jsonarr = new JSONArray();
		
		for(Map<String, String> member : memberList) {
			
			JSONObject jsonobj = new JSONObject();
			
			try {
				jsonobj.put("rn", member.get("rn"));
				jsonobj.put("userid", member.get("userid"));
				jsonobj.put("name", member.get("name"));
				jsonobj.put("email", aES256.decrypt(member.get("email")));
				jsonobj.put("mobile", aES256.decrypt(member.get("mobile")));
				jsonobj.put("gender", "1".equals(member.get("gender"))?"남":"여");
				jsonobj.put("clubseq", member.get("clubseq"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			jsonarr.put(jsonobj);
			
		}
		
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("pageBar", pageBar);
		
		int totalMemberCount = service.getTotalClubMemberCount(paramap);
		jsonobj.put("totalMemberCount", totalMemberCount);
		jsonobj.put("currentShowPageNo", currentShowPageNo);
		
		jsonarr.put(jsonobj);
		
		return jsonarr.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/quitClubMember.do", produces="text/plain;charset=UTF-8")
	public String quitClubMember(HttpServletRequest request) {
		
		String clubseq = request.getParameter("clubseq");
		String userid = request.getParameter("userid");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("clubseq", clubseq);
		paramap.put("userid", userid);
		
		int n = service.quitClubMember(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	@PostMapping("/member/clubEmail.do")
	public ModelAndView clubEmail (HttpServletRequest request, ModelAndView mav) {
		
		String email = request.getParameter("receive");	// 받는 사람 이메일
		String userid = request.getParameter("send");	// 보내는 사람 ID
		
		mav.addObject("email", email);
		mav.addObject("userid", userid);
		mav.setViewName("member/clubEmail.tiles1");
		return mav;
	}
	
	
	@ResponseBody
	@PostMapping(value="/member/sendClubEmail.do", produces="text/plain;charset=UTF-8")
	public String sendClubEmail(MultipartHttpServletRequest mrequest) {
		
		String email = mrequest.getParameter("email");
		String title = mrequest.getParameter("title"); 
		String content = mrequest.getParameter("content");
		String userid = mrequest.getParameter("send");
		
		List<MultipartFile> fileList = mrequest.getFiles("file_arr");
		
		HttpSession session = mrequest.getSession();
	    String root = session.getServletContext().getRealPath("/");
	    String path = root + "resources"+File.separator+"email_attach_file";
		
	    File dir = new File(path);
	    if(!dir.exists()) {
	    	dir.mkdirs();
	    }
	    
	    String[] arr_attachFilename = null;
	    
	    if(fileList != null && fileList.size() > 0) {
	    	arr_attachFilename = new String[fileList.size()];
	    
	    	for(int i=0; i<fileList.size(); i++) {
	    		MultipartFile mtfile = fileList.get(i);
	    
	    		try {
	    			File attachFile = new File(path+File.separator+mtfile.getOriginalFilename());
	    			mtfile.transferTo(attachFile);
	    			
	    			arr_attachFilename[i] = mtfile.getOriginalFilename();
	    		} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
	    		
	    	}
	    	
	    }
	    
	    JSONObject jsonObj = new JSONObject();
	    Map<String, Object> paramap = new HashMap<String, Object>();
	    paramap.put("recipient", email);
    	paramap.put("subject", title);
    	paramap.put("content", content);
    	paramap.put("userid", userid);
    	
    	if(fileList != null && fileList.size()>0) {
    		paramap.put("path", path);
    		paramap.put("arr_attachFilename", arr_attachFilename);
    	}
    	
    	try {
    		GoogleMail mail = new GoogleMail();
    		mail.sendmail_withFile(paramap);
			jsonObj.put("result", 1);
		} catch (Exception e) {
			e.printStackTrace();
			jsonObj.put("result", 0);
		}
    	
    	if(arr_attachFilename != null) {
	         for(String attachFilename : arr_attachFilename) {
	            try {
	               fileManager.doFileDelete(attachFilename, path);
	            } catch (Exception e) {
	               e.printStackTrace();
	            }
	         } // end of for----------------------
	    }
		
    	return jsonObj.toString();
	}
	
	
	@GetMapping("/member/sendComplete.do")
	public ModelAndView sendComplete(ModelAndView mav) {
		
		mav.setViewName("member/sendComplete.tiles1");
		
		return mav;
	}
	
	
	
	@GetMapping("/member/myPage_etc.do")
	public ModelAndView myPage_etc(ModelAndView mav) {
		
		mav.setViewName("member/myPage_etc.tiles1");
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value="/community/wordSearch.do", produces="text/plain;charset=UTF-8")
	public String wordSearch(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		
		List<String> wordList = service.wordSearch(paramap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(wordList != null) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
			
				jsonObj.put("word", word);
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	
}

