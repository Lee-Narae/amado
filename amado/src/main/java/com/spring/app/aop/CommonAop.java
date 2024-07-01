package com.spring.app.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.app.common.MyUtil;

@Aspect
@Component
public class CommonAop {

	@Pointcut("execution(public * com.spring.app..Controller*.requiredLogin_*(..))") // 메소드 괄호 속 .. => 파라미터가 있든지 없든지
	public void requiredLogin() {}
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinpoint) {
		
		// 로그인 유무 확인을 위한 세션 얻어오기
		HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];
		// joinpoint.getArg(): 주 업무 메소드의 파라미터를 가리킨다. 그 중에서도 [0]은 인덱스번호 0인 첫 번째 파라미터를 의미한다.
		
		HttpServletResponse response = (HttpServletResponse)joinpoint.getArgs()[1];
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null) {
			String message = "로그인이 필요합니다.";
	        String loc = request.getContextPath()+"/member/login.do";
	          
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        // === 로그인 후 로그인 전에 머물던 페이지로 돌아가는 작업 시작
	        String url = MyUtil.getCurrentURL(request);
	        session.setAttribute("goBackURL", url);
	        
 	        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
 	        
 	        try {
			
 	        	dispatcher.forward(request, response);
			
 	        } catch (ServletException | IOException e) {
				e.printStackTrace();
			}
 	        
	        // === 로그인 후 로그인 전에 머물던 페이지로 돌아가는 작업 끝
		}
		
	}
}
