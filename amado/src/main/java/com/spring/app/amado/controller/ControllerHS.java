package com.spring.app.amado.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
		mav.setViewName("/gym/detail_gym.tiles2");
	      return mav;
	       //  /WEB-INF/views/tiles1/opendata/korea_tour_api.jsp 페이지를 만들어야 한다.
	   }  
	
	

//	//체육관 등록  완료 요청
//	@PostMapping("/gym/registerGymend.do")
//	public ModelAndView registerGym(Map<String, String> paraMap ,ModelAndView mav,HttpServletRequest request, GymVO gymvo ,PhotoVO photovo, MultipartHttpServletRequest mrequest) throws Exception  { // <== After Advice 를 사용하기 전
//	
//		MultipartFile attach = gymvo.getAttach();
//		
//		if(attach != null) {
//			// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면) 
//			
//			/*
//			   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
//			   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
//			             우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
//			             조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
//			*/
//			// WAS 의 webapp 의 절대경로를 알아와야 한다. 
//			HttpSession session = mrequest.getSession(); 
//			String root = session.getServletContext().getRealPath("/");  
//			
//			//System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);  
//			//~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
//			
//			String path =root+"resources" +File.separator+"files";
//			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
//            	운영체제가 Windows 이라면 File.separator 는  "\a" 이고,
//            	운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
//            	
//			 */
//			
//			/*
//			 
//			 #2 . 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
//			  
//			 */
//			String newFileName ="";
//			//was(톰캣)의 디스크에 저장될 파일명
//			
//			byte[] bytes = null;
//			//첨부파일의 내용물을 담는것
//			
//			long fileSize = 0;
//			//첨부 파일의 크기 
//			
//			try {
//				bytes= attach.getBytes();
//				//첨부파일의 내용물을 읽어오는 것
//				String originalFilename=attach.getOriginalFilename();
//				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
//				
//			//   System.out.println("~~~ 확인용 originalFilename => " + originalFilename); 
//	            // ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf 
//				newFileName =fileManager.doFileUpload(bytes, originalFilename, path);
//			
//				
//				gymvo.setFilename(newFileName);
//				//was(톰캣)에 저장된 파일명(2024062712075997631067179400.jpg)
//				gymvo.setOrgfilename(originalFilename);
//				// 게시판 페이지에서 첨부된 파일(LG_싸이킹청소기_사용설명서.pdf)을 보여줄 때 사용.
//	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
//				fileSize = attach.getSize(); // 첨부파일의 크기 
//				gymvo.setFilesize(String.valueOf(fileSize));
//				
//				
//			} catch (IOException e) {
//			
//				e.printStackTrace();
//			}
//		
//			
//			
//			
//		}
//		
//	// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===	
//
//	
//	  System.out.println("1"+gymvo.getAttach());
//	  System.out.println("2"+gymvo.getGymname());
//	  System.out.println("3 "+gymvo.getFk_userid());
//	  System.out.println("4 "+gymvo.getPostcode());
//	  System.out.println("5 "+gymvo.getAddress());
//	 
//	  System.out.println("6 "+gymvo.getDetailaddress());
//	  
//	  System.out.println("7 "+gymvo.getInsidestatus());
//	  System.out.println("8 "+gymvo.getInfo());
//	  System.out.println("9 "+gymvo.getOrgfilename());
//	  
//	  System.out.println("10"+gymvo.getCost());
//	  System.out.println("11 "+gymvo.getCaution());
//	  System.out.println("12 "+gymvo.getMembercount());
//	 
//	  System.out.println("13 "+photovo.getSeveral_photos());
//	  System.out.println("14 "+request.getParameter("several_photos"));
//
////
////		HttpSession session2 = request.getSession();
////		MemberVO loginuser = (MemberVO)session2.getAttribute("loginuser");
////		
////		String userid = loginuser.getUserid();
////		
////		gymvo.setFk_userid(userid);
////	
//		int n =0;
//		
//		if(!(attach.isEmpty())) {
//			//파일 첨부가  있는 경우라면 
//			n=service.add_withFile(gymvo);
//			/*
//			 * if(n==1) { n=service.add_photofile(photovo); }
//			 */
//			
//		}
//		
//		
//		
//		if(n ==1) {
//			mav.setViewName("redirect:/index.do");
//		    //  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
//		}
//		else {
//			mav.setViewName("gym/error/add_error.tiles2");
//			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
//		}
//		
//		// ===== #104. After Advice 를 사용하기 ====== //
//		//             글쓰기를 한 이후에는 회원의 포인트를 100점 증가 
//		//paraMap.put("userid", boardvo.getFk_userid());
//		//paraMap.put("point", "100");
//		
//		return mav;
//	}

	
//	//체육관 등록 
//	@GetMapping(value="/gym/registerGym.do")
//	   public ModelAndView registerGym(ModelAndView mav) {
//		mav.setViewName("/gym/registerGym.tiles2");
//	     
//		
//		return mav;
//	      
//	   }  
	
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
	   
	   
	   
	   
	   
	   
	   @ResponseBody
		@PostMapping(value="/addComment2.do", produces="text/plain;charset=UTF-8")
		public String addComment(QuestionVO questionvo, HttpServletRequest request) {
			// 댓글쓰기에 첨부파일이 없는 경우
			String name = request.getParameter("name");
			String comment_text = request.getParameter("comment_text");
			
			//System.out.println(comment_text);
			
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
			
			// System.out.println(fleamarketcommentseq);
			List<AnswerVO> commentreList = service.getCommentreList(gymquestionseq); 
			
			JSONArray jsonArr = new JSONArray(); // [] 
			
			if(commentreList != null) {
				for(AnswerVO answervo : commentreList) {
					JSONObject jsonObj = new JSONObject();          // {} 
					jsonObj.put("fleamarketcommentreplyseq", answervo.getGymanswerseq());             // {"seq":1}
					jsonObj.put("fk_userid", answervo.getFk_userid()); // {"seq":1, "fk_userid":"seoyh"}
					jsonObj.put("getContent_reply", answervo.getContent_reply());           // {"seq":1, "fk_userid":"seoyh","name":"서영학"}
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
			//System.out.println("2"+commentreply_text);
			//System.out.println("3"+fleamarketcommentseq);
			
			answervo.setFk_userid(fk_userid);
			
			int n = 0;
			
			try {
				n = service.addReComment(answervo);
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
		
			
		
		
		@ResponseBody
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
	      
		
	   
	   
	   
	

}
