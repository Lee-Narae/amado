package com.spring.app.amado.controller;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MatchingVO;
import com.spring.app.service.AmadoService_JH;


@Controller
public class ControllerJH {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AmadoService_JH service; 
	
	@GetMapping("/club/sale.do")
	public ModelAndView sale(ModelAndView mav) {

		//AmadoService_JH.sale();
		
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
		
		//System.out.println(comment_text);
		
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
		
		
		System.out.println(matchingList.get(0).getClubname1());
		
		for(MatchingVO matchingvo : matchingList) {
			if(matchingvo.getClubseq1() == clubseq) {
				
			}
		}
		
		
		mav.addObject("clubvo", clubvo);
		mav.addObject("matchingList", matchingList);
		mav.setViewName("club/myClub_plus.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
	
	

	@GetMapping("/gym/gymPay.do")
	public ModelAndView gymPay(ModelAndView mav, HttpServletRequest request) {

		String gymseq = request.getParameter("gymseq");
		//System.out.println(request.getParameter("gymseq")); 
		
		GymVO gymvo = service.getGymInfo(gymseq);
		
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
	
	
	
}
