package com.spring.app.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	   public static String getCurrentURL(HttpServletRequest request) {
		   
		   String currentURL = request.getRequestURL().toString();
		   // System.out.println(currentURL);
		   // http://localhost:9090/MyMVC/member/memberList.up
		   
		   String queryString = request.getQueryString();
		   // System.out.println(queryString);
		   // searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15
		   // post 방식일 경우에는 queryString의 값이 null이다.
		   
		   if(queryString != null) { // get 방식일 경우
			   currentURL += "?"+queryString;
			   // http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15
		   }
		   
		   String ctxPath = request.getContextPath();
		   int beginIndex = currentURL.indexOf(ctxPath)+ctxPath.length();
		   currentURL = currentURL.substring(beginIndex);
		   
		   // System.out.println(currentURL);
		   // /member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=5&currentShowPageNo=15
		   
		   return currentURL;
	   }
}
