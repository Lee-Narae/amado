package com.spring.app.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.ClubVO;

public interface AmadoService_NR {

	// 메인 페이지
	ModelAndView index(ModelAndView mav);

	// 로그인 처리
	ModelAndView loginEnd(Map<String, String> paramap, ModelAndView mav, HttpServletRequest request);

	// loginuser의 종목별 동호회 번호 얻어오기
	String getClubseq(Map<String, String> paramap);

	// 가입한 동호회 정보 불러오기
	Map<String, String> getClubInfo(String clubseq);

}
