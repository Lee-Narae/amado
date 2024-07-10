package com.spring.app.amado.controller;

import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.MyUtil;
import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.service.AmadoService_SJ;

@Controller
public class ControllerSJ {
	// 승진님 컨트롤러

	@Autowired
	private AmadoService_SJ service;

	// 게시판 목록보기
	@GetMapping("/community/list.do")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {

		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);

//		System.out.println("테스트 url : " + url);
//		테스트 url : /community/list.do?sportseq=1
//		테스트 url : /community/list.do
//		System.out.println("파라미터 부분: " + params);
//		파라미터 부분: sportseq=1
//		파라미터 부분: /community/list.do

		if(request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}
		
		List<BoardVO> boardPagingList = null;

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		
		if (searchType == null) {
			searchType = "title";
		}
		if (searchWord == null) {
			searchWord = " ";
		}

		if (searchWord != null) {
			searchWord = searchWord.trim();
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("params", params);
		
//		System.out.println("확인용 params : " + params);
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)

        // 게시판 총 페이지 수(검색포함)
        totalCount = service.getListSearchTotalPage(paraMap);

//      System.out.println("확인용 ~~ totalCount : " + totalCount);
        
        
        totalPage = (int) Math.ceil((double) totalCount / sizePerPage);
        
        
        // 게시판에 보여지는 초기화면
		if (str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if (currentShowPageNo < 1 || currentShowPageNo > totalCount) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
//		System.out.println("확인용 !~~ startRno : " + startRno);
//		System.out.println("확인용 !~~ endRno : " + endRno);
		
		paraMap.put("startRno", Integer.toString(startRno));
		paraMap.put("endRno", Integer.toString(endRno));
        
        
        
		// 검색타입 있거나 없는 리스트 가져오기(페이징)
		boardPagingList = service.boardListSearchPaging(paraMap);
		mav.addObject("boardPagingList", boardPagingList);
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if ("title".equals(searchType) || "content".equals(searchType) || "title_content".equals(searchType) ||
			"fk_userid".equals(searchType) || !" ".equals(searchWord) ) { 
			mav.addObject("paraMap", paraMap);
		}
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.

		int loop = 1;
		/*
		 * loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		 */

		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
        
		String pageBar = ""; 
        
        // *** [맨처음][이전] 만들기 *** //
        pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1&sportseq="+params+"'>◀◀</a></li>"; 
        
        if(pageNo != 1) {
           pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"&sportseq="+params+"'>◀</a></li>"; 
        }
        
        while( !(loop > blockSize || pageNo > totalPage) ) {
           
           if(pageNo == currentShowPageNo) {
              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
           }
           else {
              pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>"+pageNo+"</a></li>"; 
           }
           loop++;    
           pageNo++;  
        }// end of while( !( ) )--------
        
        // *** [다음][마지막] 만들기 *** //
        
        if(pageNo <= totalPage) { 
           pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>▶</a></li>";
        }
        pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"&sportseq="+params+"'>▶▶</a></li>";
        
        // *** ======= 페이지바 만들기 끝 ======= *** //           
        
        String goBackURL = MyUtil.getCurrentURL(request);		
		
		
        mav.addObject("params", params);
        mav.addObject("paraMap", paraMap);
	    mav.addObject("sizePerPage", sizePerPage);
	    mav.addObject("pageBar", pageBar);
	    mav.addObject("goBackURL", goBackURL);

		mav.setViewName("community/list.tiles2");
		return mav;
	}

	
	
	
	@RequestMapping(value = "/board/boardview.do")
	public ModelAndView view(ModelAndView mav, HttpServletRequest request) {
		String boardseq = "";
		String goBackURL = "";
		String searchType = "";
		String searchWord = "";

		boardseq = request.getParameter("boardseq");
		goBackURL = request.getParameter("goBackURL");
		searchType = request.getParameter("searchType");
		searchWord = request.getParameter("searchWord");

		if (searchType == null) {
			searchType = "";
		}
		if (searchWord == null) {
			searchWord = "";
		}

/*
		System.out.println("확인용 ~~ boardseq : " + boardseq);
		System.out.println("확인용 ~~ goBackURL : " + goBackURL);
		System.out.println("확인용 ~~ searchType : " + searchType);
		System.out.println("확인용 ~~ searchWord : " + searchWord);
 		확인용 ~~ boardseq : 7
		확인용 ~~ goBackURL : /community/list.do?searchType=title&searchWord=%ED%85%8C&sportseq=%2Fcommunity%2Flist.do
		확인용 ~~ searchType : title
		확인용 ~~ searchWord : 테스트
*/
		
		mav.addObject("goBackURL", goBackURL);
		
		try {
			Integer.parseInt(boardseq);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			String login_userid = null;
			if (loginuser != null) {
				login_userid = loginuser.getUserid();
				// login_userid 로그인 되어진 사용자의 userid 이다.
			}

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("boardseq", boardseq);
			paraMap.put("loginuser", login_userid);
			// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 시작 //
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			BoardVO boardvo = null;
	
	
			boardvo = service.getView(paraMap);
	
	
			if (boardvo == null) {
				mav.setViewName("redirect:/list.do");
				return mav;
			}

			mav.addObject("boardvo", boardvo);
			// === #140. 이전글제목, 다음글제목 보기 === //
			mav.addObject("paraMap", paraMap);
			mav.setViewName("board/boardview.tiles1");
			// /WEB-INF/views/tiles1/board/view.jsp 파일을 생성한다.
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/list.do");
		}
	return mav;
	}
	
	
	
	
	
