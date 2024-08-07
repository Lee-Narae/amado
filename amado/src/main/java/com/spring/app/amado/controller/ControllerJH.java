package com.spring.app.amado.controller;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.app.common.MyUtil;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.GymresVO;
import com.spring.app.domain.MatchingVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.service.AmadoService_JH;


@Controller
public class ControllerJH {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AmadoService_JH service; 
	
	@GetMapping("/club/sale.do")
	public ModelAndView sale(ModelAndView mav, HttpServletRequest request) {

		String fleamarketseq = request.getParameter("fleamarketseq");
		//System.out.println("16jbhv"+fleamarketseq);
		FleamarketVO fleMap = service.getfleMap(fleamarketseq);
		
		if(fleMap != null) {
			service.viewcount(fleamarketseq);
		}
		
		String sportseq = fleMap.getSportseq();
		//System.out.println(sportseq);
		
		List<Map<String, String>> imgList = service.getimgList(sportseq);
		
		//System.out.println("22222"+fleMap.getContent());
		mav.addObject("imgList",imgList);
		mav.addObject("fleMap",fleMap);
		mav.setViewName("club/sale.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
	
	
	
	@ResponseBody
	@PostMapping(value="/addComment.do", produces="text/plain;charset=UTF-8")
	public String addComment(FleamarketCommentVO fmcommentvo, HttpServletRequest request) {
		// 댓글쓰기에 첨부파일이 없는 경우
		String name = request.getParameter("name");
		String comment_text = request.getParameter("comment_text");
		fmcommentvo.setFleamarketseq(request.getParameter("fleamarketseq"));
		//System.out.println("gdgd"+request.getParameter("fleamarketseq"));
		
		int n = 0;
		
		try {
			n = service.addComment(fmcommentvo);
			// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
	        // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)
			 
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);  // {"n":1} 또는 	{"n":0}
		jsonObj.put("name", name);  // {"n":1, "name":"엄정화"} 또는 	{"n":0, "name":"최준혁"}
		
		
		return jsonObj.toString();
		// "{"n":1, "name":"엄정화"} 또는  {"n":0, "name":"최준혁"}"
	}
	
	
	
	// === #90. 원게시물에 딸린 댓글들을 조회해오기(Ajax 로 처리) === //
	@ResponseBody
	@GetMapping(value="/readComment.action", produces="text/plain;charset=UTF-8") 
	public String readComment(HttpServletRequest request) {
		
		String parentSeq = request.getParameter("parentSeq"); 
		
		System.out.println(parentSeq);
		
		List<FleamarketCommentVO> commentList = service.getCommentList(parentSeq); 
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(commentList != null) {
			for(FleamarketCommentVO fmcommentvo : commentList) {
				JSONObject jsonObj = new JSONObject();          // {} 
				jsonObj.put("fleamarketcommentseq", fmcommentvo.getFleamarketcommentseq());             // {"seq":1}
				jsonObj.put("fk_userid", fmcommentvo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
				jsonObj.put("comment_text", fmcommentvo.getComment_text());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
				jsonObj.put("registerdate", fmcommentvo.getRegisterdate());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}
				jsonObj.put("memberimg", fmcommentvo.getMemberimg());
				jsonObj.put("changestatus", fmcommentvo.getChangestatus());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------------
		}
		
		return jsonArr.toString(); // "[{"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}]"
		                           // 또는
		                           // "[]"
	}
	
	
	// === #146. 원게시물에 딸린 댓글내용들을 페이징 처리하기 (Ajax 로 처리) === // 
	/*
		@ResponseBody
		@GetMapping(value="/commentList.action", produces="text/plain;charset=UTF-8") 
		public String commentList(HttpServletRequest request) {

			String parentSeq = request.getParameter("parentSeq");
			String currentShowPageNo = request.getParameter("currentShowPageNo"); 
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			int sizePerPage = 5; // 한 페이지당 5개의 댓글을 보여줄 것임.
			
			// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
			
			     currentShowPageNo      startRno     endRno
			    --------------------------------------------
			         1 page        ===>    1           10
			         2 page        ===>    11          20
			         3 page        ===>    21          30
			         4 page        ===>    31          40
			         ......                ...         ...
			 
			int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1; // 시작 행번호 
			int endRno = startRno + sizePerPage - 1; // 끝 행번호
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("parentSeq", parentSeq);
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			List<CommentVO> commentList = service.getCommentList_Paging(paraMap); 
			int totalCount = service.getCommentTotalCount(parentSeq); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
			
			JSONArray jsonArr = new JSONArray(); // [] 
			
			if(commentList != null) {
				for(CommentVO cmtvo : commentList) {
					JSONObject jsonObj = new JSONObject();          // {} 
					jsonObj.put("seq", cmtvo.getSeq());             // {"seq":1}
					jsonObj.put("fk_userid", cmtvo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
					jsonObj.put("name", cmtvo.getName());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
					jsonObj.put("content", cmtvo.getContent());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ"}
					jsonObj.put("regdate", cmtvo.getRegDate());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}
					
					jsonObj.put("totalCount", totalCount);   // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
					jsonObj.put("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임. 
					
					//=== #197. 댓글읽어오기에 있어서 첨부파일 기능을 넣은 경우 시작 === //
					jsonObj.put("fileName", cmtvo.getFileName());  
					jsonObj.put("orgFilename", cmtvo.getOrgFilename());  
					jsonObj.put("fileSize", cmtvo.getFileSize());  
					
					//=== 댓글읽어오기에 있어서 첨부파일 기능을 넣은 경우 끝 === //
					
					
					jsonArr.put(jsonObj);
				}// end of for-----------------------
			}
			
		//	System.out.println(jsonArr.toString());
			
			return jsonArr.toString(); // "[{"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}]"
			                           // 또는
			                           // "[]"		
			
		}
	
	*/
	
	
	
	// === #95. 댓글 수정(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value="/updateComment.action", produces="text/plain;charset=UTF-8")
	public String updateComment(HttpServletRequest request) {
		
		String fleamarketcommentseq = request.getParameter("fleamarketcommentseq");
		String comment_text = request.getParameter("content");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fleamarketcommentseq", fleamarketcommentseq);
		paraMap.put("comment_text", comment_text);
		
		int n = service.updateComment(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString(); // "{"n":1}"
	}
	
		
	
	
	@ResponseBody
	@PostMapping(value="/deleteComment.action", produces="text/plain;charset=UTF-8") 
	public String deleteComment(HttpServletRequest request) {
		
		String fleamarketcommentseq = request.getParameter("fleamarketcommentseq");
		String fleamarketseq = request.getParameter("parentSeq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fleamarketcommentseq", fleamarketcommentseq);
		paraMap.put("fleamarketseq", fleamarketseq);
		
		int n=0;
		try {
			n = service.deleteComment(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString(); // "{"n":1}"
	}
	
	
	@ResponseBody
	@PostMapping(value="/addReplyComment.action", produces="text/plain;charset=UTF-8")
	public String addReplyComment(HttpServletRequest request) {
		
		String fleamarketcommentseq = request.getParameter("fleamarketcommentseq");
		
		// System.out.println(fleamarketcommentseq);
		List<FleamarketCommentReVO> commentreList = service.getCommentreList(fleamarketcommentseq); 
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(commentreList != null) {
			for(FleamarketCommentReVO fmcommentrevo : commentreList) {
				JSONObject jsonObj = new JSONObject();          // {} 
				jsonObj.put("fleamarketcommentreplyseq", fmcommentrevo.getFleamarketcommentreplyseq());             // {"seq":1}
				jsonObj.put("fk_userid", fmcommentrevo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
				jsonObj.put("commentreply_text", fmcommentrevo.getCommentreply_text());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
				jsonObj.put("registerdate", fmcommentrevo.getRegisterdate());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}
				jsonObj.put("memberimg", fmcommentrevo.getMemberimg());
				jsonObj.put("changestatus", fmcommentrevo.getChangestatus());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------------
		}
		
		return jsonArr.toString();
	}
	
	
	
	@ResponseBody
	@PostMapping(value="/addReComment.do", produces="text/plain;charset=UTF-8")
	public String addReComment(FleamarketCommentReVO fmcommentrevo, HttpServletRequest request) {
		
		// 댓글쓰기에 첨부파일이 없는 경우
		String fk_userid = request.getParameter("fk_userid");
		String commentreply_text = request.getParameter("commentreply_text");
		String fleamarketcommentseq = request.getParameter("fleamarketcommentseq");
		
		//System.out.println("1"+fk_userid);
		//System.out.println("2"+commentreply_text);
		//System.out.println("3"+fleamarketcommentseq);
		
		fmcommentrevo.setFk_userid(fk_userid);
		
		int n = 0;
		
		try {
			n = service.addReComment(fmcommentrevo);
			// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
	        // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)
			 
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);  // {"n":1} 또는 	{"n":0}
		
		
		return jsonObj.toString();
		// "{"n":1, "name":"엄정화"} 또는  {"n":0, "name":"최준혁"}"
	}
	
	
	
	/*
	// === #90. 원게시물에 딸린 댓글들을 조회해오기(Ajax 로 처리) === //
	@ResponseBody
	@GetMapping(value="/readComment.action", produces="text/plain;charset=UTF-8") 
	public String readComment(HttpServletRequest request) {
		
		String parentSeq = request.getParameter("parentSeq"); 
		
		List<FleamarketCommentVO> commentList = service.getCommentList(parentSeq); 
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(commentList != null) {
			for(FleamarketCommentVO fmcommentvo : commentList) {
				JSONObject jsonObj = new JSONObject();          // {} 
				jsonObj.put("fleamarketcommentseq", fmcommentvo.getFleamarketcommentseq());             // {"seq":1}
				jsonObj.put("fk_userid", fmcommentvo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
				jsonObj.put("comment_text", fmcommentvo.getComment_text());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
				jsonObj.put("registerdate", fmcommentvo.getRegisterdate());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}
				jsonObj.put("memberimg", fmcommentvo.getMemberimg());
				jsonObj.put("changestatus", fmcommentvo.getChangestatus());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------------
		}
		
		return jsonArr.toString(); // "[{"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}]"
		                           // 또는
		                           // "[]"
	}
	*/
	
	
	
	
	// === 답글 수정(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value="/updateReComment.do", produces="text/plain;charset=UTF-8")
	public String updateReComment(HttpServletRequest request) {
		
		String fleamarketcommentreplyseq = request.getParameter("fleamarketcommentreplyseq");
		String commentreply_text = request.getParameter("content");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fleamarketcommentreplyseq", fleamarketcommentreplyseq);
		paraMap.put("commentreply_text", commentreply_text);
		
		int n = service.updateReComment(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString(); // "{"n":1}"
	}
	
		
	
	
	@ResponseBody
	@PostMapping(value="/deleteReComment.do", produces="text/plain;charset=UTF-8") 
	public String deleteReComment(HttpServletRequest request) {
		
		String fleamarketcommentreplyseq = request.getParameter("fleamarketcommentreplyseq");
		String fleamarketcommentseq = request.getParameter("fleamarketcommentseq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fleamarketcommentreplyseq", fleamarketcommentreplyseq);
		paraMap.put("fleamarketcommentseq", fleamarketcommentseq);
		
		int n=0;
		try {
			n = service.deleteReComment(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString(); // "{"n":1}"
	}
	
	
	@GetMapping("/club/myClub_plus.do")
	public ModelAndView myClub_plus(ModelAndView mav, HttpServletRequest request) {
		
		// 조회하고자 하는 글번호 받아오기
		String clubseq = request.getParameter("clubseq");
		String sportseq = request.getParameter("sportseq");

		// System.out.println("확인용  clubseq" + clubseq);
		// System.out.println("확인용  sportseq" + sportseq);

		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("clubseq", clubseq);
		paraMap.put("sportseq", sportseq);

		ClubVO clubvo = service.getMyClub(paraMap);
		System.out.println(clubvo.getWasfileName());
		clubvo.setClubseq(clubseq);
		if(clubvo != null) {
			service.updateviewcount(clubseq);
		}
		
		/*
			System.out.println(clubvo.getClubseq());
			System.out.println(clubvo.getClubname());
			System.out.println(clubvo.getClubimg());
			System.out.println(clubvo.getFk_sportseq());
			System.out.println(clubvo.getFk_userid());
			System.out.println(clubvo.getClubtel());
			System.out.println(clubvo.getCity());
			System.out.println(clubvo.getLocal());
			System.out.println(clubvo.getClubtime());
			System.out.println(clubvo.getMembercount());
			System.out.println(clubvo.getClubpay());
			System.out.println(clubvo.getClubstatus());
			System.out.println(clubvo.getClubscore());
		*/
		
		List<MatchingVO> matchingList = service.getmatchingList(clubseq);
		
		
		//System.out.println(matchingList.get(0).getClubname1());
		
		for(MatchingVO matchingvo : matchingList) {
			if(matchingvo.getClubseq1() == clubseq) {
				
			}
		}
		
		List<ClubBoardVO> clubboardList = service.getclboList(clubseq);
		String goBackURL = MyUtil.getCurrentURL(request);
		
		Map<String, String> statList = service.getstat(clubseq);
		
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("clubboardList", clubboardList);
		mav.addObject("clubvo", clubvo);
		mav.addObject("matchingList", matchingList);
		mav.addObject("statList", statList);
		mav.setViewName("club/myClub_plus.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
	
	

	@GetMapping("/gym/gymPay.do")
	public ModelAndView gymPay(ModelAndView mav, HttpServletRequest request) {

		String gymseq = request.getParameter("gymseq");
		//System.out.println(request.getParameter("gymseq")); 
		
		GymVO gymvo = service.getGymInfo(gymseq);
		
		request.setAttribute("gymvo", gymvo);
		request.setAttribute("gymseq", gymseq);
		
		mav.addObject("gymvo", gymvo);
		mav.setViewName("gym/gymPay.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
	
	
	@ResponseBody
	@GetMapping(value="/gym/gymPay_JSON.do", produces="text/plain;charset=UTF-8") 
	public String gymPay_JSON(HttpServletRequest request) throws IOException, ParseException {

		// System.out.println(fleamarketcommentseq);
		List<GymVO> GymAddList = service.getGymAdd(); 
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(GymAddList != null) {
			for(GymVO gvo : GymAddList) {
				JSONObject jsonObj = new JSONObject();           
				jsonObj.put("lat", gvo.getLat());   //위도          
				jsonObj.put("lng", gvo.getLng()); 	//경도
				jsonObj.put("gymseq", gvo.getGymseq());
				
				
				jsonArr.put(jsonObj);
			}// end of for-----------------------
		}
		
		return jsonArr.toString();
	}
	
	
	@ResponseBody
	@GetMapping(value="/gym/gymPay_dtail.do", produces="text/plain;charset=UTF-8") 
	public String gymPay_dtail(HttpServletRequest request) throws IOException, ParseException {

		//System.out.println(request.getParameter("gymseq"));
		
		String gymseq = request.getParameter("gymseq");
		
		GymVO gymvo = service.getgymPay(gymseq); 
		
		JSONObject jsonObj = new JSONObject(); 
		jsonObj.put("gymname", gymvo.getGymname());
		jsonObj.put("address", gymvo.getAddress());
		jsonObj.put("detailaddress", gymvo.getDetailaddress());
		jsonObj.put("cost", gymvo.getCost());
		jsonObj.put("orgfilename", gymvo.getOrgfilename());
		jsonObj.put("lat", gymvo.getLat());
		jsonObj.put("lng", gymvo.getLng());
		jsonObj.put("gymseq", gymseq);
		jsonObj.put("filename", gymvo.getFilename());
		
		
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value="/gym/gymPay_end.do", produces="text/plain;charset=UTF-8") 
	public String gymPay_end(HttpServletRequest request) throws IOException, ParseException {

		
		String numericPrice = request.getParameter("numericPrice");
		String reservation_date = request.getParameter("reservation_date");
		String fk_gymseq = request.getParameter("fk_gymseq");
		String fk_userid = request.getParameter("fk_userid");
		//System.out.println(numericPrice);
		//System.out.println(reservation_date);
		//System.out.println(fk_gymseq);
		//System.out.println(fk_userid);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("numericPrice", numericPrice);
		paraMap.put("reservation_date", reservation_date);
		paraMap.put("fk_gymseq", fk_gymseq);
		paraMap.put("fk_userid", fk_userid);
		
		// 입력된 시간 문자열을 가져옵니다.
		String time = request.getParameter("selected").trim();
		System.out.println("여기야"+time);

		int chunkSize = 5;
        ArrayList<String> list = new ArrayList<>();

        for (int i = 0; i < time.length(); i += chunkSize) {
            int end = Math.min(time.length(), i + chunkSize);
            list.add(time.substring(i, end));
        }

        // ArrayList를 배열로 변환
        String[] times = list.toArray(new String[0]);

        // 결과 출력
        for (String t : times) {
            System.out.println(t);
        }
		
		
		int n = 0;
		// 결과 확인
		for(int i=0; i<times.length; i++) {
			//System.out.println(times[i]);
			time = times[i];
			paraMap.put("time", time);
			n = service.gymPayEnd(paraMap);
			if(n!=1) {
				n=0;
				break;
			}
		}
		
		//System.out.println(selectedTimes[0]);
		//System.out.println(selectedTimes[1]);	
		System.out.println(n);
		
		 
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@GetMapping(value="/gym/gymPayDate.do", produces="text/plain;charset=UTF-8") 
	public String gymPayDate(HttpServletRequest request) throws IOException, ParseException {

		//System.out.println(request.getParameter("reservation_date"));
		//System.out.println(request.getParameter("gymseq"));
		
		String reservation_date = request.getParameter("reservation_date");
		String gymseq = request.getParameter("gymseq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("reservation_date", reservation_date);
		paraMap.put("gymseq", gymseq);
		
		List<Map<String, String>> gymDateList = service.getgymPayDate(paraMap); 
		
		for(Map<String, String> gymdate : gymDateList) {
			//System.out.println(gymdate.get("time"));
		}// end of for----------------------
		
		String cost = service.getCost(gymseq);
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("cost", cost);
		jsonArr.put(jsonObj);
		for(Map<String, String> gymdate : gymDateList) {
			jsonObj = new JSONObject();
			jsonObj.put("time", gymdate.get("time"));
			
			jsonArr.put(jsonObj);
		}// end of for----------------------
		
		
		return jsonArr.toString();
	}
	
	
	
	
	
	
	@GetMapping(value="/gym/coinPurchaseEnd.do", produces="text/plain;charset=UTF-8") 
	public ModelAndView coinPurchaseEnd(ModelAndView mav, HttpServletRequest request) {
		// 원포트(구 아임포트) 결제창을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다. 
		if(request.getParameter("userid") != null) {
			// 로그인을 했으면
			
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 사용자가 자신의 코인을 수정하는 경우 
				
				String coinmoney = request.getParameter("coinmoney"); 
				String gymname = request.getParameter("gymname"); 
				
				String productName = "새우깡";
				int productPrice = Integer.parseInt(coinmoney);
								
				request.setAttribute("productName", productName);
			//	request.setAttribute("productPrice", productPrice);
				request.setAttribute("productPrice", productPrice);
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				request.setAttribute("gymname", gymname);
				
			//	System.out.println("~~~~ 확인용 email : " + loginuser.getEmail());
			//	System.out.println("~~~~ 확인용 mobile : " + loginuser.getMobile());
				
				request.setAttribute("userid", userid);
				request.setAttribute("coinmoney", coinmoney);
				
				mav.setViewName("/paymentGateway");
				
				return mav;
			}
			else {
				// 로그인한 사용자가 다른 사용자의 코인을 충전하려고 결제를 시도하는 경우 
				String message = "다른 사용자의 코인충전 결제 시도는 불가합니다.!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				mav.setViewName("/msg");
				
				return mav;
			}
			
		}
		else {
			// 로그인을 안했으면 
			String message = "코인충전 결제를 하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			mav.setViewName("/msg");
			
			return mav;
		}
	}
			
	
	@GetMapping("/gym/view_reservation.do")
	public ModelAndView view_reservation(ModelAndView mav, HttpServletRequest request) {

	    String userid = request.getParameter("userid");
	    String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	    
	    int totalCount = service.getTotalCount(userid);
	    int sizePerPage = 10;
	    int currentShowPageNo = 0;
	    int totalPage = (int) Math.ceil((double) totalCount / sizePerPage);
	    
	    if (str_currentShowPageNo == null) {
	        currentShowPageNo = 1;
	    } else {
	        try {
	            currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	            if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
	                currentShowPageNo = 1;
	            }
	        } catch (NumberFormatException e) {
	            currentShowPageNo = 1;
	        }
	    }
	    
	    int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1;
	    
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    paraMap.put("userid", userid);
	    
	    List<Map<String, String>> resList = service.getresinfo(paraMap);
	    mav.addObject("resList", resList);
	    
	    int blockSize = 10;
	    int loop = 1;
	    int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
	    
	    String contextPath = request.getContextPath();
	    String url = contextPath + "/gym/view_reservation.do";
	    
	    StringBuilder pageBar = new StringBuilder("<ul style='list-style:none;'>");
	    
	    if (pageNo != 1) {
	        pageBar.append("<li style='display:inline-block; width:70px; font-size:12pt;'><a href='")
	               .append(url).append("?userid=").append(userid).append("'>[맨처음]</a></li>");
	        pageBar.append("<li style='display:inline-block; width:50px; font-size:12pt;'><a href='")
	               .append(url).append("?userid=").append(userid).append("&currentShowPageNo=")
	               .append(pageNo - 1).append("'>[이전]</a></li>");
	    }
	    
	    while (!(loop > blockSize || pageNo > totalPage)) {
	        if (pageNo == currentShowPageNo) {
	            pageBar.append("<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:black; padding:2px 4px;'>")
	                   .append(pageNo).append("</li>");
	        } else {
	            pageBar.append("<li style='display:inline-block; width:30px; font-size:12pt;'><a style='color:#999;' href='")
	                   .append(url).append("?userid=").append(userid).append("&currentShowPageNo=")
	                   .append(pageNo).append("'>").append(pageNo).append("</a></li>");
	        }
	        loop++;
	        pageNo++;
	    }
	    
	    if (pageNo <= totalPage) {
	        pageBar.append("<li style='display:inline-block; width:50px; font-size:12pt;'><a href='")
	               .append(url).append("?userid=").append(userid).append("&currentShowPageNo=")
	               .append(pageNo).append("'>[다음]</a></li>");
	        pageBar.append("<li style='display:inline-block; width:70px; font-size:12pt;'><a href='")
	               .append(url).append("?userid=").append(userid).append("&currentShowPageNo=")
	               .append(totalPage).append("'>[마지막]</a></li>");
	    }
	    
	    pageBar.append("</ul>");
	    
	    mav.addObject("pageBar", pageBar.toString());
	    
	    String goBackURL = MyUtil.getCurrentURL(request);
	    mav.addObject("goBackURL", goBackURL);
	    
	    mav.addObject("totalCount", totalCount);
	    mav.addObject("currentShowPageNo", currentShowPageNo);
	    mav.addObject("sizePerPage", sizePerPage);
	    
	    mav.setViewName("gym/view_reservation.tiles2");
	    
	    return mav;
	}
	
	/*
	@GetMapping("/weather/weatherXML.do")
	public String weatherXML() {
		return "weather/weatherXML";
		//  /board/src/main/webapp/WEB-INF/views/weather/weatherXML.jsp 파일을 생성한다.  
	}
	*/
	
	
	
	@ResponseBody
	@GetMapping(value="/gym/res_cancel.do", produces="text/plain;charset=UTF-8") 
	public String res_cancel(HttpServletRequest request) throws IOException, ParseException {

		//System.out.println(request.getParameter("gymseq"));
		//System.out.println(request.getParameter("fk_userid"));
		//System.out.println(request.getParameter("reservation_date"));
		//System.out.println(request.getParameter("time_range"));
		
		String gymseq = request.getParameter("gymseq");
		String fk_userid = request.getParameter("fk_userid");
		String reservation_date = request.getParameter("reservation_date");
		String time_range = request.getParameter("time_range");
		String startTime = time_range.substring(0,5);
		String endTime1 = time_range.substring(8,13);
		
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime time = LocalTime.parse(endTime1, formatter);

        // 1시간 빼기
        LocalTime newTime = time.minusHours(1);

        // LocalTime을 다시 문자열로 변환
        String endTime = newTime.format(formatter);
		
		
		//System.out.println("startTime"+startTime);
		//System.out.println("endTime"+endTime);
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("gymseq", gymseq);
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("reservation_date", reservation_date);
		paraMap.put("startTime", startTime);
		paraMap.put("endTime", endTime);
		
		int n = service.res_cancel(paraMap); 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		//System.out.println(n);
		return jsonObj.toString();
	}
	
	
	
	@ResponseBody
	@GetMapping(value="/gym/viewres_JSON.do", produces="text/plain;charset=UTF-8") 
	public String viewres_JSON(HttpServletRequest request) throws IOException, ParseException {
		
		String gymseq = request.getParameter("gymseq");
		
		System.out.println(gymseq);
		
		Map<String,String> viewresMap = service.getviewresList(gymseq); 
		
		JSONObject jsonObj = new JSONObject();           
		jsonObj.put("lat", viewresMap.get("lat"));   //위도          
		jsonObj.put("lng", viewresMap.get("lng")); 	//경도
				
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@GetMapping(value="/gym/latlng.do", produces="text/plain;charset=UTF-8") 
	public String latlng(HttpServletRequest request) throws IOException, ParseException {
		
		String gymseq = request.getParameter("gymseq");
		
		System.out.println(gymseq);
		
		Map<String,String> latlng = service.getviewresList(gymseq); 
		
		JSONObject jsonObj = new JSONObject();           
		jsonObj.put("lat", latlng.get("lat"));   //위도          
		jsonObj.put("lng", latlng.get("lng")); 	//경도
				
		return jsonObj.toString();
	}
	
	
	
}
