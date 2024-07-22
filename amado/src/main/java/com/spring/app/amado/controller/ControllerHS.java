package com.spring.app.amado.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.FileManager;

import com.spring.app.common.MyUtil;

import com.spring.app.domain.AnswerVO;
//import com.spring.app.domain.FleamarketCommentReVO;
//import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.domain.QuestionVO;
import com.spring.app.service.AmadoService_HS;


@Controller
public class ControllerHS {
	// 한솔 컨트롤러
	
	@Autowired
	private AmadoService_HS service;

	
	//=== #175  파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	
	

	// 체육관 상세보기
	@GetMapping(value="/gym/detail_gym.do")
	   public ModelAndView detail_gym(ModelAndView mav) {
	      // 모든 상품 select 해오기
	      List<GymVO> allGymList = service.getAllGymList(); //디비에서 데이터를 불러만오는 거라 map에 넣어서 보낼게 없음!!!!
	            
	      mav.addObject("allGymList", allGymList);
	            
	      mav.setViewName("/gym/detail_gym.tiles2");
	      return mav;
	       //  /WEB-INF/views/tiles1/opendata/korea_tour_api.jsp 페이지를 만들어야 한다.
	   }  
	


	   //체육관 전체보기
	   @GetMapping(value="/gym/rental_gym.do")
	      public ModelAndView rental_gym(ModelAndView mav) {
	      
	      // 모든 상품 select 해오기
	      List<GymVO> allGymList = service.getAllGymList(); //디비에서 데이터를 불러만오는 거라 map에 넣어서 보낼게 없음!!!!
	            
	      mav.addObject("allGymList", allGymList);
	            
	      mav.setViewName("/gym/rental_gym.tiles2");
	         return mav;
	          //  /WEB-INF/views/tiles1/opendata/korea_tour_api.jsp 페이지를 만들어야 한다.
	    
	   
	   
	   }  


	//체육관등록
	@GetMapping("/gym/registerGym.do")
	public ModelAndView AdminGymRegister(ModelAndView mav) {
		
		
		mav.setViewName("/gym/registerGym.tiles2");
		
		return mav;
		
	}
	
	//체육관 다중 파일 추가
	@ResponseBody
	@PostMapping(value="/gym/registerGymend.do", produces="text/plain;charset=UTF-8")
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
        
