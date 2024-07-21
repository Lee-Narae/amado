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
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PhotoVO;
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
	
	
	//체육관 등록 
	@GetMapping(value="/gym/registerGym.do")
	   public ModelAndView registerGym(ModelAndView mav) {
		mav.setViewName("/gym/registerGym.tiles2");
	     
		
		return mav;
	      
	   }  
	
	//체육관 등록  완료 요청
	@PostMapping("/gym/registerGymend.do")
	public ModelAndView registerGym(Map<String, String> paraMap ,ModelAndView mav,HttpServletRequest request, GymVO gymvo ,PhotoVO photovo, MultipartHttpServletRequest mrequest) throws Exception  { // <== After Advice 를 사용하기 전
	
		MultipartFile attach = gymvo.getAttach();
		
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
            	운영체제가 Windows 이라면 File.separator 는  "\a" 이고,
            	운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
            	
			 */
			
			/*
			 
			 #2 . 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			  
			 */
			String newFileName ="";
			//was(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			//첨부파일의 내용물을 담는것
			
			long fileSize = 0;
			//첨부 파일의 크기 
			
			try {
				bytes= attach.getBytes();
				//첨부파일의 내용물을 읽어오는 것
				String originalFilename=attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				
			//   System.out.println("~~~ 확인용 originalFilename => " + originalFilename); 
	            // ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf 
				newFileName =fileManager.doFileUpload(bytes, originalFilename, path);
			
				
				gymvo.setFilename(newFileName);
				//was(톰캣)에 저장된 파일명(2024062712075997631067179400.jpg)
				gymvo.setOrgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(LG_싸이킹청소기_사용설명서.pdf)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				fileSize = attach.getSize(); // 첨부파일의 크기 
				gymvo.setFilesize(String.valueOf(fileSize));
				
				
			} catch (IOException e) {
			
				e.printStackTrace();
			}
		
			
			
			
		}
		
	// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===	

	
	  System.out.println("1"+gymvo.getAttach());
	  System.out.println("2"+gymvo.getGymname());
	  System.out.println("3 "+gymvo.getFk_userid());
	  System.out.println("4 "+gymvo.getPostcode());
	  System.out.println("5 "+gymvo.getAddress());
	 
	  System.out.println("6 "+gymvo.getDetailaddress());
	  
	  System.out.println("7 "+gymvo.getInsidestatus());
	  System.out.println("8 "+gymvo.getInfo());
	  System.out.println("9 "+gymvo.getOrgfilename());
	  
	  System.out.println("10"+gymvo.getCost());
	  System.out.println("11 "+gymvo.getCaution());
	  System.out.println("12 "+gymvo.getMembercount());
	 
	  System.out.println("13 "+photovo.getSeveral_photos());
	  System.out.println("14 "+request.getParameter("several_photos"));

//
//		HttpSession session2 = request.getSession();
//		MemberVO loginuser = (MemberVO)session2.getAttribute("loginuser");
//		
//		String userid = loginuser.getUserid();
//		
//		gymvo.setFk_userid(userid);
//	
		int n =0;
		
		if(!(attach.isEmpty())) {
			//파일 첨부가  있는 경우라면 
			n=service.add_withFile(gymvo);
			/*
			 * if(n==1) { n=service.add_photofile(photovo); }
			 */
			
		}
		
		
		
		if(n ==1) {
			mav.setViewName("redirect:/index.do");
		    //  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("gym/error/add_error.tiles2");
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}
		
		// ===== #104. After Advice 를 사용하기 ====== //
		//             글쓰기를 한 이후에는 회원의 포인트를 100점 증가 
		//paraMap.put("userid", boardvo.getFk_userid());
		//paraMap.put("point", "100");
		
		return mav;
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
			int totalPage = service.getMemberTotalPage(paramap);
			
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
			
			
			
			/* >>> 뷰단(memberList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
	        	        검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 <<< */
			int totalMemberCount = service.getTotalMemberCount(paramap);
			
			mav.addObject("totalMemberCount", totalMemberCount);
			mav.addObject("currentShowPageNo", currentShowPageNo);
			
			mav.setViewName("manage/member.tiles3");
			
			return mav;
			
			
			
			
			mav.setViewName("manage/club.tiles3");
			
			return mav;
			
		}
	   
	   
	   
	

}