	// === 댓글쓰기(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value = "/addComment.do", produces = "text/plain;charset=UTF-8")
	public String addComment(BoardCommentVO bdcmtvo) {
		// 댓글쓰기에 첨부파일이 없는 경우

		
		int n = 0;
		try {
			n = service.addBoardComment(bdcmtvo);
			// 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기
			// 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update
			// 한다.)
		} catch (Throwable e) {
			e.printStackTrace();
		}

		JSONObject jsonObject = new JSONObject(); // {}
		jsonObject.put("n", n); // 정상일 경우 {"n":1} 문제가 생겼을 경우{"n":0}

		return jsonObject.toString();
		// 정상일 경우 {"n":1, "name":"엄정화"} 문제가 생겼을 경우(point 300 넘을 경우){"n":0, "name":"엄정화"}
	}

	
	
	// === 원 게시물에 딸린 댓글들을 조회해오기(Ajax 로 처리) === //
	@ResponseBody
	@GetMapping(value = "/readComment.do", produces = "text/plain;charset=UTF-8")
	public String readComment(HttpServletRequest request) {
		String parentseq = request.getParameter("parentseq");

		// 원게시물에 딸린 댓글들을 조회해오기
		List<BoardCommentVO> bdcmtList = service.readComment(parentseq);

		JSONArray jsonArr = new JSONArray(); // []

		if (bdcmtList != null) {
			for (BoardCommentVO bdcmtvo : bdcmtList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("boardcommentseq", bdcmtvo.getBoardcommentseq()); 
				jsonObj.put("fk_userid", bdcmtvo.getFk_userid()); 
				jsonObj.put("comment_text", bdcmtvo.getComment_text()); 
				jsonObj.put("registerdate", bdcmtvo.getRegisterdate()); 
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString(); 
	}
	

	
	// === 댓글 삭제(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value = "/deleteComment.do", produces = "text/plain;charset=UTF-8")
	public String deleteComment(HttpServletRequest request) {
		String boardcommentseq = request.getParameter("boardcommentseq");
		String parentseq = request.getParameter("parentseq");
		String userid = request.getParameter("userid");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardcommentseq", boardcommentseq);
		paraMap.put("parentseq", parentseq);
		paraMap.put("userid", userid);
		int n = 0;
		try {
			n = service.deleteComment(paraMap); // 댓글 삭제
		} catch (Throwable e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString(); // {"n":1}
	}

	
	
	
	
	// 댓글 수정(Ajax 로 처리) //
	@ResponseBody
	@PostMapping(value = "/updateComment.do", produces = "text/plain;charset=UTF-8")
	public String updateComment(HttpServletRequest request) {
		String boardcommentseq = request.getParameter("boardcommentseq");
		String content = request.getParameter("content");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardcommentseq", boardcommentseq);
		paraMap.put("comment_text", content);

		int n = service.updateComment(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString(); // {"n":1}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 글쓰기
	@GetMapping("/community/add.do")
	public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// sportseq 값(사이드 선택시)
		
		if(request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}
		
		mav.addObject("params", params);
		
		mav.setViewName("community/add.tiles2");
		return mav;
	}

	// 게시판 글쓰기 완료 요청
	@PostMapping("/community/addEnd.do")
	public ModelAndView addEnd(ModelAndView mav, BoardVO boardvo, HttpServletRequest request) { // <== After Advice 를 사용하기 전
		/*
		 * form 태그의 name 명과 BoardVO 의 필드명이 같다라면 request.getParameter("form 태그의 name명");
		 * 을 사용하지 않더라도 자동적으로 BoardVO boardvo 에 set 되어진다.
		 */
		
		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// sportseq 값(사이드 선택시)
		
		if(request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}
		
		boardvo.setFk_sportseq(params);
		
		mav.addObject("params", params);		

		String filename = boardvo.getFilename();
		if (filename == null) {
			boardvo.setOrgfilename("");
			boardvo.setFilename("");
			boardvo.setFilesize("0");
		}
//		System.out.println(boardvo.getBoardseq());
//		System.out.println(boardvo.getTitle());
//		System.out.println(boardvo.getContent());
//		System.out.println(boardvo.getFk_userid());
//		System.out.println(boardvo.getRegisterdate());
//		System.out.println(boardvo.getPassword());
//		System.out.println(boardvo.getCommentcount());
//		System.out.println(boardvo.getViewcount());
//		System.out.println(boardvo.getStatus());
//		System.out.println(boardvo.getOrgfilename());
//		System.out.println(boardvo.getFilename());
//		System.out.println(boardvo.getFilesize());

		int n = service.add(boardvo); // <== 파일첨부가 없는 글쓰기

		if (n == 1) {
			mav.setViewName("redirect:/community/list.do");
			// /list.do 페이지로 redirect(페이지이동)해라는 말이다.
		} else {
			mav.setViewName("redirect:/community/add.do");
			// /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}

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
	public ModelAndView memberRegisterEnd(HttpServletRequest request, MemberVO membervo, ModelAndView mav) {

		String hp2 = request.getParameter("hp2");
		String hp3 = request.getParameter("hp3");
		String password = request.getParameter("pwd");

		String mobile = "010" + hp2 + hp3;
		membervo.setMobile(mobile);
		membervo.setPassword(password);

//		System.out.println(membervo.getMobile());
//		System.out.println(membervo.getBirthday());
//		System.out.println(membervo.getPassword());
//		System.out.println(membervo.getUserid());
//		System.out.println(membervo.getEmail());
//		System.out.println(membervo.getPostcode());
//		System.out.println(membervo.getAddress());
//		System.out.println(membervo.getDetailaddress());
//		System.out.println(membervo.getExtraaddress());
//		System.out.println(membervo.getGender());

		int n = service.memberRegisterEnd(membervo);

		if (n == 1) {
			mav.setViewName("main/index.tiles2");
		} else {
			mav.setViewName("member/memberRegister.tiles1");
		}

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


	// 동호회 찾기
	@GetMapping("/club/findClub.do")
	public ModelAndView findClub(ModelAndView mav, HttpServletRequest request) {
		
		List<ClubVO> clubList = null;
		List<ClubVO> clubPagingList = null;
		
		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// sportseq 값(사이드 선택시)
		
		if(request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}
		
		String searchType_a = request.getParameter("searchType_a");
		String searchType_b = request.getParameter("searchType_b");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if (searchType_a == null) {
			searchType_a = "rank";
		}
		
		if (searchType_b == null) {
			searchType_b = "none";
		}
		
		if (searchWord == null) {
			searchWord = " ";
		}

		if (searchWord != null) {
			searchWord = searchWord.trim();
		}
		/*
		System.out.println("확인용 ~~ searchType_a : " + searchType_a);
		System.out.println("확인용 ~~ searchType_b : " + searchType_b);
		System.out.println("확인용 ~~ searchWord : " + searchWord);
		System.out.println("확인용 ~~ params : " + params);
		확인용 ~~ searchType_a : rank
		확인용 ~~ searchType_b : none
		확인용 ~~ searchWord : 
		확인용 ~~ params : /club/findClub.do 		
		*/		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType_a", searchType_a);
		paraMap.put("searchType_b", searchType_b);
		paraMap.put("searchWord", searchWord);
		paraMap.put("params", params);
		
		int totalCount = 0; // 총 게시물 건수
		int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
        // 동호회 총 페이지 수(검색포함)
        totalCount = service.getClubSearchTotalPage(paraMap);
//      System.out.println("확인용 ~~ totalCount : " + totalCount);
        // 확인용 ~~ totalCount : 3

        totalPage = (int) Math.ceil((double) totalCount / sizePerPage);
        
        // 게시판에 보여지는 초기화면
		if (str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if (currentShowPageNo < 1 || currentShowPageNo > totalCount) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호

		paraMap.put("startRno", Integer.toString(startRno));
		paraMap.put("endRno", Integer.toString(endRno));
        
        
		// 검색타입 있는 리스트 가져오기(페이징)
		clubPagingList = service.searchPaging(paraMap);
		
		mav.addObject("clubPagingList", clubPagingList);
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if ("rank".equals(searchType_a) || "memberM".equals(searchType_a) || "memberL".equals(searchType_a) ||
			"none".equals(searchType_b) || "seoul".equals(searchType_b) || "busan".equals(searchType_b) || 
			"daegu".equals(searchType_b) || "incheon".equals(searchType_b) || "gwangju".equals(searchType_b) || 
			"daejeon".equals(searchType_b) || "ulsan".equals(searchType_b) || "sejong".equals(searchType_b) || 
			"gyeonggi".equals(searchType_b) || "gangwon".equals(searchType_b) || "chung-cheong_bukdo".equals(searchType_b) || 
			"chung-cheong_namdo".equals(searchType_b) || "jeonbuk".equals(searchType_b) || "jeonnam".equals(searchType_b) || 
			"gyeongbuk".equals(searchType_b) || "gyeongnam".equals(searchType_b) || "jeju".equals(searchType_b) ||
			"".equals(searchWord) ) { 
			
			mav.addObject("paraMap", paraMap);
		}
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.

		int loop = 1;
		/*
		 * loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		 */

		int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
        
		String pageBar = ""; 
        
        // *** [맨처음][이전] 만들기 *** //
        pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a="+searchType_a+"&searchType_b="+searchType_b+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1&sportseq="+params+"'>◀◀</a></li>"; 
        
        if(pageNo != 1) {
           pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a="+searchType_a+"&searchType_b="+searchType_b+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"&sportseq="+params+"'>◀</a></li>"; 
        }
        
        while( !(loop > blockSize || pageNo > totalPage) ) {
           
           if(pageNo == currentShowPageNo) {
              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
           }
           else {
              pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a="+searchType_a+"&searchType_b="+searchType_b+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>"+pageNo+"</a></li>"; 
           }
           loop++;    
           pageNo++;  
        }// end of while( !( ) )--------
        
        // *** [다음][마지막] 만들기 *** //
        
        if(pageNo <= totalPage) { 
           pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a="+searchType_a+"&searchType_b="+searchType_b+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>▶</a></li>";
        }
        pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a="+searchType_a+"&searchType_b="+searchType_b+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"&sportseq="+params+"'>▶▶</a></li>";
        
        // *** ======= 페이지바 만들기 끝 ======= *** //           
        
        String currentURL = MyUtil.getCurrentURL(request);

		// === 페이징 처리를 안한 검색어가 없는 전체 동호회 보여주기 (랭킹 3위까지 사진보여주기 위한 것) === //
		clubList = service.clubListNoSearch(params);
		mav.addObject("clubList", clubList);
		
	    mav.addObject("params", params);
	    mav.addObject("clubPagingList", clubPagingList);
	    mav.addObject("sizePerPage", sizePerPage);
	    mav.addObject("pageBar", pageBar);
	    mav.addObject("currentURL", currentURL);
	   
	    mav.setViewName("/club/findClub.tiles2");
		// /WEB-INF/views/test/modelandview_select.jsp 페이지를 만들어야 한다.

		return mav;
	}
	
	

}