        int n = service.Gymreg(gym);
        System.out.println("n: "+n);
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
		            System.out.println("n2: "+n2);
		        } catch (Exception e) {
		           e.printStackTrace();
		        }  
		    }
		
        }	
	    	
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("n", n*n2);
		
		return jsonObj.toString();
	}

	   
	   
	   
	   
	   
	   
	   @ResponseBody
		@PostMapping(value="/addComment2.do", produces="text/plain;charset=UTF-8")
		public String addComment(QuestionVO questionvo, HttpServletRequest request) {
			// 댓글쓰기에 첨부파일이 없는 경우
			String name = request.getParameter("name");
			String content = request.getParameter("content");
			String fk_userid = request.getParameter("fk_userid");
			
			System.out.println(content);
			System.out.println(fk_userid);
			
			int n = 0;
			
			try {
				n = service.addComment(questionvo);
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
		@GetMapping(value="/readComment2.action", produces="text/plain;charset=UTF-8") 
		public String readComment(HttpServletRequest request) {
			
			String parentSeq = request.getParameter("parentSeq"); 
			System.out.println(parentSeq);
			List<QuestionVO> commentList = service.getCommentList(parentSeq); 
			
			JSONArray jsonArr = new JSONArray(); // [] 
			
			if(commentList != null) {
				for(QuestionVO questionvo : commentList) {
					JSONObject jsonObj = new JSONObject();          // {} 
					jsonObj.put("gymquestionseq", questionvo.getGymquestionseq());             // {"seq":1}
					jsonObj.put("fk_userid", questionvo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
					jsonObj.put("content", questionvo.getContent());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
					jsonObj.put("registerdate", questionvo.getRegisterdate());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}
					jsonObj.put("memberimg", questionvo.getMemberimg());
					jsonObj.put("changestatus", questionvo.getChangestatus());
					
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
		@PostMapping(value="/updateComment2.action", produces="text/plain;charset=UTF-8")
		public String updateComment(HttpServletRequest request) {
			
			String gymquestionseq = request.getParameter("gymquestionseq");
			String content = request.getParameter("content");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("gymquestionseq", gymquestionseq);
			paraMap.put("content", content);
			
			int n = service.updateComment(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			return jsonObj.toString(); // "{"n":1}"
		}
		
			
		
		
		@ResponseBody
		@PostMapping(value="/deleteComment2.action", produces="text/plain;charset=UTF-8") 
		public String deleteComment(HttpServletRequest request) {
			
			String gymquestionseq = request.getParameter("gymquestionseq");
			String gymseq = request.getParameter("parentSeq");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("gymquestionseq", gymquestionseq);
			paraMap.put("gymseq", gymseq);
			
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
		@PostMapping(value="/addReplyComment2.action", produces="text/plain;charset=UTF-8")
		public String addReplyComment(HttpServletRequest request) {
			
			String gymquestionseq = request.getParameter("gymquestionseq");
			
			//System.out.println(gymquestionseq);
			List<AnswerVO> commentreList = service.getCommentreList(gymquestionseq); 
			
			JSONArray jsonArr = new JSONArray(); // [] 
			
			if(commentreList != null) {
				for(AnswerVO answervo : commentreList) {
					JSONObject jsonObj = new JSONObject();          // {} 
					jsonObj.put("fleamarketcommentreplyseq", answervo.getGymanswerseq());             // {"seq":1}
					jsonObj.put("fk_userid", answervo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
					jsonObj.put("content_reply", answervo.getContent_reply());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
					jsonObj.put("registerdate", answervo.getRegisterdate());     // {"seq":1, "fk_userid":"seoyh","name":서영학,"content":"첫번째 댓글입니다. ㅎㅎㅎ","regdate":"2024-06-18 15:36:31"}
					jsonObj.put("memberimg", answervo.getMemberimg());
					jsonObj.put("changestatus", answervo.getChangestatus());
					
					jsonArr.put(jsonObj);
				}// end of for-----------------------
			}
			
			return jsonArr.toString();
		}
		
		
		
		@ResponseBody
		@PostMapping(value="/addReComment2.do", produces="text/plain;charset=UTF-8")
		public String addReComment(AnswerVO answervo, HttpServletRequest request) {
			
			// 댓글쓰기에 첨부파일이 없는 경우
			String fk_userid = request.getParameter("fk_userid");
			String content_reply = request.getParameter("content_reply");
			String gymquestionseq = request.getParameter("gymquestionseq");
			
			//System.out.println("1"+fk_userid);
			//System.out.println("2"+content_reply);
			//System.out.println("3"+gymquestionseq);
			
			answervo.setFk_userid(fk_userid);
			
			int n = 0;
			
			try {
				n = service.addReComment(answervo);
				
				// System.out.println("확인"+n);
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
		@PostMapping(value="/updateReComment2.do", produces="text/plain;charset=UTF-8")
		public String updateReComment(HttpServletRequest request) {
			
			String gymanswerseq = request.getParameter("gymanswerseq");
			String content_reply = request.getParameter("content_reply");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("gymanswerseq", gymanswerseq);
			paraMap.put("content_reply", content_reply);
			
			int n = service.updateReComment(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			return jsonObj.toString(); // "{"n":1}"
		}
		
			
		
		
	/*	@ResponseBody
		@PostMapping(value="/deleteReComment2.do", produces="text/plain;charset=UTF-8") 
		public String deleteReComment(HttpServletRequest request) {
			
			String gymanswerseq = request.getParameter("gymanswerseq");
			String gymquestionseq = request.getParameter("gymquestionseq");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("gymanswerseq", gymanswerseq);
			paraMap.put("gymquestionseq", gymquestionseq);
			
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
	      

		@GetMapping("admin/manage/club")
		public ModelAndView clubmanager(HttpServletRequest request, HttpServletResponse response ,ModelAndView mav) {
			
			
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
			//int totalPage = service.getMemberTotalPage(paramap);
			
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
			
			
			
			 >>> 뷰단(memberList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
	        	        검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 <<< 
			int totalMemberCount = service.getTotalMemberCount(paramap);
			
			mav.addObject("totalMemberCount", totalMemberCount);
			mav.addObject("currentShowPageNo", currentShowPageNo);
			
			mav.setViewName("manage/member.tiles3");
			
			return mav;
			
			
			
			
			mav.setViewName("manage/club.tiles3");
			
			return mav;
			
		}
	   */
	   
	   
	

}
