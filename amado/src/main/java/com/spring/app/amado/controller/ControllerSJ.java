package com.spring.app.amado.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.FileManager;
import com.spring.app.common.GoogleMail;
import com.spring.app.common.MyUtil;
import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.InquiryAnswersVO;
import com.spring.app.domain.InquiryFileVO;
import com.spring.app.domain.InquiryVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.service.AmadoService_SJ;

@Controller
public class ControllerSJ {
	// 승진님 컨트롤러

	@Autowired
	private AmadoService_SJ service;

	@Autowired
	private FileManager fileManager;

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

		if (request.getParameter("sportseq") != null) {
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
		} else {
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
		if ("title".equals(searchType) || "content".equals(searchType) || "title_content".equals(searchType)
				|| "fk_userid".equals(searchType) || !" ".equals(searchWord)) {
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
		pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType=" + searchType + "&searchWord="
				+ searchWord + "&sizePerPage=" + sizePerPage + "&currentShowPageNo=1&sportseq=" + params
				+ "'>◀◀</a></li>";

		if (pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType=" + searchType
					+ "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage + "&currentShowPageNo=" + (pageNo - 1)
					+ "&sportseq=" + params + "'>◀</a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {

			if (pageNo == currentShowPageNo) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
			} else {
				pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType=" + searchType
						+ "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage + "&currentShowPageNo=" + pageNo
						+ "&sportseq=" + params + "'>" + pageNo + "</a></li>";
			}
			loop++;
			pageNo++;
		} // end of while( !( ) )--------

		// *** [다음][마지막] 만들기 *** //

		if (pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType=" + searchType
					+ "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage + "&currentShowPageNo=" + pageNo
					+ "&sportseq=" + params + "'>▶</a></li>";
		}
		pageBar += "<li class='page-item'><a class='page-link' href='list.do?searchType=" + searchType + "&searchWord="
				+ searchWord + "&sizePerPage=" + sizePerPage + "&currentShowPageNo=" + totalPage + "&sportseq=" + params
				+ "'>▶▶</a></li>";

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
		 * System.out.println("확인용 ~~ boardseq : " + boardseq);
		 * System.out.println("확인용 ~~ goBackURL : " + goBackURL);
		 * System.out.println("확인용 ~~ searchType : " + searchType);
		 * System.out.println("확인용 ~~ searchWord : " + searchWord); 확인용 ~~ boardseq : 7
		 * 확인용 ~~ goBackURL :
		 * /community/list.do?searchType=title&searchWord=%ED%85%8C&sportseq=%
		 * 2Fcommunity%2Flist.do 확인용 ~~ searchType : title 확인용 ~~ searchWord : 테스트
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
				mav.setViewName("redirect:/community/list.do");
				return mav;
			}

