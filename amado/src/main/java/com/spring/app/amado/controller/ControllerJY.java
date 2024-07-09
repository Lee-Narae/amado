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
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketVO;
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
		
		
		MultipartFile attach = clubvo.getAttach();
		
		if(attach != null) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면) 
			
			/*
			   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
			   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
			             우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
			             조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
			*/
			// WAS 의 webapp 의 절대경로를 알아와야 한다. 
			HttpSession session = mrequest.getSession(); 
			String root = session.getServletContext().getRealPath("/");  
			
			//System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);  
			//~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
			
			String path =root+"resources" +File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
            	운영체제가 Windows 이라면 File.separator 는  "\" 이고,
            	운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
            	
			 */
			
			/*
			 
			 #2 . 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			  
			 */
			String newFileName ="";
			//was(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			//첨부파일의 내용물을 담는것
			
			
			try {
				bytes= attach.getBytes();
				//첨부파일의 내용물을 읽어오는 것
				
				String originalFilename=attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				
			//   System.out.println("~~~ 확인용 originalFilename => " + originalFilename); 
	            // ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf 
				newFileName =fileManager.doFileUpload(bytes, originalFilename, path);
				//첨부되어진 파일을 업로드 하는 것 
				
				//System.out.println("~~~ 확인용 newFileName => " + newFileName); 
				
				/*
	             3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기  
	             
	         */
				
				clubvo.setWasfileName(newFileName);
				//was(톰캣)에 저장된 파일명(2024062712075997631067179400.jpg)
				clubvo.setClubimg(originalFilename);
				// 게시판 페이지에서 첨부된 파일(LG_싸이킹청소기_사용설명서.pdf)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				
			} catch (IOException e) {
			
				e.printStackTrace();
			}
			
		}
		
			
			System.out.println("1"+clubvo.getAttach());
			System.out.println("2"+clubvo.getCity());
			System.out.println("22"+clubvo.getFk_sportseq());
			System.out.println("4"+clubvo.getClubgym());
			System.out.println("5"+clubvo.getClubimg());
			
			System.out.println("6"+clubvo.getClubname());
			System.out.println("7"+clubvo.getClubpay());
			
			System.out.println("12"+clubvo.getClubtime());
			System.out.println("14"+clubvo.getLocal());
			System.out.println("17"+clubvo.getWasfileName());
			
			System.out.println(clubvo.getFk_userid());
			System.out.println(clubvo.getClubtel());
			System.out.println(clubvo.getClubgym());
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===	

		int n =0;
		
		if(!(attach.isEmpty())) {
			//파일첨부가 있는 경우라면
			n=service.add_withFile(clubvo);
		}
		
		if(n==1) {
			
			// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
			service.updateRank(clubvo.getFk_userid()); 
			mav.setViewName("club/findClub.tiles2");
		    //  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("error/add_error.tiles1");
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}

		return mav;
		
		
	}
	
	
	
	
	// ========== 플리마켓  ==========
	// 플리마켓 페이지 보요주기
	@RequestMapping(value="/club/fleamarket.do")
	public ModelAndView fleamarket(ModelAndView mav) {
		mav.setViewName("club/fleamarket.tiles2");
		//    /WEB-INF/views/club/viewclub.jsp
		return mav;
		
	}
	
	// 
	@ResponseBody
	@GetMapping(value="/sportname.do", produces="text/plain;charset=UTF-8")
	public String fleamarket(HttpServletRequest request) {
		
		String sportname = request.getParameter("sportname");
		System.out.println(sportname);
		
		// 상품 select 헤오기
		List<Map<String,String>> sportNameList = service.getSportNameList(sportname);
		//운동 종목시퀀스만 가져올 거니까 컬럼 한개
		
		/*
			List<Map<String,String>> sportList = service.getSportList(); 
			// 운동종목시퀀스, 운동종목이름  등등 컬럼 여러개 일때
			// Map<> 은 행이 한개 일때 
			 
		*/
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> productinfo : sportNameList) {
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("sportseq", productinfo.get("sportseq"));
			jsonObj.put("sportname", productinfo.get("sportname"));
			jsonObj.put("city", productinfo.get("city"));
			jsonObj.put("local", productinfo.get("local"));
			jsonObj.put("title", productinfo.get("title"));
			jsonObj.put("content", productinfo.get("content"));
			jsonObj.put("cost", productinfo.get("cost"));
			jsonObj.put("deal", productinfo.get("deal"));
			jsonObj.put("fk_userid", productinfo.get("fk_userid"));
			jsonObj.put("registerdate", productinfo.get("registerdate"));
			jsonObj.put("commentcount", productinfo.get("commentcount"));
			jsonObj.put("viewcount", productinfo.get("viewcount"));
			jsonObj.put("status", productinfo.get("status"));
			jsonObj.put("imgfilename", productinfo.get("imgfilename"));
			
			jsonArr.put(jsonObj);
		
		}	      
		
	   return jsonArr.toString();

		
	}





	

	
	
	
}
