package com.spring.app.amado.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.MyUtil;
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
		
		List<BoardVO> boardList = null;

		// === 페이징 처리를 안한 검색어가 없는 전체 글목록 보여주기 === //
//		boardList = service.boardListNoSearch();

		// === #110. 페이징 처리를 안한 검색어가 있는 전체 글목록 보여주기 === //
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");

		if (searchType == null) {
			searchType = "title";
		}
		if (searchWord == null) {
			searchWord = "";
		}

		if (searchWord != null) {
			searchWord = searchWord.trim();
		}

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		boardList = service.boardListSearch(paraMap);

		mav.addObject("boardList", boardList);
		mav.addObject("paraMap", paraMap);
		mav.addObject("params", params);

		mav.setViewName("community/list.tiles2");
		return mav;
	}

	// 글쓰기
	@GetMapping("/community/add.do")
	public ModelAndView add(ModelAndView mav) {
		mav.setViewName("community/add.tiles2");
		return mav;
	}

	// 게시판 글쓰기 완료 요청
	@PostMapping("/community/addEnd.do")
	public ModelAndView addEnd(ModelAndView mav, BoardVO boardvo) { // <== After Advice 를 사용하기 전
		/*
		 * form 태그의 name 명과 BoardVO 의 필드명이 같다라면 request.getParameter("form 태그의 name명");
		 * 을 사용하지 않더라도 자동적으로 BoardVO boardvo 에 set 되어진다.
		 */

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
		
		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// 파라미터 부분: 1
		
		if(request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}
		
        // 현재 페이지 번호
        String currentShowPageNo = request.getParameter("currentShowPageNo");
        // 페이지당 보여줄 동호회 수
        String sizePerPage = "10";
        
        int totalCount = 0;
        int totalPage = 0;
        
        // 동호회 총 페이지 수
        totalCount = service.getClubTotalPage(params);
//      System.out.println("확인용~~ totalCount : " + totalCount);
        // 확인용~~ totalCount : 3
        
        if(currentShowPageNo == null) {
           currentShowPageNo = "1";
        }

        totalPage = (int) Math.ceil((double) totalCount / Integer.parseInt(sizePerPage));
        
        
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("params", params);
        paraMap.put("currentShowPageNo", currentShowPageNo);
        paraMap.put("sizePerPage", sizePerPage); 
        
        int no_currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
        int no_sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
        int int_startno = (no_currentShowPageNo * no_sizePerPage) - (no_sizePerPage - 1);
        int int_endno = (no_currentShowPageNo * no_sizePerPage);
        String startno = String.valueOf(int_startno);
        String endno = String.valueOf(int_endno);
        paraMap.put("startno", startno);
        paraMap.put("endno", endno);
        
        try {
        	if( Integer.parseInt(currentShowPageNo) > totalPage || 
                Integer.parseInt(currentShowPageNo) <= 0 ) {
        		
            	currentShowPageNo = "1";
                paraMap.put("currentShowPageNo", currentShowPageNo);
                
            }
        } catch(NumberFormatException e) {
           currentShowPageNo = "1";
           paraMap.put("currentShowPageNo", currentShowPageNo);
        }
        
        String pageBar = "";

        int blockSize = 10;
        // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.

        int loop = 1;
        // loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
        
        // ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== // 
        int pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
        // pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
        
        // *** [맨처음][이전] 만들기 *** //
        pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo=1&sportseq="+params+"'>◀◀</a></li>"; 
        
        if(pageNo != 1) {
           pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"&sportseq="+params+"'>◀</a></li>"; 
        }
        
        while( !(loop > blockSize || pageNo > totalPage) ) {
           
           if(pageNo == Integer.parseInt(currentShowPageNo)) {
              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
           }
           else {
              pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>"+pageNo+"</a></li>"; 
           }
           
           loop++;    
           
           pageNo++;  
                       
        }// end of while( !( ) )--------
        
        // *** [다음][마지막] 만들기 *** //

        
        if(pageNo <= totalPage) { 
           pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>▶</a></li>";
        }
        pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"&sportseq="+params+"'>▶▶</a></li>";
        
        // *** ======= 페이지바 만들기 끝 ======= *** //             
        
        String currentURL = MyUtil.getCurrentURL(request);

		List<ClubVO> clubList = null;
		List<ClubVO> clubPagingList = null;

		// === 페이징 처리를 안한 검색어가 없는 전체 동호회 보여주기 (랭킹 3위까지 사진보여주기 위한 것) === //
		clubList = service.clubListNoSearch(params);
		
	    // === 페이징 처리를 한 검색어가 없는 전체 동호회 보여주기 === //
	    clubPagingList = service.clubListPagingSearch(paraMap);

		
	    mav.addObject("params", params);
	    mav.addObject("clubList", clubList);
	    mav.addObject("clubPagingList", clubPagingList);
	    mav.addObject("sizePerPage", sizePerPage);
	    mav.addObject("pageBar", pageBar);
	    mav.addObject("currentURL", currentURL);
	    mav.setViewName("/club/findClub.tiles2");

		// /WEB-INF/views/test/modelandview_select.jsp 페이지를 만들어야 한다.

		return mav;
	}
	
	
	// 동호회 찾기 검색했을 경우
	@ResponseBody
	@GetMapping(value = "/club/search.do", produces = "text/plain;charset=UTF-8")
	public String searchType_a(HttpServletRequest request) {
		
		String searchType_a = request.getParameter("searchType_a");
		String searchType_b = request.getParameter("searchType_b");
		String searchWord = request.getParameter("searchWord");
		String params = request.getParameter("params");
		
		if (searchWord == null) {
			searchWord = " ";
		}

		if (searchWord != null) {
			searchWord = searchWord.trim();
		}
		
        // 현재 페이지 번호
        String currentShowPageNo = request.getParameter("currentShowPageNo");

        // 페이지당 보여줄 동호회 수
        String sizePerPage = request.getParameter("sizePerPage");
        
        int totalCount = 0;
        int totalPage = 0;
        
        
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType_a", searchType_a);
		paraMap.put("searchType_b", searchType_b);
		paraMap.put("searchWord", searchWord);
		paraMap.put("params", params);
		
        // 동호회 총 페이지 수(검색포함)
        totalCount = service.getClubSearchTotalPage(paraMap);
//      System.out.println("확인용~~ totalCount : " + totalCount);
        // 확인용~~ totalCount : 3

        totalPage = (int) Math.ceil((double) totalCount / Integer.parseInt(sizePerPage));

        paraMap.put("currentShowPageNo", currentShowPageNo);
        paraMap.put("sizePerPage", sizePerPage); 	
		
        
        int no_currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
        int no_sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
        int int_startno = (no_currentShowPageNo * no_sizePerPage) - (no_sizePerPage - 1);
        int int_endno = (no_currentShowPageNo * no_sizePerPage);
        String startno = String.valueOf(int_startno);
        String endno = String.valueOf(int_endno);
        paraMap.put("startno", startno);
        paraMap.put("endno", endno);
        
        try {
        	if( Integer.parseInt(currentShowPageNo) > totalPage || 
                Integer.parseInt(currentShowPageNo) <= 0 ) {
        		
            	currentShowPageNo = "1";
                paraMap.put("currentShowPageNo", currentShowPageNo);
                
            }
        } catch(NumberFormatException e) {
           currentShowPageNo = "1";
           paraMap.put("currentShowPageNo", currentShowPageNo);
        }
        
        String pageBar = "";

        int blockSize = 10;
        // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.

        int loop = 1;
        // loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
        
        // ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== // 
        int pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
        // pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
        
        // *** [맨처음][이전] 만들기 *** //
        pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo=1&sportseq="+params+"'>◀◀</a></li>"; 
        
        if(pageNo != 1) {
           pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"&sportseq="+params+"'>◀</a></li>"; 
        }
        
        while( !(loop > blockSize || pageNo > totalPage) ) {
           
           if(pageNo == Integer.parseInt(currentShowPageNo)) {
              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
           }
           else {
              pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>"+pageNo+"</a></li>"; 
           }
           
           loop++;    
           
           pageNo++;  
                       
        }// end of while( !( ) )--------
        
        // *** [다음][마지막] 만들기 *** //

        
        if(pageNo <= totalPage) { 
           pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"&sportseq="+params+"'>▶</a></li>";
        }
        pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"&sportseq="+params+"'>▶▶</a></li>";
        
        // *** ======= 페이지바 만들기 끝 ======= *** //             
        
        String currentURL = MyUtil.getCurrentURL(request);      
        
		List<ClubVO> clubList = null;
		
		// 검색타입 있는 리스트 가져오기
//		clubList = service.search(paraMap);

		// 검색타입 있는 리스트 가져오기(페이징)
		clubList = service.searchPaging(paraMap);
		
		
		JSONArray jsonArr = new JSONArray(); // []

		if (clubList != null) {
			for (ClubVO clubvo : clubList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("rank", clubvo.getRank()); 
				jsonObj.put("city", clubvo.getCity()); 
				jsonObj.put("clubgym", clubvo.getClubgym()); 
				jsonObj.put("clubimg", clubvo.getClubimg()); 
				jsonObj.put("clubname", clubvo.getClubname()); 
				jsonObj.put("clubpay", clubvo.getClubpay()); 
				jsonObj.put("clubscore", clubvo.getClubscore()); 
				jsonObj.put("clubseq", clubvo.getClubseq()); 
				jsonObj.put("clubstatus", clubvo.getClubstatus()); 
				jsonObj.put("clubtel", clubvo.getClubtel()); 
				jsonObj.put("clubtime", clubvo.getClubtime()); 
				jsonObj.put("fk_sportseq", clubvo.getFk_sportseq()); 
				jsonObj.put("local", clubvo.getLocal()); 
				jsonObj.put("membercount", clubvo.getMembercount()); 
				jsonObj.put("rank", clubvo.getRank()); 

				jsonObj.put("searchType_a", searchType_a); 
				jsonObj.put("searchType_b", searchType_b); 
				 
				jsonObj.put("params", params); 
				jsonObj.put("sizePerPage", sizePerPage); 
				jsonObj.put("pageBar", pageBar); 
				jsonObj.put("currentURL", currentURL);

				jsonArr.put(jsonObj);
			}
		}
		
		request.setAttribute("pageBar", pageBar);

		return jsonArr.toString();
	}

}
