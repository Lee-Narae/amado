package com.spring.app.amado.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.FleamarketCommentVO;
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
	@PostMapping(value="/addComment.action", produces="text/plain;charset=UTF-8")
	public String addComment(FleamarketCommentVO fmcommentvo, HttpServletRequest request) {
		// 댓글쓰기에 첨부파일이 없는 경우
		String name = request.getParameter("name");
		
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
	
	
	
	
	
	@GetMapping("/club/myClub_plus.do")
	public ModelAndView myClub_plus(ModelAndView mav) {

		mav.setViewName("club/myClub_plus.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		
		return mav;
	}	
}
