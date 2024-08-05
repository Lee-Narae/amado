package com.spring.app.amado.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.spring.app.domain.Calendar_schedule_VO;
import com.spring.app.domain.Calendar_small_category_VO;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
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
	public ModelAndView viewclub(HttpServletRequest request,ModelAndView mav) {
		
		
		// 종목별로 가입요청이 가장 많은 동호회 이름 가져오기 
		Map<String,String> soccerNameSeq = service.getMostclubNameSeq(1);
		Map<String,String> baseballNameSeq = service.getMostclubNameSeq(2);
		Map<String,String> vollyballNameSeq = service.getMostclubNameSeq(3);
		Map<String,String> basketballNameSeq = service.getMostclubNameSeq(4);
		Map<String,String> footballNameSeq = service.getMostclubNameSeq(5);
		Map<String,String> tenisNameSeq = service.getMostclubNameSeq(6);
		Map<String,String> vowlingNameSeq = service.getMostclubNameSeq(7);
		Map<String,String> badmintonNameSeq = service.getMostclubNameSeq(8);
		/*String soccerName = service.getMostclubName(1);
		String baseballName = service.getMostclubName(2);
		String vollyballName = service.getMostclubName(3);
		String basketballName = service.getMostclubName(4);
		String footballName = service.getMostclubName(5);
		String tenisName = service.getMostclubName(6);
		String vowlingName = service.getMostclubName(7);
		String badmintonName = service.getMostclubName(8);
		*/
		//System.out.println(soccerNameSeq.get("clubseq")+soccerNameSeq.get("clubname"));
		//3최준혁과 친구들
		
		mav.addObject("soccerNameSeq", soccerNameSeq);
		mav.addObject("baseballNameSeq", baseballNameSeq);
		mav.addObject("vollyballNameSeq", vollyballNameSeq);
		mav.addObject("basketballNameSeq", basketballNameSeq);
		mav.addObject("footballNameSeq", footballNameSeq);
		mav.addObject("tenisNameSeq", tenisNameSeq);
		mav.addObject("vowlingNameSeq", vowlingNameSeq);
		mav.addObject("badmintonNameSeq", badmintonNameSeq);
		/*
		mav.addObject("soccerName", soccerName);
		mav.addObject("baseballName", baseballName);
		mav.addObject("vollyballName", vollyballName);
		mav.addObject("basketballName", basketballName);
		mav.addObject("footballName", footballName);
		mav.addObject("tenisName", tenisName);
		mav.addObject("vowlingName", vowlingName);
		mav.addObject("badmintonName", badmintonName);
		*/
		//    /WEB-INF/views/club/viewclub.jsp
		mav.setViewName("club/viewclub.tiles2");
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

		int n =0, n1=0, n2=0;
		
		if(!(attach.isEmpty())) {
			
			// 새로 생길 동호회의 clubseq 채번
			String clubseq = service.getNewClubseq();
			
			
			clubvo.setClubseq(clubseq);
			//파일첨부가 있는 경우라면
			n=service.add_withFile(clubvo);
			
		}
		
		if(n==1) {
			
			// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
			n1 = service.updateRank(clubvo.getFk_userid()); // update만 해줄거면 리턴없어도되는데 업뎃하고 밑에서 insert 해줘여하니까 n1 만드러줌.
		}
		if(n1==1) {
			
			n2 = service.insertCmemberTbl(clubvo); 
		}
		
		if(n2==1) {
			//System.out.println("23223"+clubvo.getFk_userid());
			service.insertCalcname(clubvo); 
			mav.setViewName("redirect:/club/findClub.do?sportseq="+clubvo.getFk_sportseq());  // 결과물 보여줘야하니까 "club/findClub.tiles2" 아님!!!
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
		String url = "list.do";
		
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
		//System.out.println("~~~ 확인용(list.do) goBackURL : " + goBackURL);
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
	@PostMapping("/image/multiplePhotoUpload") 
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
	// 동호회게시판 글 작성하기 뷰단
	@GetMapping(value="/club/addClubBoard.do")
	public ModelAndView requiredLogin_addClubBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String clubseq = request.getParameter("clubseq");
		//System.out.println("글쓰기뷰단"+clubseq);
		
		mav.addObject("clubseq", clubseq);
		mav.setViewName("club/addClubBoard.tiles2");
		return mav;
		
	}
	
	@PostMapping("/club/addClubBoard.do")
	public ModelAndView editClubBoard(HttpServletRequest request, ModelAndView mav) {
		
		String clubboardseq = request.getParameter("clubboardseq");
		
		ClubBoardVO editCBoard = service.editCBoard_get(clubboardseq);
		
		if(editCBoard != null) {
			mav.addObject("editCBoard", editCBoard);
		}
		mav.setViewName("club/editClubBoard.tiles2");
		return mav;
	}
	
	
	
	// 글쓰기 완료
	@PostMapping(value="/club/addEndClubBoard.do" , produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_addEndClubBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, Map<String, String> paraMap, ClubBoardVO cvo, MultipartHttpServletRequest mrequest) throws Exception {
		
		MultipartFile attach = cvo.getAttach();
		
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
				
				cvo.setFilename(newFileName);
				//was(톰캣)에 저장된 파일명(2024062712075997631067179400.jpg)
				cvo.setOrgfilename(originalFilename);
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

		String clubseq = request.getParameter("clubseq");
		//System.out.println("글쓰기완료"+clubseq);
		
		
		paraMap.put("clubboardseq", cvo.getClubboardseq());
		paraMap.put("title", cvo.getTitle());
		paraMap.put("content", cvo.getContent());
		paraMap.put("fk_userid", cvo.getFk_userid());
		paraMap.put("registerdate", cvo.getRegisterdate());
		paraMap.put("password", cvo.getPassword());
		paraMap.put("commentcount", cvo.getCommentcount());
		paraMap.put("viewcount", cvo.getViewcount());
		paraMap.put("status", cvo.getStatus());
		paraMap.put("orgfilename", cvo.getOrgfilename());
		paraMap.put("filename", cvo.getFilename());
		paraMap.put("wasfileName", cvo.getWasfileName());
		//paraMap.put("filesize", cvo.getFilesize());
		paraMap.put("clubseq", clubseq); //cvo에서 가져온값 x
		
		System.out.println("파일"    + cvo.getWasfileName() +  cvo.getFilename());
		// 파일   null   court.png   null
		
		int n =0;
		
		
		if(attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			n = service.add(paraMap); // <== 파일첨부가 없는 글쓰기 
		}
		else{
			//파일첨부가 있는 경우라면
			n=service.add_withFile2(paraMap);
			
		}
		
		
		if(n==1) {
			mav.setViewName("redirect:/club/clubBoard.do"); //상품 등록이 완료되면 결과가 적용된 페이지로 가야하기때문에 redirect를 써줘여 함.
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}
		else {
			mav.setViewName("error/add_error.tiles1");
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}
			
		return mav;
		
	}

	
	
	
	
	// 동호회 게시판 뷰단
	@GetMapping(value="/club/clubBoard.do")
	public ModelAndView requiredLogin_clubBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String sportname = request.getParameter("sportname");
		String clubseq = request.getParameter("clubseq");
		String clubname = request.getParameter("clubname");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "10";
		
		//System.out.println("userid"+fk_userid);
		//System.out.println("clubseq"+clubseq);
		//System.out.println("clubname"+clubname);
		//System.out.println("sportname"+sportname);
		
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
		paramap.put("clubname", clubname);
		paramap.put("sportname", sportname);
		
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
		   
           pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq="+clubseq+"&sportname="+sportname+"&clubname="+clubname+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";

           if(pageNo != 1) {
              pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq="+clubseq+"&sportname="+sportname+"&clubname="+clubname+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
           }
   
           while(!(loop > blockSize || pageNo > totalPage)) {
              
              
              if(pageNo ==  Integer.parseInt(currentShowPageNo)) {
                 pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
              }
              else {
                 pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq="+clubseq+"&sportname="+sportname+"&clubname="+clubname+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
              }
              
              loop++;
              
              pageNo++;
              
           }// end of while(!( )) {}------------------- 
           
           // *** [다음][마지막] 만들기 *** //
           // pageNo ==> 11
           if(pageNo <= totalPage) {
              pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq="+clubseq+"&sportname="+sportname+"&clubname="+clubname+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
           }
           pageBar += "<li class='page-item'><a class='page-link' href='clubBoard.do?clubseq="+clubseq+"&sportname="+sportname+"&clubname="+clubname+"&searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[맨마지막]</a></li>";
           
           
         // *** ==== 페이지바 만들기 끝 ==== *** ////
		
           
           
        
           
        // *** ====== 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ======= *** //
        
        String currentURL = MyUtil.getCurrentURL(request);
        // 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
        
        // System.out.println(currentURL);
        // /member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15

		List<ClubBoardVO> clubboardList = service.select_clubboard_paging(paramap);
		/*
		for(ClubBoardVO board : clubboardList) {
			System.out.println("viewcount: "+board.getViewcount());
		}
		*/
		
		mav.addObject("clubboardList", clubboardList);
		
		if(searchType != null && ("title".equals(searchType) ||"content".equals(searchType))) {
			mav.addObject("searchType", searchType);
		}
		
		if(searchWord != null && !searchWord.trim().isEmpty()) {
			mav.addObject("searchWord", searchWord);
		}
		
		mav.addObject("sportname", sportname);
		mav.addObject("clubname", clubname);
		mav.addObject("clubseq", clubseq);
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
	public ModelAndView clubboardDetail(ModelAndView mav, HttpServletRequest request) {
		
		String clubseq = request.getParameter("clubseq");
		String clubboardseq = request.getParameter("clubboardseq");
		String goBackURL = request.getParameter("goBackURL");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		//System.out.println(clubboardseq +goBackURL +searchType +searchWord);
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("clubboardseq", clubboardseq);
		paramap.put("goBackURL", goBackURL);
		paramap.put("searchType", searchType);
		paramap.put("searchWord", searchWord);
		paramap.put("clubseq", clubseq);
		
		// 댓글
		List<Map<String,String>> commentList = service.getCBoardComment(clubboardseq);
		
		// 댓글 수
		String commentCount = service.getCBoardCommentCount(clubboardseq);
		
		if(commentList.size() > 0) {
			mav.addObject("commentList", commentList);
			mav.addObject("commentCount", commentCount);
		}
		
		
		
		// 게시글
		ClubBoardVO cboard = service.getClubboardDetail(paramap);
		//System.out.println(cboard.getFk_userid());
		
		if(cboard == null) {
			String message = "존재하지 않는 게시글입니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		// 조회수 (로그인 여부 상관 없이, 중복 상관 없이 무조건 1 증가)
		service.updateCboardViewcount(clubboardseq);
		
		
		mav.addObject("clubseq", clubseq);
		mav.addObject("cboard", cboard);
		mav.addObject("clubboardseq", clubboardseq);
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		
		mav.setViewName("club/clubboardDetail.tiles2");
		return mav;
	}
	
	
	
	@GetMapping("/club/clubboardAttachDownload.do")
	public void noticeAttachDownload(HttpServletRequest request, HttpServletResponse response) {
		
		String clubboardseq = request.getParameter("clubboardseq");
	
		// 파일관련 이름 알아오기
		Map<String, String> filenameMap = service.getOrgfilename(clubboardseq);
		
		String filename = filenameMap.get("filename");
		String orgfilename = filenameMap.get("orgfilename");
		
		HttpSession session = request.getSession(); 
        String root = session.getServletContext().getRealPath("/");
        String path = root+"resources"+File.separator+"files";
		
        fileManager.doFileDownload(filename, orgfilename, path, response);
		
	}

	
	
	
	// 글삭하기
	@PostMapping("/club/deleteCBoard.do")
	public ModelAndView deleteNotice(HttpServletRequest request, ModelAndView mav) {
	
		String clubboardseq = request.getParameter("clubboardseq");
		
		int n = service.deleteCBoard(clubboardseq);
		
		if(n == 1) {
			
			String message = "공지사항이 삭제되었습니다.";
			String loc = "clubBoard.do";
			
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
	
	
	
	
	
	

	
	// 동호회게시판 댓글 달기
	@ResponseBody
	@PostMapping(value="/club/regComment.do", produces="text/plain;charset=UTF-8")
	public String requiredLogin_regComment(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String comment_text = request.getParameter("comment_text");
		String clubboardseq = request.getParameter("clubboardseq");
		
		System.out.println("clubboardseq = "+ clubboardseq);
		
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("comment_text", comment_text);
		paramap.put("clubboardseq", clubboardseq);
		paramap.put("fk_userid", loginuser.getUserid());
		
		int n = service.insertCBoardComment(paramap);
		
		JSONArray jsonArr = new JSONArray();

		if(n == 1) {
			
			// tbl_notice commentcount 컬럼 1 올리기
			service.updateCBoardCommentcount(clubboardseq);
			
			List<Map<String,String>> commentList = service.getCBoardComment(clubboardseq);
			
			for(Map<String,String> commentmap : commentList) {
				JSONObject jsonObj = new JSONObject();
				   
				jsonObj.put("clubboardcommentseq", commentmap.get("clubboardcommentseq"));
				jsonObj.put("clubboardseq", commentmap.get("clubboardseq"));
				jsonObj.put("comment_text", commentmap.get("comment_text"));
				jsonObj.put("registerdate", commentmap.get("registerdate"));
				jsonObj.put("fk_userid", commentmap.get("fk_userid"));
				jsonObj.put("memberimg", commentmap.get("memberimg"));
				
				jsonArr.put(jsonObj);
			}
			
		}
		
		
		return jsonArr.toString();
	}

	
	
	// 동호회게시판 - 댓삭
	@ResponseBody
	@PostMapping(value="/club/delCBoardComment.do", produces="text/plain;charset=UTF-8")
	public String delNoticeComment(HttpServletRequest request) {
		
		String clubboardcommentseq = request.getParameter("clubboardcommentseq");
		String clubboardseq = request.getParameter("clubboardseq");
		
		System.out.println("clubboardcommentseq = " + clubboardcommentseq);
		System.out.println("clubboardseq = " + clubboardseq);
		
		int n = service.delCBoardComment(clubboardcommentseq);
		
		service.updateCBoardCommentcount_del(clubboardseq);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 댓 수정
	@ResponseBody
	@PostMapping(value="/club/editCBoardComment.do", produces="text/plain;charset=UTF-8")
	public String editCBoardComment(HttpServletRequest request) {
		
		String comment_text = request.getParameter("edit_comment_text");
		String clubboardcommentseq = request.getParameter("commentseq");
		
		Map<String, String> paramap = new HashMap<String, String>();
		
		paramap.put("comment_text", comment_text);
		paramap.put("clubboardcommentseq", clubboardcommentseq);
		
		int n = service.editCBoardComment(paramap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	
	
	
	
	//댓글 불러오기
	@ResponseBody
	@GetMapping(value="/club/viewCommentOnly.do", produces="text/plain;charset=UTF-8")
	public String viewCommentOnly(HttpServletRequest request) {
		String clubboardseq = request.getParameter("clubboardseq");
		
		List<Map<String,String>> commentList = service.getCBoardComment(clubboardseq);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> commentmap : commentList) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("clubboardcommentseq", commentmap.get("clubboardcommentseq"));
			jsonObj.put("clubboardseq", commentmap.get("clubboardseq"));
			jsonObj.put("comment_text", commentmap.get("comment_text"));
			jsonObj.put("registerdate", commentmap.get("registerdate"));
			jsonObj.put("fk_userid", commentmap.get("fk_userid"));
			jsonObj.put("memberimg", commentmap.get("memberimg"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}

	
	
	
	
	
	
	// ========== 캘린더 ==========
	@GetMapping(value="/schedule/scheduleManagement.do")
	public ModelAndView requiredLogin_scheduleManagement(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("schedule/scheduleManagement.tiles2");
		return mav;
	}
	
	
	
	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@ResponseBody
	@RequestMapping(value="/schedule/selectSchedule.do", produces="text/plain;charset=UTF-8")
	public String selectSchedule(HttpServletRequest request) {
		
		// 등록된 일정 가져오기
		
		String fk_userid = request.getParameter("fk_userid");
				
		List<Calendar_schedule_VO> scheduleList = service.selectSchedule(fk_userid);
		
		JSONArray jsArr = new JSONArray();
		
		if(scheduleList != null && scheduleList.size() > 0) {
			
			for(Calendar_schedule_VO svo : scheduleList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("subject", svo.getSubject());
				jsObj.put("startdate", svo.getStartdate());
				jsObj.put("enddate", svo.getEnddate());
				jsObj.put("color", svo.getColor());
				jsObj.put("scheduleno", svo.getScheduleno());
				jsObj.put("fk_lgcatgono", svo.getFk_lgcatgono());
				jsObj.put("fk_smcatgono", svo.getFk_smcatgono());
				jsObj.put("fk_userid", svo.getFk_userid());
				jsObj.put("joinuser", svo.getJoinuser());
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
	}

	
	
	
	// 동호회캘린더에 소분류 추가하기
	@ResponseBody
	@PostMapping("/schedule/addComCalendar.do")
	public String addComCalendar(HttpServletRequest request) throws Throwable {
		
		String com_smcatgoname = request.getParameter("com_smcatgoname");
		String fk_userid = request.getParameter("fk_userid");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("com_smcatgoname",com_smcatgoname);
		paraMap.put("fk_userid",fk_userid);
		
		int n = service.addComCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}

	
	// 동호회캘린더에서 소분류  보여주기
	@ResponseBody
	@GetMapping(value="/schedule/showCompanyCalendar.do", produces="text/plain;charset=UTF-8")  
	public String showCompanyCalendar(HttpServletRequest request) {
		
		String fk_userid = request.getParameter("fk_userid");
		System.out.println(fk_userid);
		//List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showCompanyCalendar();
		
		
		// 내가 속한 동호회 리스트 보여주기
		List<Map<String,String>> myclubList = service.getMyclubList(fk_userid);
		
		JSONArray jsonArr = new JSONArray();
		
		if(myclubList != null) {
			for(Map<String, String> map : myclubList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", map.get("smcatgono"));
				jsObj.put("smcatgoname", map.get("smcatgoname"));
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	// (동호회캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기
	@ResponseBody
	@PostMapping("/schedule/editCalendar.do")
	public String editComCalendar(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
		String smcatgoname = request.getParameter("smcatgoname");
		String userid = request.getParameter("userid");
		String caltype = request.getParameter("caltype");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("smcatgono", smcatgono);
		paraMap.put("smcatgoname", smcatgoname);
		paraMap.put("userid", userid);
		paraMap.put("caltype", caltype);
		
		int n = service.editCalendar(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}

	
	// 내 캘린더에 내캘린더 소분류 추가하기
	@ResponseBody
	@PostMapping("/schedule/addMyCalendar.do")
	public String addMyCalendar(HttpServletRequest request) throws Throwable {
		
		String my_smcatgoname = request.getParameter("my_smcatgoname");
		String fk_userid = request.getParameter("fk_userid");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("my_smcatgoname",my_smcatgoname);
		paraMap.put("fk_userid",fk_userid);
		
		int n = service.addMyCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}

	
	
	// 내 캘린더에서 내캘린더 소분류  보여주기 
	@ResponseBody
	@GetMapping(value="/schedule/showMyCalendar.do", produces="text/plain;charset=UTF-8") 
	public String showMyCalendar(HttpServletRequest request) {
		
		String fk_userid = request.getParameter("fk_userid");
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showMyCalendar(fk_userid);
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}

	
	
	// (동호회캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기 	
	@ResponseBody
	@PostMapping("/schedule/deleteSubCalendar.do")
	public String deleteSubCalendar(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
				
		int n = service.deleteSubCalendar(smcatgono);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}

	
	
	// 검색 
	@GetMapping("/schedule/searchSchedule.do")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		List<Map<String,String>> scheduleList = null;
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String fk_userid = request.getParameter("fk_userid");  // 로그인한 사용자id
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
	
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		
		if(searchType==null || (!"subject".equals(searchType) && !"content".equals(searchType)  && !"joinuser".equals(searchType))) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
			
		if(str_sizePerPage == null || "".equals(str_sizePerPage) || 
		   !("10".equals(str_sizePerPage) || "15".equals(str_sizePerPage) || "20".equals(str_sizePerPage))) {
				str_sizePerPage ="10";
		}
		
		if(fk_lgcatgono == null ) {
			fk_lgcatgono="";
		}
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("str_sizePerPage", str_sizePerPage);

		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		
		int s_totalCount=0;          // 총 게시물 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = Integer.parseInt(str_sizePerPage);  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 일정 검색 건수(totalCount)
	    s_totalCount = service.getS_totalCount(paraMap);
	//  System.out.println("~~~ 확인용 총 일정 검색 건수 totalCount : " + totalCount);
      
	    s_totalCount = (int)Math.ceil((double)s_totalCount/sizePerPage); 

		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > s_totalCount) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo=1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	      
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    	   
	    scheduleList = service.scheduleListSearchWithPaging(paraMap);
	    // 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
		
		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		// === 페이지바 만들기 === //
		int blockSize= 5;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
		String pageBar = "<ul style='list-style:none;'>";
		
		String url = "searchSchedule.do";
		
		// === [맨처음][이전] 만들기 ===
		if(pageNo!=1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while(!(loop>blockSize || pageNo>totalPage)) {
			
			if(pageNo==currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}// end of while--------------------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>";
		
		mav.addObject("pageBar",pageBar);
		
		String listgobackURL_schedule = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~ 확인용 검색 listgobackURL_schedule : " + listgobackURL_schedule);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.addObject("scheduleList", scheduleList);
		mav.setViewName("schedule/searchSchedule.tiles2");

		return mav;
	}

	
	// 일정상세보기
	@RequestMapping(value="/schedule/detailSchedule.do")
	public ModelAndView detailSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno = request.getParameter("scheduleno");
		
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);

		
		// 일정상세보기에서 일정수정하기로 넘어갔을 때 필요함
		String gobackURL_detailSchedule = MyUtil.getCurrentURL(request);
		mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
		
		try {
			Integer.parseInt(scheduleno);
			Map<String,String> map = service.detailSchedule(scheduleno);
			mav.addObject("map", map);
			mav.setViewName("schedule/detailSchedule.tiles2");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.do");
		}
		
		return mav;
	}

	
	// === 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다) ===
	@PostMapping("/schedule/insertSchedule.do")
	public ModelAndView insertSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		// form 에서 받아온 날짜
		String chooseDate = request.getParameter("chooseDate");
		
		mav.addObject("chooseDate", chooseDate);
		mav.setViewName("schedule/insertSchedule.tiles2");
		
		return mav;
	}

	
	// === 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 ===
	@ResponseBody
	@GetMapping(value="/schedule/selectSmallCategory.do", produces="text/plain;charset=UTF-8") 
	public String selectSmallCategory(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono"); // 캘린더 대분류 번호
		String fk_userid = request.getParameter("fk_userid");       // 사용자아이디
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("fk_userid", fk_userid);
		
		List<Calendar_small_category_VO> small_category_VOList = service.selectSmallCategory(paraMap);
		
		JSONArray jsArr = new JSONArray();
		if(small_category_VOList != null) {
			for(Calendar_small_category_VO scvo : small_category_VOList) {
				
				System.out.println("smcatgono: "+scvo.getSmcatgono());
				System.out.println("smcatgoname: "+scvo.getSmcatgoname());
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", scvo.getSmcatgono());
				jsObj.put("smcatgoname", scvo.getSmcatgoname());
				
				jsArr.put(jsObj);
			}
		}
		return jsArr.toString();
	}
	
	
	// === 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/insertSchedule/searchJoinUserList.do", produces="text/plain;charset=UTF-8")
	public String searchJoinUserList(HttpServletRequest request) {
		
		String joinUserName = request.getParameter("joinUserName");
		
		// 사원 명단 불러오기
		List<MemberVO> joinUserList = service.searchJoinUserList(joinUserName);

		JSONArray jsonArr = new JSONArray();
		if(joinUserList != null && joinUserList.size() > 0) {
			for(MemberVO mvo : joinUserList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("userid", mvo.getUserid());
				jsObj.put("name", mvo.getName());
				
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
		
	}

	
	
	// === 일정 등록하기 ===
	@PostMapping("/schedule/registerSchedule_end.do")
	public ModelAndView registerSchedule_end(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String startdate= request.getParameter("startdate");
   	//  System.out.println("확인용 startdate => " + startdate);
	//  확인용 startdate => 20231129140000
   	    
		String enddate = request.getParameter("enddate");
		String subject = request.getParameter("subject");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_smcatgono = request.getParameter("fk_smcatgono");
		String color = request.getParameter("color");
		String place = request.getParameter("place");
		String joinuser = request.getParameter("joinuser");
		
     //	System.out.println("확인용 joinuser => " + joinuser);
	 // 확인용 joinUser_es =>
	 // 또는 
	 // 확인용 joinUser_es => 이순신(leess),아이유1(iyou1),설현(seolh) 	
		
		String content = request.getParameter("content");
		String fk_userid = request.getParameter("fk_userid");
		
		System.out.println("fk_smcatgono: "+fk_smcatgono);
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("subject", subject);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_smcatgono", fk_smcatgono);
		paraMap.put("color", color);
		paraMap.put("place", place);
		
		paraMap.put("joinuser", joinuser);
		
		paraMap.put("content", content);
		paraMap.put("fk_userid", fk_userid);
		
		int n = service.registerSchedule_end(paraMap);

		if(n == 0) {
			mav.addObject("message", "일정 등록에 실패하였습니다.");
		}
		else {
			mav.addObject("message", "일정 등록에 성공하였습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/schedule/scheduleManagement.do");
		
		mav.setViewName("msg");
		
		return mav;
	}

	
	// === 일정삭제하기 ===
	@ResponseBody
	@PostMapping("/schedule/deleteSchedule.do")
	public String deleteSchedule(HttpServletRequest request) throws Throwable {
		
		String scheduleno = request.getParameter("scheduleno");
				
		int n = service.deleteSchedule(scheduleno);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}

	
	// === 일정 수정하기 ===
	@PostMapping("/schedule/editSchedule.do")
	public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno= request.getParameter("scheduleno");
   		
		try {
			Integer.parseInt(scheduleno);
			
			String gobackURL_detailSchedule = request.getParameter("gobackURL_detailSchedule");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.detailSchedule(scheduleno);
			
			if( !loginuser.getUserid().equals( map.get("FK_USERID") ) ) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
				
				mav.setViewName("schedule/editSchedule.tiles2");
			}
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.do");
		}
		
		return mav;
		
	}

	
	// === 일정 수정 완료하기 ===
	@PostMapping("/schedule/editSchedule_end.do")
	public ModelAndView editSchedule_end(Calendar_schedule_VO svo, HttpServletRequest request, ModelAndView mav) {
		
		try {
			 int n = service.editSchedule_end(svo);
			 
			 if(n==1) {
				 mav.addObject("message", "일정을 수정하였습니다.");
				 mav.addObject("loc", request.getContextPath()+"/schedule/scheduleManagement.do");
			 }
			 else {
				 mav.addObject("message", "일정 수정에 실패하였습니다.");
				 mav.addObject("loc", "javascript:history.back()");
			 }
			 
			 mav.setViewName("msg");
		} catch (Throwable e) {	
			e.printStackTrace();
			mav.setViewName("redirect:/schedule/scheduleManagement.do");
		}
			
		return mav;
	}

	
	// 대관관리
	@GetMapping(value="/admin/manage/gym")
	public ModelAndView adminLogin_gym (HttpServletRequest request, HttpServletResponse response,ModelAndView mav) {
		
		// 체육관 이름, 주소 가져오기
		List<GymVO> gymList = service.getGymList();
		
		mav.addObject("gymList", gymList);
		mav.setViewName("manage/gym.tiles3");
		
		return mav;
		
	}
	
	// 체육관 예약갯수 가져오기
	@ResponseBody
	@GetMapping(value="/admin/manage/gym.do", produces="text/plain;charset=UTF-8")
	public String getGymBarchart(HttpServletRequest request) {
		
		String gymname = request.getParameter("gymname");
		
		
		List<Map<String, String>> mapList = service.getGymBarchart(gymname);
		
		
		
		JSONArray jsonArr = new JSONArray();
		
		if(mapList != null) {
			for(Map<String, String> map : mapList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("time", map.get("time"));
				jsonObj.put("gymname", map.get("gymname"));
				jsonObj.put("reservation_count", map.get("reservation_count"));
				
				jsonArr.put(jsonObj);
			}// end of for----------------------
		}
		
		
		
		return jsonArr.toString();
 		
	}
	
	
	
	@PostMapping("/club/editClubBoard.do")
	public ModelAndView editCBoardeEnd(ClubBoardVO cvo, ModelAndView mav, HttpServletRequest request) {

		int n = service.edit(cvo);
		
		if(n==1) {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/clubboard.do?seq="+cvo.getClubboardseq());
			mav.setViewName("msg");
		}
		
		return mav;
	}


	
	// 기상청 공공데이터(오픈데이터)를 가져와서 날씨정보 보여주기  //
		@GetMapping("weatherXML.action")
		public String weatherXML() {
			return "weather/weatherXML";
			//  /board/src/main/webapp/WEB-INF/views/weather/weatherXML.jsp 파일을 생성한다.  
		}
		
		
	//  기상청 공공데이터(오픈데이터)를 가져와서 날씨정보 차트그리기 //
	@ResponseBody
	@PostMapping(value="weatherXMLtoJSON.action", produces="text/plain;charset=UTF-8") 
	public String weatherXMLtoJSON(HttpServletRequest request) {
		
		String str_jsonObjArr = request.getParameter("str_jsonObjArr");
		
	//	System.out.println(str_jsonObjArr);
		// [{"locationName":"속초","ta":"29.4"},{"locationName":"북춘천","ta":"26.2"},{"locationName":"철원","ta":"25.4"},{"locationName":"동두천","ta":"25.6"},{"locationName":"파주","ta":"24.8"},{"locationName":"대관령","ta":"23.3"},{"locationName":"춘천","ta":"26.1"},{"locationName":"백령도","ta":"24.6"},{"locationName":"북강릉","ta":"30.2"},{"locationName":"강릉","ta":"30.7"},{"locationName":"동해","ta":"29.2"},{"locationName":"서울","ta":"26.5"},{"locationName":"인천","ta":"25.6"},{"locationName":"원주","ta":"29.1"},{"locationName":"울릉도","ta":"29.1"},{"locationName":"수원","ta":"27.4"},{"locationName":"영월","ta":"27.9"},{"locationName":"충주","ta":"29.5"},{"locationName":"서산","ta":"27.0"},{"locationName":"울진","ta":"30.7"},{"locationName":"청주","ta":"29.9"},{"locationName":"대전","ta":"28.8"},{"locationName":"추풍령","ta":"28.1"},{"locationName":"안동","ta":"29.3"},{"locationName":"상주","ta":"29.6"},{"locationName":"포항","ta":"31.0"},{"locationName":"군산","ta":"29.6"},{"locationName":"대구","ta":"30.6"},{"locationName":"전주","ta":"30.0"},{"locationName":"울산","ta":"30.3"},{"locationName":"창원","ta":"30.1"},{"locationName":"광주","ta":"28.8"},{"locationName":"부산","ta":"30.1"},{"locationName":"통영","ta":"27.0"},{"locationName":"목포","ta":"28.2"},{"locationName":"여수","ta":"26.9"},{"locationName":"흑산도","ta":"24.4"},{"locationName":"완도","ta":"30.0"},{"locationName":"고창","ta":"29.2"},{"locationName":"순천","ta":"27.0"},{"locationName":"홍성","ta":"28.8"},{"locationName":"서청주","ta":"28.7"},{"locationName":"제주","ta":"30.3"},{"locationName":"고산","ta":"28.6"},{"locationName":"성산","ta":"29.7"},{"locationName":"서귀포","ta":"29.5"},{"locationName":"진주","ta":"28.7"},{"locationName":"강화","ta":"24.9"},{"locationName":"양평","ta":"26.4"},{"locationName":"이천","ta":"27.9"},{"locationName":"인제","ta":"25.7"},{"locationName":"홍천","ta":"25.2"},{"locationName":"태백","ta":"28.4"},{"locationName":"정선군","ta":"29.0"},{"locationName":"제천","ta":"27.1"},{"locationName":"보은","ta":"28.3"},{"locationName":"천안","ta":"28.7"},{"locationName":"보령","ta":"28.4"},{"locationName":"부여","ta":"29.1"},{"locationName":"금산","ta":"29.8"},{"locationName":"세종","ta":"28.9"},{"locationName":"부안","ta":"29.3"},{"locationName":"임실","ta":"28.3"},{"locationName":"정읍","ta":"29.7"},{"locationName":"남원","ta":"29.8"},{"locationName":"장수","ta":"27.2"},{"locationName":"고창군","ta":"28.8"},{"locationName":"영광군","ta":"29.1"},{"locationName":"김해시","ta":"29.0"},{"locationName":"순창군","ta":"28.5"},{"locationName":"북창원","ta":"30.0"},{"locationName":"양산시","ta":"30.2"},{"locationName":"보성군","ta":"28.2"},{"locationName":"강진군","ta":"29.2"},{"locationName":"장흥","ta":"28.6"},{"locationName":"해남","ta":"29.2"},{"locationName":"고흥","ta":"30.6"},{"locationName":"의령군","ta":"30.7"},{"locationName":"함양군","ta":"28.9"},{"locationName":"광양시","ta":"28.8"},{"locationName":"진도군","ta":"28.5"},{"locationName":"봉화","ta":"28.5"},{"locationName":"영주","ta":"27.8"},{"locationName":"문경","ta":"28.7"},{"locationName":"청송군","ta":"30.2"},{"locationName":"영덕","ta":"29.8"},{"locationName":"의성","ta":"30.4"},{"locationName":"구미","ta":"29.7"},{"locationName":"영천","ta":"30.0"},{"locationName":"경주시","ta":"30.9"},{"locationName":"거창","ta":"29.2"},{"locationName":"합천","ta":"29.5"},{"locationName":"밀양","ta":"31.0"},{"locationName":"산청","ta":"29.6"},{"locationName":"거제","ta":"28.0"},{"locationName":"남해","ta":"28.3"},{"locationName":"북부산","ta":"29.9"}] 
		// -- 지역 97개 모두 차트에 그리기에는 너무 많으므로 아래처럼 작업을 하여 지역을  21개(String[] locationArr 임)로 줄여서 나타내기로 하겠다.
		
		str_jsonObjArr = str_jsonObjArr.substring(1, str_jsonObjArr.length()-1);
	//	System.out.println(str_jsonObjArr);
		// {"locationName":"속초","ta":"29.4"},{"locationName":"북춘천","ta":"26.2"},{"locationName":"철원","ta":"25.4"},{"locationName":"동두천","ta":"25.6"},{"locationName":"파주","ta":"24.8"},{"locationName":"대관령","ta":"23.3"},{"locationName":"춘천","ta":"26.1"},{"locationName":"백령도","ta":"24.6"},{"locationName":"북강릉","ta":"30.2"},{"locationName":"강릉","ta":"30.7"},{"locationName":"동해","ta":"29.2"},{"locationName":"서울","ta":"26.5"},{"locationName":"인천","ta":"25.6"},{"locationName":"원주","ta":"29.1"},{"locationName":"울릉도","ta":"29.1"},{"locationName":"수원","ta":"27.4"},{"locationName":"영월","ta":"27.9"},{"locationName":"충주","ta":"29.5"},{"locationName":"서산","ta":"27.0"},{"locationName":"울진","ta":"30.7"},{"locationName":"청주","ta":"29.9"},{"locationName":"대전","ta":"28.8"},{"locationName":"추풍령","ta":"28.1"},{"locationName":"안동","ta":"29.3"},{"locationName":"상주","ta":"29.6"},{"locationName":"포항","ta":"31.0"},{"locationName":"군산","ta":"29.6"},{"locationName":"대구","ta":"30.6"},{"locationName":"전주","ta":"30.0"},{"locationName":"울산","ta":"30.3"},{"locationName":"창원","ta":"30.1"},{"locationName":"광주","ta":"28.8"},{"locationName":"부산","ta":"30.1"},{"locationName":"통영","ta":"27.0"},{"locationName":"목포","ta":"28.2"},{"locationName":"여수","ta":"26.9"},{"locationName":"흑산도","ta":"24.4"},{"locationName":"완도","ta":"30.0"},{"locationName":"고창","ta":"29.2"},{"locationName":"순천","ta":"27.0"},{"locationName":"홍성","ta":"28.8"},{"locationName":"서청주","ta":"28.7"},{"locationName":"제주","ta":"30.3"},{"locationName":"고산","ta":"28.6"},{"locationName":"성산","ta":"29.7"},{"locationName":"서귀포","ta":"29.5"},{"locationName":"진주","ta":"28.7"},{"locationName":"강화","ta":"24.9"},{"locationName":"양평","ta":"26.4"},{"locationName":"이천","ta":"27.9"},{"locationName":"인제","ta":"25.7"},{"locationName":"홍천","ta":"25.2"},{"locationName":"태백","ta":"28.4"},{"locationName":"정선군","ta":"29.0"},{"locationName":"제천","ta":"27.1"},{"locationName":"보은","ta":"28.3"},{"locationName":"천안","ta":"28.7"},{"locationName":"보령","ta":"28.4"},{"locationName":"부여","ta":"29.1"},{"locationName":"금산","ta":"29.8"},{"locationName":"세종","ta":"28.9"},{"locationName":"부안","ta":"29.3"},{"locationName":"임실","ta":"28.3"},{"locationName":"정읍","ta":"29.7"},{"locationName":"남원","ta":"29.8"},{"locationName":"장수","ta":"27.2"},{"locationName":"고창군","ta":"28.8"},{"locationName":"영광군","ta":"29.1"},{"locationName":"김해시","ta":"29.0"},{"locationName":"순창군","ta":"28.5"},{"locationName":"북창원","ta":"30.0"},{"locationName":"양산시","ta":"30.2"},{"locationName":"보성군","ta":"28.2"},{"locationName":"강진군","ta":"29.2"},{"locationName":"장흥","ta":"28.6"},{"locationName":"해남","ta":"29.2"},{"locationName":"고흥","ta":"30.6"},{"locationName":"의령군","ta":"30.7"},{"locationName":"함양군","ta":"28.9"},{"locationName":"광양시","ta":"28.8"},{"locationName":"진도군","ta":"28.5"},{"locationName":"봉화","ta":"28.5"},{"locationName":"영주","ta":"27.8"},{"locationName":"문경","ta":"28.7"},{"locationName":"청송군","ta":"30.2"},{"locationName":"영덕","ta":"29.8"},{"locationName":"의성","ta":"30.4"},{"locationName":"구미","ta":"29.7"},{"locationName":"영천","ta":"30.0"},{"locationName":"경주시","ta":"30.9"},{"locationName":"거창","ta":"29.2"},{"locationName":"합천","ta":"29.5"},{"locationName":"밀양","ta":"31.0"},{"locationName":"산청","ta":"29.6"},{"locationName":"거제","ta":"28.0"},{"locationName":"남해","ta":"28.3"},{"locationName":"북부산","ta":"29.9"} 
		
		String[] arr_str_jsonObjArr = str_jsonObjArr.split("\\},");
		
		for(int i=0; i<arr_str_jsonObjArr.length; i++) {
			arr_str_jsonObjArr[i] += "}";
		}// end of for-------------
		
	
		
		String[] locationArr = {"서울","인천","수원","춘천","강릉","청주","홍성","대전","안동","포항","대구","전주","울산","부산","창원","여수","광주","목포","제주","울릉도","백령도"}; 
		String result = "[";
		
		for(String jsonObj : arr_str_jsonObjArr) {
			
			for(int i=0; i<locationArr.length; i++) {
				if( jsonObj.indexOf(locationArr[i]) >= 0 && jsonObj.indexOf("북") == -1 && jsonObj.indexOf("서청주") == -1 ) { // 북춘천,춘천,북강릉,강릉,북부산,부산이 있으므로  "북" 이 있는 것은 제외하도록 한다. 또한 서청주(예)도 제외하도록 한다.    
					result += jsonObj+",";
					break;
				}
			}// end of for--------------
			
		}// end of for----------------------
		
	//	System.out.println(result);
	//	[{"locationName":"춘천","ta":"26.1"},{"locationName":"백령도","ta":"24.6"},{"locationName":"강릉","ta":"30.7"},{"locationName":"서울","ta":"26.5"},{"locationName":"인천","ta":"25.6"},{"locationName":"울릉도","ta":"29.1"},{"locationName":"수원","ta":"27.4"},{"locationName":"청주","ta":"29.9"},{"locationName":"대전","ta":"28.8"},{"locationName":"안동","ta":"29.3"},{"locationName":"포항","ta":"31.0"},{"locationName":"대구","ta":"30.6"},{"locationName":"전주","ta":"30.0"},{"locationName":"울산","ta":"30.3"},{"locationName":"창원","ta":"30.1"},{"locationName":"광주","ta":"28.8"},{"locationName":"부산","ta":"30.1"},{"locationName":"목포","ta":"28.2"},{"locationName":"여수","ta":"26.9"},{"locationName":"홍성","ta":"28.8"},{"locationName":"제주","ta":"30.3"},
		
		result = result.substring(0, result.length()-1);
		result = result + "]";
		
	//	System.out.println(result);
	//	[{"locationName":"춘천","ta":"26.1"},{"locationName":"백령도","ta":"24.6"},{"locationName":"강릉","ta":"30.7"},{"locationName":"서울","ta":"26.5"},{"locationName":"인천","ta":"25.6"},{"locationName":"울릉도","ta":"29.1"},{"locationName":"수원","ta":"27.4"},{"locationName":"청주","ta":"29.9"},{"locationName":"대전","ta":"28.8"},{"locationName":"안동","ta":"29.3"},{"locationName":"포항","ta":"31.0"},{"locationName":"대구","ta":"30.6"},{"locationName":"전주","ta":"30.0"},{"locationName":"울산","ta":"30.3"},{"locationName":"창원","ta":"30.1"},{"locationName":"광주","ta":"28.8"},{"locationName":"부산","ta":"30.1"},{"locationName":"목포","ta":"28.2"},{"locationName":"여수","ta":"26.9"},{"locationName":"홍성","ta":"28.8"},{"locationName":"제주","ta":"30.3"}] 
		
		return result;
		
	}

	
	
	
}