			mav.addObject("boardvo", boardvo);
			// === 이전글제목, 다음글제목 보기 === //
			mav.addObject("paraMap", paraMap);
			mav.setViewName("board/boardview.tiles1");
			// /WEB-INF/views/tiles1/board/view.jsp 파일을 생성한다.
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/community/list.do");
		}
		return mav;
	}

	// === 댓글쓰기(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value = "/board/addCommentSJ", produces = "text/plain;charset=UTF-8")
	public String addComment(BoardCommentVO boardcommentvo) {
		// 댓글쓰기에 첨부파일이 없는 경우

		int n = 0;
		try {
			n = service.addBoardComment(boardcommentvo);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		JSONObject jsonObject = new JSONObject(); // {}
		jsonObject.put("n", n); // 정상일 경우 {"n":1} 문제가 생겼을 경우{"n":0}

		return jsonObject.toString();
		// 정상일 경우 {"n":1, "name":"엄정화"} 문제가 생겼을 경우(point 300 넘을 경우){"n":0, "name":"엄정화"}
	}

	// === 답글쓰기(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value = "/addReply.do", produces = "text/plain;charset=UTF-8")
	public String addReply(HttpServletRequest request) {
		// 댓글쓰기에 첨부파일이 없는 경우
		String fk_boardcommentseq = request.getParameter("boardcommentseq");
		String parentseq = request.getParameter("parentseq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		String fk_userid = request.getParameter("fk_userid");
		String comment_text = request.getParameter("comment_text");

		/*
		 * System.out.println("~~ 확인용 fk_boardcommentseq : " + fk_boardcommentseq);
		 * System.out.println("~~ 확인용 parentseq : " + parentseq);
		 * System.out.println("~~ 확인용 groupno : " + groupno);
		 * System.out.println("~~ 확인용 depthno : " + depthno);
		 * System.out.println("~~ 확인용 fk_userid : " + fk_userid);
		 * System.out.println("~~ 확인용 comment_text : " + comment_text);
		 */

		if (fk_userid == null) {
			// 어차피 로그인 해야만 보이기 때문에 필요없는 과정이지만 혹시 모르니 만들었다.
			fk_userid = " ";
		}
//		System.out.println("~~ 확인용 fk_userid : " + fk_userid);

		int n = 0;

		BoardCommentVO boardcommentvo = new BoardCommentVO();

		boardcommentvo.setFk_boardcommentseq(fk_boardcommentseq);
		boardcommentvo.setGroupno(groupno);
		boardcommentvo.setDepthno(depthno);
		boardcommentvo.setParentseq(parentseq);
		boardcommentvo.setComment_text(comment_text);
		boardcommentvo.setFk_userid(fk_userid);

		if (boardcommentvo != null) {
			n = service.addReply(boardcommentvo); // 답글쓰기
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
				jsonObj.put("parentseq", bdcmtvo.getParentseq());
				jsonObj.put("fk_userid", bdcmtvo.getFk_userid());
				jsonObj.put("comment_text", bdcmtvo.getComment_text());
				jsonObj.put("registerdate", bdcmtvo.getRegisterdate());
				jsonObj.put("groupno", bdcmtvo.getGroupno());
				jsonObj.put("fk_boardcommentseq", bdcmtvo.getFk_boardcommentseq());
				jsonObj.put("depthno", bdcmtvo.getDepthno());

				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}

	// === #183. 첨부파일 다운로드 받기 === //
	@GetMapping("/download.do")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {

		String boardseq = request.getParameter("boardseq");
		// 첨부파일이 있는 글번호

		/*
		 * 첨부파일이 있는 글번호에서 20240628092043154731282615400.jpg 처럼 이러한 fileName 값을 DB에서 가져와야
		 * 한다. 또한 orgFilename 값도 DB에서 가져와야 한다.
		 */

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardseq", boardseq);
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");

		// **** 웹브라우저에 출력하기 시작 **** //
		// HttpServletResponse response 객체는 전송되어져온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다.
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

		try {
			Integer.parseInt(boardseq);
			BoardVO boardvo = service.getView_no_increase_readCount(paraMap);

			if (boardvo == null || (boardvo != null && boardvo.getFilename() == null)) {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

				out.println(
						"<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}

			else {
				// 정상적으로 다운로드를 할 경우

				String filename = boardvo.getFilename();
				// 20240628092043154731282615400.jpg 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.

				String orgfilename = boardvo.getOrgfilename();
				// 쉐보레전면.jpg 다운로드시 보여줄 파일명

				// 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
				// 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
				// WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");

				// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
				// ~~~ 확인용 webapp 의 절대경로 =>
				// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\

				String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";
				/*
				 * File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 File.separator
				 * 는 "\" 이고, 운영체제가 UNIX, Linux, 매킨토시(맥) 이라면 File.separator 는 "/" 이다.
				 */

				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				// System.out.println("~~~ 확인용 path => " + path);
				// ~~~ 확인용 path =>
				// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files

				// ***** file 다운로드 하기 ***** //
				boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도
				flag = fileManager.doFileDownload(filename, orgfilename, path, response);
				// file 다운로드 성공시 flag 는 true,
				// file 다운로드 실패시 flag 는 false 를 가진다.

				if (!flag) {
					// 다운로드가 실패한 경우 메시지를 띄워준다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

					out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
				}

			}

		} catch (NumberFormatException | IOException e) {

			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e2) {
				e2.printStackTrace();
			}

		}

	}

	// === 1대1문의 첨부파일 다운로드 받기 === //
	@GetMapping("/inquirydownload.do")
	public void requiredLogin_inquirydownload(HttpServletRequest request, HttpServletResponse response) {

		String inquiryseq = request.getParameter("inquiryseq");
		String orgfilename = request.getParameter("orgfilename");
		// 첨부파일이 있는 글번호

		/*
		 * 첨부파일이 있는 글번호에서 20240628092043154731282615400.jpg 처럼 이러한 fileName 값을 DB에서 가져와야
		 * 한다. 또한 orgFilename 값도 DB에서 가져와야 한다.
		 */

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("inquiryseq", inquiryseq);
		paraMap.put("orgfilename", orgfilename);

		// **** 웹브라우저에 출력하기 시작 **** //
		// HttpServletResponse response 객체는 전송되어져온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다.
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

		try {
			Integer.parseInt(inquiryseq);
			InquiryFileVO inquiryfilevo = service.getView_inquiry(paraMap);

			if (inquiryfilevo == null || (inquiryfilevo != null && inquiryfilevo.getFilename() == null)) {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

				out.println(
						"<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}

			else {
				// 정상적으로 다운로드를 할 경우

				String filename = inquiryfilevo.getFilename();
				// 20240628092043154731282615400.jpg 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.

				// 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
				// 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
				// WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");

				// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
				// ~~~ 확인용 webapp 의 절대경로 =>
				// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\amado\

				String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";
				/*
				 * File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 File.separator
				 * 는 "\" 이고, 운영체제가 UNIX, Linux, 매킨토시(맥) 이라면 File.separator 는 "/" 이다.
				 */

				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				// System.out.println("~~~ 확인용 path => " + path);
				// ~~~ 확인용 path =>
				// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files

				// ***** file 다운로드 하기 ***** //
				boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도
				flag = fileManager.doFileDownload(filename, orgfilename, path, response);
				// file 다운로드 성공시 flag 는 true,
				// file 다운로드 실패시 flag 는 false 를 가진다.

				if (!flag) {
					// 다운로드가 실패한 경우 메시지를 띄워준다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

					out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
				}

			}

		} catch (NumberFormatException | IOException e) {

			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e2) {
				e2.printStackTrace();
			}

		}

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

		int n = 0;
		try {
			n = service.updateComment(paraMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString(); // {"n":1}
	}

	// 답글 수정(Ajax 로 처리) //
	@ResponseBody
	@PostMapping(value = "/updateCommentSJ.do", produces = "text/plain;charset=UTF-8")
	public String updateCommentSJ(HttpServletRequest request) {
		String boardcommentseq = request.getParameter("boardcommentseq");
		String content = request.getParameter("content");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("boardcommentseq", boardcommentseq);
		paraMap.put("comment_text", content);

		int n = 0;
		
		try {
			n = service.updateComment(paraMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);

		return jsonObj.toString(); // {"n":1}
	}

	// 답글 읽기
	@ResponseBody
	@PostMapping(value = "/readReplyCommentSJ.do", produces = "text/plain;charset=UTF-8")
	public String addReplyComment(HttpServletRequest request) {

		String boardcommentseq = request.getParameter("boardcommentseq");

		// System.out.println(fleamarketcommentseq);
		List<BoardCommentVO> commentreList = service.getCommentreList(boardcommentseq);

		JSONArray jsonArr = new JSONArray(); // []

		if (commentreList != null) {
			for (BoardCommentVO commentrevo : commentreList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("boardcommentseq", commentrevo.getBoardcommentseq());
				jsonObj.put("comment_text", commentrevo.getComment_text());
				jsonObj.put("depthno", commentrevo.getDepthno());
				jsonObj.put("fk_boardcommentseq", commentrevo.getFk_boardcommentseq());
				jsonObj.put("fk_userid", commentrevo.getFk_userid());
				jsonObj.put("groupno", commentrevo.getGroupno());
				jsonObj.put("parentseq", commentrevo.getParentseq());
				jsonObj.put("registerdate", commentrevo.getRegisterdate());

				jsonArr.put(jsonObj);
			} // end of for-----------------------
		}

		return jsonArr.toString();
	}

	// 글쓰기
	@GetMapping("/community/add.do")
	public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);

		if (request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}

		mav.addObject("params", params);

		mav.setViewName("community/add.tiles2");
		return mav;
	}

	// 게시판 글쓰기 완료 요청
	@PostMapping("/community/addEnd.do")
	public ModelAndView addEnd(Map<String, String> paraMap, ModelAndView mav, BoardVO boardvo,
			HttpServletRequest request, MultipartHttpServletRequest mrequest) {
		/*
		 * form 태그의 name 명과 BoardVO 의 필드명이 같다라면 request.getParameter("form 태그의 name명");
		 * 을 사용하지 않더라도 자동적으로 BoardVO boardvo 에 set 되어진다.
		 */

		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// sportseq 값(사이드 선택시)

		if (request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}

		boardvo.setFk_sportseq(params);

		mav.addObject("params", params);

		// === 첨부파일이 있는 경우 작업 시작 !!! ===
		MultipartFile attach = boardvo.getAttach();

		if (attach != null) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)

			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
			// ~~~ 확인용 webapp 의 절대경로 =>
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\

			String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";

			// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기

			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것

			long fileSize = 0;
			// 첨부파일의 크기

			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것

				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.

				System.out.println("~~~ 확인용 originalFilename => " + originalFilename);
				// ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf

				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하는 것이다.

				System.out.println("~~~ 확인용 newFileName => " + newFileName);
				// ~~~ 확인용 newFileName => 2024062712072778335865583700.jpg

				// 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기

				boardvo.setFilename(newFileName);
				// WAS(톰캣)에 저장된 파일명(2024062712072778335865583700.jpg)

				boardvo.setOrgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(쉐보레전면.jpg)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.

				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				boardvo.setFilesize(String.valueOf(fileSize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		// === 첨부파일이 있는 경우 작업 끝 !!! ===

		int n = 0;

		if (attach.isEmpty()) {
			// 파일첨부가 없는 경우라면

			String filename = boardvo.getFilename();
			if (filename == null) {
				boardvo.setOrgfilename("");
				boardvo.setFilename("");
				boardvo.setFilesize("0");
			}

			n = service.add(boardvo); // <== 파일첨부가 없는 글쓰기
		} else {
			// 파일첨부가 있는 경우라면
			n = service.add_withFile(boardvo);
		}

		if (n == 1) {
			mav.setViewName("redirect:/community/list.do");
			// /list.do 페이지로 redirect(페이지이동)해라는 말이다.
		} else {
			mav.setViewName("redirect:/community/add.do");
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
	public ModelAndView memberRegisterEnd(HttpServletRequest request, MemberVO membervo, ModelAndView mav, MultipartHttpServletRequest mrequest) {

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
		
		
		// === 첨부파일이 있는 경우 작업 시작 !!! ===
		MultipartFile attach = membervo.getAttach();
		
		if (attach != null) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)

			String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\images";
			
			// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기

			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것

			long fileSize = 0;
			// 첨부파일의 크기
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것

				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.

//             	System.out.println("~~~ 확인용 originalFilename => " + originalFilename); 
				// ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf

				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하는 것이다.

//				System.out.println("~~~ 확인용 newFileName => " + newFileName);  
				// ~~~ 확인용 newFileName => 2024062712072778335865583700.jpg

				// 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기

				membervo.setMemberimg(newFileName);
				// WAS(톰캣)에 저장된 파일명(2024062712072778335865583700.jpg)

				membervo.setOrgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(쉐보레전면.jpg)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.

				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				// membervo.setFilesize(String.valueOf(fileSize));

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
			int n = 0;

			if (attach.isEmpty()) {
				// 파일첨부가 없는 경우라면

				String filename = membervo.getMemberimg();
				if (filename == null) {
					membervo.setOrgfilename("");
					membervo.setMemberimg("");
					//membervo.setFilesize("0");
				}
			
				n = service.memberRegisterEnd(membervo);

			} else {
				// 파일첨부가 있는 경우라면
				n = service.memberRegisterEnd_withFile(membervo);
			}
				
		if (n == 1) {
			mav.setViewName("main/index.tiles2");
		} else {
			mav.setViewName("member/memberRegister.tiles1");
		}

		return mav;
	}

	// === 글을 수정하는 페이지 요청 === //
	@GetMapping("/board/edit.do")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		// 글 수정해야 할 글번호 가져오기
		String boardseq = request.getParameter("boardseq");
		String fk_sportseq = request.getParameter("sportseq");

		String message = "";

		try {
			Integer.parseInt(boardseq);

			// 글 수정해야 할 글 1개 내용가져오기
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("boardseq", boardseq);
			paraMap.put("fk_sportseq", fk_sportseq);

			BoardVO boardvo = service.getView_no_increase_readCount(paraMap);
			// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것

			if (boardvo == null) {
				message = "글 수정이 불가합니다.";
			} else {
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				if (!loginuser.getUserid().equals(boardvo.getFk_userid())) {
					message = "다른 사용자의 글은 수정이 불가합니다.";
				} else {
					// 자신의 글을 수정할 경우
					// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
					mav.addObject("boardvo", boardvo);
					mav.setViewName("board/edit.tiles1");

					return mav;
				}
			}

		} catch (NumberFormatException e) {
			message = "글 수정이 불가합니다.";
		}

		String loc = "javascript:history.back()";
		mav.addObject("message", message);
		mav.addObject("loc", loc);

		mav.setViewName("msg");

		return mav;
	}

	// === 글을 수정하는 페이지 완료하기 === //
	@PostMapping("/board/editEnd.do")
	public ModelAndView editEnd(ModelAndView mav, BoardVO boardvo, HttpServletRequest request,
			MultipartHttpServletRequest mrequest) {

		// === 첨부파일이 있는 경우 작업 시작 !!! ===
		MultipartFile attach = boardvo.getAttach();

		if (attach != null) {
			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)

			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");

			// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
			// ~~~ 확인용 webapp 의 절대경로 =>
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\

			String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";

			// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기

			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것

			long fileSize = 0;
			// 첨부파일의 크기

			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것

				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.

//             	System.out.println("~~~ 확인용 originalFilename => " + originalFilename); 
				// ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf

				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하는 것이다.

//				System.out.println("~~~ 확인용 newFileName => " + newFileName);  
				// ~~~ 확인용 newFileName => 2024062712072778335865583700.jpg

				// 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기

				boardvo.setFilename(newFileName);
				// WAS(톰캣)에 저장된 파일명(2024062712072778335865583700.jpg)

				boardvo.setOrgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(쉐보레전면.jpg)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.

				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				boardvo.setFilesize(String.valueOf(fileSize));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		// === 첨부파일이 있는 경우 작업 끝 !!! ===

		int n = 0;

		if (attach.isEmpty()) {
			// 파일첨부가 없는 경우라면

			String filename = boardvo.getFilename();
			if (filename == null) {
				boardvo.setOrgfilename("");
				boardvo.setFilename("");
				boardvo.setFilesize("0");
			}

			n = service.edit(boardvo); // <== 파일첨부가 없는 글쓰기
		} else {
			// 파일첨부가 있는 경우라면
			n = service.edit_withFile(boardvo);
		}

		if (n == 1) {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath() + "/board/boardview.do?boardseq=" + boardvo.getBoardseq());
			mav.setViewName("msg");
		}

		return mav;
	}

	// === #76. 글을 삭제하는 페이지 요청 === //
	@GetMapping("/board/del.do")
	public ModelAndView requiredLogin_del(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		// 글 삭제해야 할 글번호 가져오기
		String boardseq = request.getParameter("boardseq");

		String message = "";

		try {
			Integer.parseInt(boardseq);

			// 글 삭제해야 할 글 1개 내용가져오기
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("boardseq", boardseq);

			BoardVO boardvo = service.getView_no_increase_readCount(paraMap);
			// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것

			if (boardvo == null) {
				message = "글 삭제가 불가합니다.";
			} else {
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				if (!loginuser.getUserid().equals(boardvo.getFk_userid())) {
					message = "다른 사용자의 글은 삭제가 불가합니다.";
				} else {
					// 자신의 글을 삭제할 경우
					// 가져온 1개글을 글삭제할 폼이 있는 view 단으로 보내준다.
					mav.addObject("boardvo", boardvo);
					mav.setViewName("board/del.tiles1");

					return mav;
				}
			}

		} catch (NumberFormatException e) {
			message = "글 삭제가 불가합니다.";
		}

		String loc = "javascript:history.back()";
		mav.addObject("message", message);
		mav.addObject("loc", loc);

		mav.setViewName("msg");

		return mav;
	}

	// === 글을 삭제하는 페이지 완료하기 === //
	@PostMapping("/board/delEnd.do")
	public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {

		String boardseq = request.getParameter("boardseq");

		/////////////////////////////////////////////////
		// === #184. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작 === //
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		paraMap.put("boardseq", boardseq);

		BoardVO boardvo = service.getView_no_increase_readCount(paraMap);

		String filename = boardvo.getFilename();
		// 20240701090317412881263349800.pdf 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.

		if (filename != null && !"".equals(filename)) {

			// 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
			// 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");

			// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
			// ~~~ 확인용 webapp 의 절대경로 =>
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\

			String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";
			/*
			 * File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 운영체제가 Windows 이라면 File.separator
			 * 는 "\" 이고, 운영체제가 UNIX, Linux, 매킨토시(맥) 이라면 File.separator 는 "/" 이다.
			 */

			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			// System.out.println("~~~ 확인용 path => " + path);
			// ~~~ 확인용 path =>
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files

			paraMap.put("path", path); // 삭제해야할 파일이 저장된 경로
			paraMap.put("filename", filename); // 삭제해야할 파일명
		}
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝 === //

		/////////////////////////////////////////////////

		int n = service.del(paraMap);

		if (n == 1) {
			mav.addObject("message", "글 삭제 성공!!");
			mav.addObject("loc", request.getContextPath() + "/community/list.do");
			mav.setViewName("msg");
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

	// 메인페이지
	@GetMapping("/club/mainClubRank.do")
	public ModelAndView mainClubRank(ModelAndView mav, HttpServletRequest request) {
		
		List<ClubVO> clubList = null;
		List<ClubVO> clubPagingList = null;

		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// sportseq 값(사이드 선택시)

		if (request.getParameter("sportseq") != null) {
			params = request.getParameter("sportseq");
		}
		
		System.out.println("params : " + params);

		String currentURL = MyUtil.getCurrentURL(request);

		// === 페이징 처리를 안한 검색어가 없는 전체 동호회 보여주기 (랭킹 3위까지 사진보여주기 위한 것) === //
		clubList = service.clubListNoSearch(params);
		mav.addObject("clubList", clubList);

		mav.addObject("params", params);	
		
		mav.setViewName("/main/index.tiles2");
		
		return mav;
	}
	
	
	// 동호회 찾기
	@GetMapping("/club/findClub.do")
	public ModelAndView findClub(ModelAndView mav, HttpServletRequest request) {

		List<ClubVO> clubList = null;
		List<ClubVO> clubPagingList = null;

		String url = MyUtil.getCurrentURL(request);
		String params = url.substring(url.indexOf('=') + 1);
		// sportseq 값(사이드 선택시)

		if (request.getParameter("sportseq") != null) {
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
		 * System.out.println("확인용 ~~ searchType_a : " + searchType_a);
		 * System.out.println("확인용 ~~ searchType_b : " + searchType_b);
		 * System.out.println("확인용 ~~ searchWord : " + searchWord);
		 * System.out.println("확인용 ~~ params : " + params); 확인용 ~~ searchType_a : rank
		 * 확인용 ~~ searchType_b : none 확인용 ~~ searchWord : 확인용 ~~ params :
		 * /club/findClub.do
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
		} else {
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

		// == 동호회 가입하기 만들기 == //

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if (loginuser != null) {
			String fk_userid = loginuser.getUserid();
			request.setAttribute("fk_userid", fk_userid);

			// 내가 가입한 클럽 가져오기
			try {
				List<ClubmemberVO> clubmemberList = service.getClubmemberList(fk_userid);

				for (ClubVO clubvo : clubPagingList) {
					for (ClubmemberVO clubmembervo : clubmemberList) {
						if (clubvo.getClubseq().equals(clubmembervo.getClubseq())) {
							clubvo.setClubmembervo(clubmembervo);
						}
					}
				}

			} catch (Exception e) {
				// TODO: handle exception
			}

		}

		// == 동호회 가입하기 만들기 끝 == //

		mav.addObject("clubPagingList", clubPagingList);

		// 검색시 검색조건 및 검색어 값 유지시키기
		if ("rank".equals(searchType_a) || "memberM".equals(searchType_a) || "memberL".equals(searchType_a)
				|| "none".equals(searchType_b) || "seoul".equals(searchType_b) || "busan".equals(searchType_b)
				|| "daegu".equals(searchType_b) || "incheon".equals(searchType_b) || "gwangju".equals(searchType_b)
				|| "daejeon".equals(searchType_b) || "ulsan".equals(searchType_b) || "sejong".equals(searchType_b)
				|| "gyeonggi".equals(searchType_b) || "gangwon".equals(searchType_b)
				|| "chung-cheong_bukdo".equals(searchType_b) || "chung-cheong_namdo".equals(searchType_b)
				|| "jeonbuk".equals(searchType_b) || "jeonnam".equals(searchType_b) || "gyeongbuk".equals(searchType_b)
				|| "gyeongnam".equals(searchType_b) || "jeju".equals(searchType_b) || "".equals(searchWord)) {

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
		pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a=" + searchType_a
				+ "&searchType_b=" + searchType_b + "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage
				+ "&currentShowPageNo=1&sportseq=" + params + "'>◀◀</a></li>";

		if (pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a=" + searchType_a
					+ "&searchType_b=" + searchType_b + "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage
					+ "&currentShowPageNo=" + (pageNo - 1) + "&sportseq=" + params + "'>◀</a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {

			if (pageNo == currentShowPageNo) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
			} else {
				pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a=" + searchType_a
						+ "&searchType_b=" + searchType_b + "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage
						+ "&currentShowPageNo=" + pageNo + "&sportseq=" + params + "'>" + pageNo + "</a></li>";
			}
			loop++;
			pageNo++;
		} // end of while( !( ) )--------

		// *** [다음][마지막] 만들기 *** //

		if (pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a=" + searchType_a
					+ "&searchType_b=" + searchType_b + "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage
					+ "&currentShowPageNo=" + pageNo + "&sportseq=" + params + "'>▶</a></li>";
		}
		pageBar += "<li class='page-item'><a class='page-link' href='findClub.do?searchType_a=" + searchType_a
				+ "&searchType_b=" + searchType_b + "&searchWord=" + searchWord + "&sizePerPage=" + sizePerPage
				+ "&currentShowPageNo=" + totalPage + "&sportseq=" + params + "'>▶▶</a></li>";

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

	// 1:1 문의하기

	@GetMapping("/community/inquiry.do")
	public String requiredLogin_inquiry(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_userid = loginuser.getUserid();

		loginuser = service.getMemberInfo(fk_userid);

		request.setAttribute("fk_userid", fk_userid);
		request.setAttribute("loginuser", loginuser);
		return "community/inquiry.tiles2";
	}

	@ResponseBody
	@PostMapping(value = "/community/inquiryEnd.do", produces = "text/plain;charset=UTF-8")
	public String inquiryEnd(ModelAndView mav, HttpServletRequest request, MultipartHttpServletRequest mrequest) {

		String title = request.getParameter("title");
		String searchtype_a = request.getParameter("searchtype_a");
		String searchtype_b = request.getParameter("searchtype_b");
		String content = request.getParameter("content");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String fk_userid = request.getParameter("fk_userid");
		System.out.println("확인용~~ title : " + title);
		System.out.println("확인용~~ searchType_a : " + searchtype_a);
		System.out.println("확인용~~ searchType_b : " + searchtype_b);
		System.out.println("확인용~~ content : " + content);
		System.out.println("확인용~~ email : " + email);
		System.out.println("확인용~~ phone : " + phone);
		System.out.println("확인용~~ fk_userid : " + fk_userid);

		List<MultipartFile> fileList = mrequest.getFiles("file_arr");

		HttpSession session = mrequest.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = "C:\\git\\amado\\amado\\src\\main\\webapp\\resources\\file";

		File dir = new File(path);
		if (!dir.exists()) {
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\email_attach_file
			// \email_attach_file 폴더가 생성되었는지 확인하고 없으면 만든다.
			dir.mkdirs();
		}

		// >>>> 첨부파일을 위의 path 경로에 올리기 <<<< //
		String[] arr_attachFilename = null; // 첨부파일명들을 기록하기 위한 용도

		JSONObject jsonObj = new JSONObject();
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("title", title);
		paraMap.put("searchtype_a", searchtype_a);
		paraMap.put("searchtype_b", searchtype_b);
		paraMap.put("content", content);
		paraMap.put("email", email);
		paraMap.put("phone", phone);
		paraMap.put("fk_userid", fk_userid);

		int result = 0;

		// 파일첨부가 없는 1대1 문의
		result = service.Inquiry(paraMap);

		if (fileList != null && fileList.size() > 0) {

			int inquiryseq = service.findseq_inquiry(paraMap);

			jsonObj.put("inquiryseq", inquiryseq);

			paraMap.put("inquiryseq", inquiryseq);

			// 배열의 크기를 정해주고
			arr_attachFilename = new String[fileList.size()];

			for (int i = 0; i < fileList.size(); i++) {

				MultipartFile mtfile = fileList.get(i);
				System.out.println("파일명 : " + mtfile.getOriginalFilename() + " / 파일크기 : " + mtfile.getSize());
				/*
				 * 파일명 : berkelekle심플라운드01.jpg / 파일크기 : 71317 파일명 : Electrolux냉장고_사용설명서.pdf /
				 * 파일크기 : 791567 파일명 : 쉐보레전면.jpg / 파일크기 : 131110
				 */

				// 다중파일 할 때 파일명 (여기서는 메일만 보내기 때문에 하지 않는다)
				// FileManager 에 doFileUpload (게시판에 파일첨부에 있다) 숫자로 되어진 새로운 파일이름을 받아오는데
				// for 문 안에 있기 때문에 return 타입이 숫자. (DB 에 넣어줘야하는데)
				// DB 설계를 -> 컬럼명 filename1 , 컬럼명 filename2, 컬럼명 filename3 이런식으로 하면 안된다.
				// 만약 첨부파일이 DB 보다 많을 경우 문제가 있고, 하나만 넣었을 경우 나머지는 모두 null 값이기 때문에
				// 첨부파일은 자식테이블로 만들어야한다!!
				// seq 채번해서 가져온다.
				// fk_부모seq 로 해서 가져온다. ( fk_부모seq = 101, filename = ex.pdf , fk_부모seq = 101,
				// filename = ex23.pdf) 이런식으로
				// 즉, for 문을 사용해서 insert를 해주면 된다.

				try {
					/*
					 * File 클래스는 java.io 패키지에 포함되며, 입출력에 필요한 파일이나 디렉터리를 제어하는 데 사용된다. 파일과 디렉터리의 접근
					 * 권한, 생성된 시간, 경로 등의 정보를 얻을 수 있는 메소드가 있으며, 새로운 파일 및 디렉터리 생성, 삭제 등 다양한 조작 메서드를
					 * 가지고 있다.
					 */

					// 첨부파일이 있을 경우
					// 첨부파일의 경로
					paraMap.put("path", path); // path 는 첨부파일들이 저장된 WAS(톰캣)의 폴더의 경로명이다.
					paraMap.put("orgfilename", mtfile.getOriginalFilename());
					paraMap.put("filesize", mtfile.getSize());

					// 시분초로 되어있는 파일명

					String newFileName = "";
					// WAS(톰캣)의 디스크에 저장될 파일명(나노타임)

					byte[] bytes = null;
					// 첨부파일의 내용물을 담는 것

					bytes = mtfile.getBytes();
					// 첨부파일의 내용물을 읽어오는 것

					String originalFilename = mtfile.getOriginalFilename();
					// mtfile.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.

					try {
						newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
						System.out.println("newFileName : " + newFileName);
						paraMap.put("filename", newFileName);
						// newFileName : 20240627131107274413505051000.jpg
					} catch (Exception e) {
						e.printStackTrace();
					}

					// 파일첨부가 있는 1대1 문의
					result = service.InquiryFile(paraMap);

					// === MultipartFile 을 File 로 변환하여 탐색기 저장폴더에 저장하기 시작 === //

					File attachFile = new File(path + File.separator + mtfile.getOriginalFilename());
					// spring 에서 파일을 전송해주는 메소드 void
					// org.springframework.web.multipart.MultipartFile.transferTo(File dest)
					mtfile.transferTo(attachFile); // 이것이 파일을 업로드해주는 것이다!!

					/*
					 * form 태그로 부터 전송받은 MultipartFile mtfile 파일을 지정된 대상 파일(attachFile)로 전송한다. 만약에 대상
					 * 파일(attachFile)이 이미 존재하는 경우 먼저 삭제된다.
					 */
					// 탐색기에서
					// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\email_attach_file
					// 폴더에 가보면
					// 첨부한 파일이 생성되어져 있음을 확인할 수 있다.

					// === MultipartFile 을 File 로 변환하여 탐색기 저장폴더에 저장하기 끝 === //

					arr_attachFilename[i] = mtfile.getOriginalFilename(); // 배열 속에 첨부파일명들을 기록한다.

				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			} // end of for

		} // end of if (fileList != null && fileList.size() > 0)

		jsonObj.put("result", result);

//		System.out.println(jsonObj.toString());

		return jsonObj.toString();
	}

	// 문의목록보기
	@GetMapping("/community/inquiryList.do")
	public String requiredLogin_inquiryList(HttpServletRequest request, HttpServletResponse response) {

		String fk_userid = "";

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		fk_userid = loginuser.getUserid();
		request.setAttribute("fk_userid", fk_userid);

		List<InquiryVO> inquiryPagingList = null;

		if (fk_userid != null) {
			// 문의목록 가져오기
			List<InquiryVO> inquiryList = service.getinquiryList(fk_userid);
			request.setAttribute("inquiryList", inquiryList);

			String searchtype_a = request.getParameter("searchtype_a");
			String searchtype_b = request.getParameter("searchtype_b");
			String searchtype_answer = request.getParameter("searchtype_answer");
			String searchWord = request.getParameter("searchWord");
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");

			// 관리자 검색용귀찮아서 넣어둠
			String searchtype_fk_userid = "0";

			System.out.println("~~ 확인용 str_currentShowPageNo : " + str_currentShowPageNo);

			if (searchtype_a == null) {
				searchtype_a = "0";
			}

			if (searchtype_b == null) {
				searchtype_b = "0";
			}
			if (searchtype_answer == null) {
				searchtype_answer = "99";
			}

			if (searchWord == null) {
				searchWord = "";
			}

			if (searchWord != null) {
				searchWord = searchWord.trim();
				// " 연습 " ==> "연습"
				// " " ==> ""
			}

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchtype_a", searchtype_a);
			paraMap.put("searchtype_b", searchtype_b);
			paraMap.put("searchtype_answer", searchtype_answer);
			paraMap.put("searchtype_fk_userid", searchtype_fk_userid);
			paraMap.put("searchWord", searchWord);
			paraMap.put("fk_userid", fk_userid);

			// 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)

			totalCount = service.getTotalInquiryCount(paraMap);

			System.out.println("totalCount" + totalCount);

			totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

			if (str_currentShowPageNo == null) {
				// 문의 게시판에 보여지는 초기화면
				currentShowPageNo = 1;
			} else {

				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

					if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
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

			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));

			// 문의목록 페이징 처리
			inquiryPagingList = service.getPaginginquiryList(paraMap);
			request.setAttribute("inquiryPagingList", inquiryPagingList);

			// 검색시 검색조건 및 검색어 값 유지시키기
			if (searchtype_a != "0" || searchtype_b != "0" || searchtype_answer != "99" || searchWord != "") {
				request.setAttribute("paraMap", paraMap);
			}

			int blockSize = 10;
			// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.

			int loop = 1;

			int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;

			String pageBar = "<ul style='list-style:none;'>";
			String url = "/amado/community/inquiryList.do";

			// === [맨처음][이전] 만들기 === //
			if (pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + (pageNo - 1) + "'>[이전]</a></li>";
			}

			while (!(loop > blockSize || pageNo > totalPage)) {

				if (pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"
							+ pageNo + "</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url
							+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
							+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
							+ searchWord + "&currentShowPageNo=" + pageNo + "'>" + pageNo + "</a></li>";
				}

				loop++;
				pageNo++;
			} // end of while------------------------

			// === [다음][마지막] 만들기 === //
			if (pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + pageNo + "'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + totalPage + "'>[마지막]</a></li>";
			}

			pageBar += "</ul>";

			request.setAttribute("pageBar", pageBar);

			String goBackURL = MyUtil.getCurrentURL(request);
			request.setAttribute("goBackURL", goBackURL);

			//////////////////////////////////////////////

			request.setAttribute("totalCount", totalCount); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
			request.setAttribute("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
			request.setAttribute("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
		}
		return "/community/inquiryList.tiles2";
	}

	@PostMapping(value = "/community/inquiryGoDetail.do")
	public ModelAndView requiredLogin_inquiryGoDetail(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mav) {
		String inquiryseq = "";
		String goBackURL = "";
		String searchtype_a = "";
		String searchtype_b = "";
		String searchWord = "";

		inquiryseq = request.getParameter("inquiryseq");
		goBackURL = request.getParameter("goBackURL");
		searchtype_a = request.getParameter("searchtype_a");
		searchtype_b = request.getParameter("searchtype_b");
		searchWord = request.getParameter("searchWord");

		/*
		 * System.out.println("inquiryseq : " + inquiryseq);
		 * System.out.println("goBackURL : " + goBackURL);
		 * System.out.println("searchtype_a : " + searchtype_a);
		 * System.out.println("searchtype_b : " + searchtype_b);
		 * System.out.println("searchWord : " + searchWord);
		 */

		mav.setViewName("community/inquiryList.tiles2");

		// 1대1 문의 상세조회 하나 가져오기
		InquiryVO inquiryvo = service.inquiryGoDetail(inquiryseq);

		// 1대1 문의 상세조회 파일들 가져오기
		List<InquiryFileVO> inquiryfileList = service.inquiryFileGoDetail(inquiryseq);

		mav.addObject("inquiryvo", inquiryvo); // 1대1문의 상세정보
		mav.addObject("inquiryfileList", inquiryfileList); // 1대1문의 상세정보 파일
		// 답변(운영자가) (여기해야함!!)

		mav.addObject("goBackURL", goBackURL);

		mav.setViewName("community/inquiryGoDetail.tiles2");

		return mav;

	}

	// 클럽에 가입했을 경우(회원이 클럽에 가입)
	@ResponseBody
	@PostMapping(value = "/club/clubMRegisterSJ.do", produces = "text/plain;charset=UTF-8")
	public String clubMRegisterSJ(HttpServletRequest request) {

		String clubseq = request.getParameter("clubseq");
		String sportseq = request.getParameter("fk_sportseq");
		String fk_userid = request.getParameter("fk_userid");

		ClubmemberVO clubmembervo = new ClubmemberVO();

		clubmembervo.setClubseq(clubseq);
		clubmembervo.setFk_userid(fk_userid);
		clubmembervo.setSportseq(sportseq);

		int n = 0;

		// 클럽 가입신청(멤버)
		n = service.clubMRegisterSJ(clubmembervo);

		JSONObject jsonObject = new JSONObject(); // {}
		jsonObject.put("n", n); // 정상일 경우 {"n":1} 문제가 생겼을 경우{"n":0}

		return jsonObject.toString();
	}

	// 웹채팅
	@GetMapping("/chatting/multichat.do")
	public String requiredLogin_multichat(HttpServletRequest request, HttpServletResponse response) {

		return "chatting/multichat.tiles1";
	}

	// 문의 답변
	@GetMapping("admin/reg/ASinquiryList")
	public String ASinquiryList(HttpServletRequest request) {

		String fk_userid = "admin";

		request.setAttribute("fk_userid", fk_userid);

		List<InquiryVO> inquiryPagingList = null;

		if (fk_userid != null) {
			// 문의목록 가져오기
			List<InquiryVO> inquiryList = service.getinquiryList(fk_userid);
			request.setAttribute("inquiryList", inquiryList);

			String searchtype_a = request.getParameter("searchtype_a");
			String searchtype_b = request.getParameter("searchtype_b");
			String searchtype_answer = request.getParameter("searchtype_answer");
			String searchtype_fk_userid = request.getParameter("searchtype_fk_userid");
			String searchWord = request.getParameter("searchWord");
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");

			if (searchtype_a == null) {
				searchtype_a = "0";
			}

			if (searchtype_b == null) {
				searchtype_b = "0";
			}
			if (searchtype_answer == null) {
				searchtype_answer = "99";
			}
			if (searchtype_fk_userid == null) {
				searchtype_fk_userid = "0";
			}

			if (searchWord == null) {
				searchWord = "";
			}

			if (searchWord != null) {
				searchWord = searchWord.trim();
				// " 연습 " ==> "연습"
				// " " ==> ""
			}

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchtype_a", searchtype_a);
			paraMap.put("searchtype_b", searchtype_b);
			paraMap.put("searchtype_answer", searchtype_answer);
			paraMap.put("searchtype_fk_userid", searchtype_fk_userid);
			paraMap.put("searchWord", searchWord);
			paraMap.put("fk_userid", fk_userid);

			// 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다.
			int totalCount = 0; // 총 게시물 건수
			int sizePerPage = 10; // 한 페이지당 보여줄 게시물 건수
			int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0; // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)

			totalCount = service.getTotalInquiryCount(paraMap);

			totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

			if (str_currentShowPageNo == null) {
				// 문의 게시판에 보여지는 초기화면
				currentShowPageNo = 1;
			} else {

				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

					if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
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

			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));

			// 문의목록 페이징 처리
			inquiryPagingList = service.getPaginginquiryList(paraMap);
			request.setAttribute("inquiryPagingList", inquiryPagingList);

			// 검색시 검색조건 및 검색어 값 유지시키기
			if (searchtype_a != "0" || searchtype_b != "0" || searchWord != "") {
				request.setAttribute("paraMap", paraMap);
			}

			int blockSize = 10;
			// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.

			int loop = 1;

			int pageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;

			String pageBar = "<ul style='list-style:none;'>";
			String url = "/amado/admin/reg/ASinquiryList";

			// === [맨처음][이전] 만들기 === //
			if (pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + (pageNo - 1) + "'>[이전]</a></li>";
			}

			while (!(loop > blockSize || pageNo > totalPage)) {

				if (pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"
							+ pageNo + "</li>";
				} else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" + url
							+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
							+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
							+ searchWord + "&currentShowPageNo=" + pageNo + "'>" + pageNo + "</a></li>";
				}

				loop++;
				pageNo++;
			} // end of while------------------------

			// === [다음][마지막] 만들기 === //
			if (pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + pageNo + "'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='" + url
						+ "?searchtype_a=" + searchtype_a + "&searchtype_b=" + searchtype_b + "&searchtype_answer="
						+ searchtype_answer + "&searchtype_fk_userid=" + searchtype_fk_userid + "&searchWord="
						+ searchWord + "&currentShowPageNo=" + totalPage + "'>[마지막]</a></li>";
			}

			pageBar += "</ul>";

			request.setAttribute("pageBar", pageBar);

			String goBackURL = MyUtil.getCurrentURL(request);
			// System.out.println("~~~ 확인용(list.action) goBackURL : " + goBackURL);

			request.setAttribute("goBackURL", goBackURL);

			//////////////////////////////////////////////

			request.setAttribute("totalCount", totalCount); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
			request.setAttribute("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
			request.setAttribute("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.

		}
		return "reg/ASinquiryList.tiles3";
	}

	@PostMapping(value = "admin/reg/inquiryGoDetail")
	public ModelAndView inquiryGoDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		String inquiryseq = "";
		String goBackURL = "";
		String searchtype_a = "";
		String searchtype_b = "";
		String searchtype_fk_userid = "";
		String searchtype_answer = "";
		String searchWord = "";

		inquiryseq = request.getParameter("inquiryseq");
		goBackURL = request.getParameter("goBackURL");
		searchtype_a = request.getParameter("searchtype_a");
		searchtype_b = request.getParameter("searchtype_b");
		searchtype_b = request.getParameter("searchtype_fk_userid");
		searchtype_b = request.getParameter("searchtype_answer");
		searchWord = request.getParameter("searchWord");

		/*
		 * System.out.println("inquiryseq : " + inquiryseq);
		 * System.out.println("goBackURL : " + goBackURL);
		 * System.out.println("searchtype_a : " + searchtype_a);
		 * System.out.println("searchtype_b : " + searchtype_b);
		 * System.out.println("searchWord : " + searchWord);
		 */

		mav.setViewName("community/inquiryList.tiles2");

		// 1대1 문의 상세조회 하나 가져오기
		InquiryVO inquiryvo = service.inquiryGoDetail(inquiryseq);

		// 1대1 문의 상세조회 파일들 가져오기
		List<InquiryFileVO> inquiryfileList = service.inquiryFileGoDetail(inquiryseq);

		mav.addObject("goBackURL", goBackURL);
		mav.addObject("inquiryvo", inquiryvo); // 1대1문의 상세정보
		mav.addObject("inquiryfileList", inquiryfileList); // 1대1문의 상세정보 파일
		// 답변(운영자가) (여기해야함!!)

		mav.setViewName("reg/inquiryGoDetail.tiles3");

		return mav;

	}

	// === 운영자 문의 답변쓰기(Ajax 로 처리) === //
	@ResponseBody
	@PostMapping(value = "/admin/reg/addInquiryAD", produces = "text/plain;charset=UTF-8")
	public String addInquiryAD(HttpServletRequest request) {

		String content = request.getParameter("content");
		String inquiryseq = request.getParameter("inquiryseq");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("content", content);
		paraMap.put("inquiryseq", inquiryseq);
		String fk_userid = "admin";
		paraMap.put("fk_userid", "admin");

		int n = 0;
		try {
			n = service.addInquiryAD(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		JSONObject jsonObject = new JSONObject(); // {}
		jsonObject.put("n", n); // 정상일 경우 {"n":1} 문제가 생겼을 경우{"n":0}

		return jsonObject.toString();
		// 정상일 경우 {"n":1, "name":"엄정화"} 문제가 생겼을 경우(point 300 넘을 경우){"n":0, "name":"엄정화"}
	}

	@ResponseBody
	@GetMapping(value = "admin/reg/readInquiryAW", produces = "text/plain;charset=UTF-8")
	public String readInquiryAW(HttpServletRequest request) {

		String inquiryseq = request.getParameter("inquiryseq");

		List<InquiryAnswersVO> inquiryanswersList = service.readInquiryAW(inquiryseq);

		JSONArray jsonArr = new JSONArray(); // []

		if (inquiryanswersList != null) {
			for (InquiryAnswersVO inquiryanswersvo : inquiryanswersList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("inquiryanswerseq", inquiryanswersvo.getInquiryanswerseq());
				jsonObj.put("content", inquiryanswersvo.getContent());
				jsonObj.put("fk_userid", inquiryanswersvo.getFk_userid());
				jsonObj.put("inquiryseq", inquiryanswersvo.getInquiryseq());
				jsonObj.put("registerdate", inquiryanswersvo.getRegisterdate());

				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}

	@ResponseBody
	@PostMapping(value = "admin/reg/delInquiryAW", produces = "text/plain;charset=UTF-8")
	public String delInquiryAW(HttpServletRequest request) {

		String inquiryanswerseq = request.getParameter("inquiryanswerseq");
		String inquiryseq = request.getParameter("inquiryseq");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("inquiryanswerseq", inquiryanswerseq);
		paraMap.put("inquiryseq", inquiryseq);

		int n = service.delInquiryAW(paraMap);

		JSONObject jsonObject = new JSONObject(); // {}
		jsonObject.put("n", n); // 정상일 경우 {"n":1} 문제가 생겼을 경우{"n":0}

		return jsonObject.toString();
	}

	@ResponseBody
	@PostMapping(value = "/admin/reg/editInquiryAW", produces = "text/plain;charset=UTF-8")
	public String editInquiryAW(HttpServletRequest request) {

		String edit_comment_text = request.getParameter("edit_comment_text");
		String inquiryanswerseq = request.getParameter("inquiryanswerseq");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("edit_comment_text", edit_comment_text);
		paraMap.put("inquiryanswerseq", inquiryanswerseq);

		int n = service.editInquiryAW(paraMap);

		JSONObject jsonObject = new JSONObject(); // {}
		jsonObject.put("n", n); // 정상일 경우 {"n":1} 문제가 생겼을 경우{"n":0}

		return jsonObject.toString();
	}

	@Autowired
	private GoogleMail mail;

	@ResponseBody
	@PostMapping(value = "/admin/reg/emailWrite", produces = "text/plain;charset=UTF-8")
	public String emailWrite(HttpServletRequest request) {

		String title = request.getParameter("title");
		String org_content = request.getParameter("content");
		String inquiryseq = request.getParameter("inquiryseq");
		String email = request.getParameter("email");
		String registerdate = request.getParameter("registerdate");
		String searchType = request.getParameter("searchType");

		String content = "<div><div>문의제목 : " + title + "</div>" + "<div>문의유형 : " + searchType + "</div>" 
				+ "<div>문의날짜 : " + registerdate + "<hr> <div> 답변내용 : " + org_content;

		System.out.println(content);

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("content", content);
		paraMap.put("inquiryseq", inquiryseq);
		paraMap.put("email", email);
		paraMap.put("registerdate", registerdate);
		paraMap.put("searchType", searchType);

		JSONObject jsonObject = new JSONObject(); // {}

		try {
			mail.sendmail_iqraws(paraMap);
			jsonObject.put("result", 1);
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("result", 0);
		}

		return jsonObject.toString(); // "{"result":1}"

	}

}