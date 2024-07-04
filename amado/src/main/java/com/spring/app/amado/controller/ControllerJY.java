package com.spring.app.amado.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.FileManager;
import com.spring.app.domain.ClubVO;
import com.spring.app.service.AmadoService_JY;



@Controller
public class ControllerJY {
	// 지윤컨트롤러
	//dkdkkkk지윤이다
	
	
	//=== #175  파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
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
	// 동호회등록 폼페이지 요청
	@GetMapping("/club/clubRegister.do")
	public ModelAndView requiredLogin_clubRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
/*		
		동호회등록 종목 선택
		List<Map<String,String>> sportList = service.getSportList(); 
		mav.addObject("sportList", sportList);
*/
		
		// 동호회등록 지역 선택
		List<Map<String,String>> cityList = service.getCityList(); 
		mav.addObject("cityList", cityList);
		
		mav.setViewName("club/clubRegister.tiles2");
		//    /WEB-INF/views/club/clubRegister.jsp
		return mav;
	}	
	
	
	@ResponseBody
	@GetMapping(value="/club/getLocation.do", produces="text/plain;charset=UTF-8")
	public String getLocation(HttpServletRequest request) {
		String cityname = request.getParameter("cityname");
		
		List<String> localList = service.getLocalList(cityname);
		
		JSONObject jsonObj = new JSONObject(); // {}
		
		for(String localname : localList) {
			jsonObj.put("localname", localname);
		}	      
	   return jsonObj.toString();
	}
	
	
	// 동호회등록  완료 요청
	@PostMapping(value="/club/clubRegisterEnd.do" , produces="text/plain;charset=UTF-8")
	public ModelAndView clubRegisterEnd(Map<String, String> paraMap, ModelAndView mav, ClubVO clubvo, MultipartHttpServletRequest mrequest) throws Exception {
		
		//MultipartFile attach = clubvo.getAttach();
		
		System.out.println(clubvo.getAttach());
		System.out.println(clubvo.getCity());
		System.out.println(clubvo.getClass());
		System.out.println(clubvo.getClubgym());
		System.out.println(clubvo.getClubimg());
		System.out.println(clubvo.getClubname());
		System.out.println(clubvo.getClubpay());
		System.out.println(clubvo.getClubscore());
		System.out.println(clubvo.getClubseq());
		
		System.out.println(clubvo.getClubstatus());
		System.out.println(clubvo.getClubtel());
		System.out.println(clubvo.getClubtime());
		System.out.println(clubvo.getFk_sportseq());
		System.out.println(clubvo.getLocal());
		System.out.println(clubvo.getMembercount());
		System.out.println(clubvo.getRank());
		System.out.println(clubvo.getWasfileName());
		
	
		
		
		return mav;
		
		
	}
	
	


	
	
	

	
	
	
}
