package com.spring.app.amado.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import com.spring.app.common.MyUtil;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.NoticeVO;
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
	
	
	// 지역가져오기
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
	
	
	// 동일한 종목의 동호회 가입하는지 확인
	@ResponseBody
	@GetMapping("/club/checksportseq.do")
	public String checksportseq (HttpServletRequest request) { // userid, category가져옴
		
		String userid = request.getParameter("userid");
		String category = request.getParameter("category");
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("category", category);
		
		String checkseq = service.checkseq(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("checkseq", checkseq);
		
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
		
			/*
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
			*/
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===	

		int n =0, n1=0;
		
		if(!(attach.isEmpty())) {
			//파일첨부가 있는 경우라면
			n=service.add_withFile(clubvo);
			
		}
		
		if(n==1) {
			
			// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
			n1 = service.updateRank(clubvo.getFk_userid()); // update만 해줄거면 리턴없어도되는데 업뎃하고 밑에서 insert 해줘여하니까 n1 만드러줌.
		}
		if(n1==1) {
			
			service.insertCmemberTbl(clubvo); 
			mav.setViewName("redirect:/club/findClub.tiles2");  // 결과물 보여줘야하니까 "club/findClub.tiles2" 아님!!!
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
	public ModelAndView fleamarket(ModelAndView mav, HttpServletRequest request) {
		
		// 모든 상품 select 해오기
		List<FleamarketVO> allItemList = service.getAllItemList(); //where조건 없이 디비에서 데이터를 불러만오는 거라  map에 넣어서 보낼게 없음!!!!  //(); 괄호에 뭐가 들어갈땐 조건이 있어서 그 조건을 디비에보내서 결과물 가져올때임
		
		mav.addObject("allItemList", allItemList);
		// ----------------------------------
		
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if (searchType == null) {
			searchType = "";
		}
		if (searchWord == null) {
			searchWord = "";
		}

		if (searchWord != null) {
			searchWord = searchWord.trim();
			// " 연 습" ==> "연 습"
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		int cnt = 0; // 총 게시물 건수
		int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		
		// 상품 전체 개수 불러오기
		cnt = service.getItemCnt(paraMap);
		
		cnt = (int) Math.ceil((double) cnt / sizePerPage);
		
		if (str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}

		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if (currentShowPageNo < 1 || currentShowPageNo > cnt) {
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 음수를 입력하여 장난친 경우
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을
					// 입력하여 장난친 경우
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
				currentShowPageNo = 1;
			}
		}
		
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		paraMap.put("startRno", Integer.toString(startRno));
		paraMap.put("endRno", Integer.toString(endRno));
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		// 1. equals: 문자열비교 / 대소문자 구분을 하여 비교한다. 2. equalsIgnoreCase: 문자열비교 / 대소문자 구분을 하지
		// 않고 비교한다.
		if ("subject".equals(searchType) || "content".equals(searchType) || "subject_content".equals(searchType)
				|| "name".equals(searchType)) {
			mav.addObject("paraMap", paraMap);
		}
		
		// === #129. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
		 * 1 2 3 4 5 6 7 8 9 10 [다음][마지막] -- 1개블럭 [맨처음][이전] 11 12 13 14 15 16 17 18 19
		 * 20 [다음][마지막] -- 1개블럭 [맨처음][이전] 21 22 23
		 */
		
		int loop = 1;
		/*
		 * loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		 */
		
		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
		String pageBar = "<ul style='list-style:none;'>";
		String url = "list.action";
		
		// === [맨처음][이전] 만들기 === //
		if (pageNo != 1) {
			pageBar += "<li style='display:inline-block; width: 70px; font-size=12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=1'><<</a></li>";
			pageBar += "<li style='display:inline-block; width: 50px; font-size=12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + (pageNo - 1)
					+ "'><</a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {

			if (pageNo == currentShowPageNo) {
				// 페이징 번호를 누른 상태일 때는 어차피 같은 번호로 이동할 필요가 없기 때문에 (예를들어 3 을 눌렀을 때 다시 3을 누른다고 페이지
				// 이동을 할 필요는 없고 다른 페이지 번호를 누르면 이동하게 된다.)
				pageBar += "<li style='display:inline-block; width: 30px; font-size=12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"
						+ pageNo + "</li>";
			} else {
				pageBar += "<li style='display:inline-block; width: 30px; font-size=12pt;'><a href='" + url
						+ "?searchType=" + searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo
						+ "'>" + pageNo + "</a></li>";
			}

			loop++;
			pageNo++;
		} // end of while-------------------------
		
		// === [다음][마지막] 만들기 === //
		if (pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width: 50px; font-size=12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + pageNo + "'>></a></li>";
			pageBar += "<li style='display:inline-block; width: 70px; font-size=12pt;'><a href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentShowPageNo=" + totalPage + "'>>></a></li>";
		}
		
		pageBar += "</ul>";

		mav.addObject("pageBar", pageBar);
		
		String goBackURL = MyUtil.getCurrentURL(request);
		System.out.println("~~~ 확인용(list.action) goBackURL : " + goBackURL);
//		~~~ 확인용(list.action) goBackURL : /list.action
//		~~~ 확인용(list.action) goBackURL : /list.action?searchType=&searchWord=&currentShowPageNo=5
//		~~~ 확인용(list.action) goBackURL : /list.action?searchType=subject&searchWord=java
//		~~~ 확인용(list.action) goBackURL : /list.action?searchType=subject&searchWord=%EC%A0%95%ED%99%94&currentShowPageNo=3
//	 %EC%A0%95%ED%99%94 == 정화 (한글이라 변환된거임)
		
		
		///////////////////////////////////////////////////////////////
		
		mav.addObject("cnt", cnt); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
		mav.addObject("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
		mav.addObject("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
		
		///////////////////////////////////////////////////////////////

		mav.addObject("goBackURL", goBackURL);
		
		mav.setViewName("club/fleamarket.tiles2");
		return mav;
		
		
		
	}
	
	
	
	// 전체 상품 보여주기
	@ResponseBody
	@GetMapping(value="/allview.do")
	public String allview() {
		
		List<FleamarketVO> allItemList = service.getAllItemList();
		
		JSONArray jsonArr = new JSONArray();
		/*
		if(sportNameList != null) {
			for(Map<String, String> abc : sportNameList) {
				JSONObject jsonObj = new JSONObject();     // {} 
				jsonObj.put("no", vo.getNo());             // {"no":"101"} 
				jsonObj.put("name", vo.getName());         // {"no":"101", "name":"이순신"}
				jsonObj.put("writeday", vo.getWriteday()); // {"no":"101", "name":"이순신", "writeday":"2024-06-11 17:27:09"}
				
				jsonArr.put(jsonObj); // [{"no":"101", "name":"이순신", "writeday":"2024-06-11 17:27:09"}]
			}// end of for------------------------
		}
		*/
		
		for(FleamarketVO fvo : allItemList) {
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("fleamarketseq", fvo.getFleamarketseq());
			jsonObj.put("city", fvo.getCity());
			jsonObj.put("cost", fvo.getCost());
			jsonObj.put("imgfilename", fvo.getImgfilename());
			jsonObj.put("local", fvo.getLocal());
			jsonObj.put("title", fvo.getTitle());
			
			jsonArr.put(jsonObj);
			// System.out.println("aaa"+jsonArr);
			/* 	
			  	jsonArr => 
				[{"deal":"직거래","cost":"5000000","city":"경기도","imgfilename":"가평잣.png",
				  "sportseq":"3","title":"잣막걸리 공장을 물려드립니다","registerdate":"2024-07-10 14:18:38",
				  "local":"가평군","content":"떼돈 벌 수 있는 기회는 지금뿐!","commentcount":"0","viewcount":"0",
				  "fk_userid":"leejy","status":"0"}]
			*/
		
		}	      
		
	   return jsonArr.toString();
	}
	
	
	
	
	// 플리마켓 등록된 상품 카테고리별로 띄우기
	@ResponseBody
	@GetMapping(value="/sportname.do", produces="text/plain;charset=UTF-8")
	public String fleamarket(HttpServletRequest request) {
		
		String sportname = request.getParameter("sportname");//가져온 where절 디비에 보내기
		//System.out.println(sportname);
		
		// 카테고리 상품 select 해오기
		List<Map<String,String>> sportNameList = service.getSportNameList(sportname);
		//FleamarketVO????x
		
		/*
			List<Map<String,String>> sportList = service.getSportList(); 
			// 운동종목시퀀스, 운동종목이름  등등 컬럼 여러개 일때   // Map<> 은 행이 한개 일때 
			 
		*/
		
		
		JSONArray jsonArr = new JSONArray();
		/*
		if(sportNameList != null) {
			for(Map<String, String> abc : sportNameList) {
				JSONObject jsonObj = new JSONObject();     // {} 
				jsonObj.put("no", vo.getNo());             // {"no":"101"} 
				jsonObj.put("name", vo.getName());         // {"no":"101", "name":"이순신"}
				jsonObj.put("writeday", vo.getWriteday()); // {"no":"101", "name":"이순신", "writeday":"2024-06-11 17:27:09"}
				
				jsonArr.put(jsonObj); // [{"no":"101", "name":"이순신", "writeday":"2024-06-11 17:27:09"}]
			}// end of for------------------------
		}
		*/
		
		for(Map<String, String> productinfo : sportNameList) {
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("fleamarketseq", productinfo.get("fleamarketseq"));
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
			//System.out.println("aaa"+jsonArr);
			/* 	
			  	jsonArr => 
				[{"deal":"직거래","cost":"5000000","city":"경기도","imgfilename":"가평잣.png",
				  "sportseq":"3","title":"잣막걸리 공장을 물려드립니다","registerdate":"2024-07-10 14:18:38",
				  "local":"가평군","content":"떼돈 벌 수 있는 기회는 지금뿐!","commentcount":"0","viewcount":"0",
				  "fk_userid":"leejy","status":"0"}]
			*/
		
		}	      
		
	   return jsonArr.toString();
	}
	
	

	// 상품 상세보기
	@GetMapping(value="/club/prodView.do", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_prodView(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)  {
		
		mav.setViewName("club/sale.tiles2");
		//    /WEB-INF/views/club/viewclub.jsp
		return mav;
	}


	// 상품판매등록 페이지 불러오기
	@GetMapping(value="/club/itemRegister.do", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_registerItem(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)  {
		
		
		// 동호회등록 지역 선택
		List<Map<String,String>> cityList = service.getCityList(); 
		mav.addObject("cityList", cityList);
		
		mav.setViewName("club/itemRegister.tiles2");
		//    /WEB-INF/views/club/itemRegister.jsp
		
		return mav;
		
	}

	
	
	// === #188. 스마트에디터. 드래그앤드롭을 이용한 다중 사진 업로드 ===//
	@PostMapping("/image/multiplePhotoUpload.action") 
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		
	/*
        1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
        >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
             우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
     */
     
     // WAS 의 webapp 의 절대경로를 알아와야 한다.
     HttpSession session = request.getSession();
     String root = session.getServletContext().getRealPath("/");
     String path = root + "resources"+File.separator+"photo_upload";
     // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
     
    // System.out.println("~~~ 확인용 path => " + path);
   //  ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\photo_upload
	
     File dir = new File(path);
     if(!dir.exists()) {
    	 dir.mkdirs();
     }
     try {
         String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
         // 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
         
         /*
             [참고]
             HttpServletRequest의 getHeader() 메소드를 통해 클라이언트 사용자의 정보를 알아올 수 있다. 
   
            request.getHeader("referer");           // 접속 경로(이전 URL)
            request.getHeader("user-agent");        // 클라이언트 사용자의 시스템 정보
            request.getHeader("User-Agent");        // 클라이언트 브라우저 정보 
            request.getHeader("X-Forwarded-For");   // 클라이언트 ip 주소 
            request.getHeader("host");              // Host 네임  예: 로컬 환경일 경우 ==> localhost:9090    
         */
         
      //   System.out.println(">>> 확인용 filename ==> " + filename);
         // >>> 확인용 filename ==> berkelekle%EB%8B%A8%EA%B0%80%EB%9D%BC%ED%8F%AC%EC%9D%B8%ED%8A%B803.jpg 
         
         InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
         
         String newFilename = fileManager.doFileUpload(is, filename, path);
      
    
       // System.out.println(">>>> 확인용 width ==> " + width);
       // >>>> 확인용 width ==> 600
       // >>>> 확인용 width ==> 121
         
         String ctxPath = request.getContextPath(); //  /board
         
         String strURL = "";
         strURL += "&bNewLine=true&sFileName="+newFilename; 
         strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
         
         // === 웹브라우저 상에 사진 이미지를 쓰기 === //
         PrintWriter out = response.getWriter();
         out.print(strURL);
         
      } catch(Exception e) {
         e.printStackTrace();
      }
	
	
	}

	
	// 상품등록  완료 요청
	@PostMapping(value="/club/addEnd.do" , produces="text/plain;charset=UTF-8")
	public ModelAndView addEnd(Map<String, String> paraMap, ModelAndView mav, FleamarketVO fvo, MultipartHttpServletRequest mrequest) throws Exception {
		
		MultipartFile attach = fvo.getAttach();
		
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
			
			//System.out.println("root: "+root);
			//root: C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\amado\
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
				
				fvo.setWasfileName(newFileName);
				//was(톰캣)에 저장된 파일명(2024062712075997631067179400.jpg)
				fvo.setImgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(LG_싸이킹청소기_사용설명서.pdf)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				
			} catch (IOException e) {
			
				e.printStackTrace();
			}
			
		}
		
			/*
			System.out.println("1"+fvo.getAttach());
			System.out.println("2"+fvo.getImgfilename());
			System.out.println("3"+fvo.getSportseq());
			System.out.println("4"+fvo.getCity());
			System.out.println("5"+fvo.getLocal());
			
			System.out.println("6"+fvo.getCost());
			System.out.println("7"+fvo.getFk_userid());
			
			System.out.println("8"+fvo.getTitle());
			System.out.println("9"+fvo.getContent());
			System.out.println("10"+fvo.getPassword());
			System.out.println("10"+fvo.getDeal());
			*/
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===	

		int n =0;
		
		if(!(attach.isEmpty())) {
			//파일첨부가 있는 경우라면
			n=service.add_withFile(fvo);
			
		}
		
		mav.setViewName("redirect:/club/fleamarket.do"); //상품 등록이 완료되면 결과가 적용된 페이지로 가야하기때문에 redirect를 써줘여 함.
		//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.

			
		return mav;
		
	}

		
	
	
	// ========== 마이페이지 ==========
	// 마이페이지 뷰단
	@RequestMapping(value="/member/viewMypage.do")
	public ModelAndView requiredLogin_viewMypage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("member/viewMypage.tiles1");
		return mav;
		
	}


	// ========== 동호회 게시판 ==========
	// 동호회 게시판 뷰단
	@GetMapping(value="/club/clubBoard.do")
	public ModelAndView requiredLogin_clubBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String clubseq = request.getParameter("clubseq");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "10";
		
		//System.out.println("userid"+fk_userid);
		System.out.println("clubseq"+clubseq);
		
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
		paramap.put("clubseq", clubseq);
		
		int totalPage = service.getTotalPage(paramap);
		
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
		   
           pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq"+clubseq+"searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";

           if(pageNo != 1) {
              pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq"+clubseq+"searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
           }
   
           while(!(loop > blockSize || pageNo > totalPage)) {
              
              
              if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
                 pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
              }
              else {
                 pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq"+clubseq+"searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
              }
              
              loop++;
              
              pageNo++;
              
           }// end of while(!( )) {}------------------- 
           
           // *** [다음][마지막] 만들기 *** //
           // pageNo ==> 11
           if(pageNo <= totalPage) {
              pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq"+clubseq+"searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
           }
           pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq"+clubseq+"searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[맨마지막]</a></li>";
           
           
         // *** ==== 페이지바 만들기 끝 ==== *** //
		
           
           
        
           
        // *** ====== 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ======= *** //
        
        String currentURL = MyUtil.getCurrentURL(request);
        // 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
        
        // System.out.println(currentURL);
        // /member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15

		List<ClubBoardVO> clubboardList = service.select_clubboard_paging(paramap);
		
		mav.addObject("clubboardList", clubboardList);
		
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
		int totalCount = service.getTotalCount(paramap);
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("currentShowPageNo", currentShowPageNo);

		
		mav.setViewName("club/clubBoard.tiles2");
		return mav;
	}

	
	// 게시글 자세히보기
	@PostMapping("/club/clubboardDetail.do")
	public ModelAndView noticeDetail(ModelAndView mav, HttpServletRequest request) {
		
		String clubboardseq = request.getParameter("clubboardseq");
		String goBackURL = request.getParameter("goBackURL");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("clubboardseq", clubboardseq);
		paramap.put("goBackURL", goBackURL);
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		
		// 댓글
		//List<Map<String,String>> commentList = service.getNoticeComment(clubboardseq);
		
		// 댓글 수
		//String commentCount = service.getNoticeCommentCount(clubboardseq);
		/*
		if(commentList.size() > 0) {
			mav.addObject("commentList", commentList);
			mav.addObject("commentCount", commentCount);
		}
		*/
		
		
		// 게시글
		ClubBoardVO notice = service.getClubboardDetail(paramap);
		
		if(notice == null) {
			String message = "존재하지 않는 게시글입니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		// 조회수 (로그인 여부 상관 없이, 중복 상관 없이 무조건 1 증가)
		service.updateCboardViewcount(clubboardseq);
		
		
		mav.addObject("notice", notice);
		mav.addObject("clubboardseq", clubboardseq);
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		
		mav.setViewName("community/noticeDetail.tiles2");
		return mav;
	}

	
	
	
	
	
}
