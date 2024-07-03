package com.spring.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;


public interface AmadoService_NR {

	// 메인 페이지
	ModelAndView index(ModelAndView mav);

	// 로그인 처리
	ModelAndView loginEnd(Map<String, String> paramap, ModelAndView mav, HttpServletRequest request);

	// loginuser의 종목별 동호회 번호 얻어오기
	String getClubseq(Map<String, String> paramap);

	// 가입한 동호회 정보 불러오기
	Map<String, String> getClubInfo(String clubseq);

	// 운동 종목 불러오기
	List<Map<String, String>> getSportList();

	// 시군구 정보
	List<Map<String, String>> getCityList();

	// 상세지역 정보
	List<String> getLocalList(String cityname);

	// 매칭 정보 불러오기
	List<Map<String, String>> searchMatch(Map<String, String> paramap);

	// sportname + userid로 가입된 동호회 정보 불러오기
	Map<String, String> getClubseq_forMatch(Map<String, String> paramap);

	// 매치 등록하기
	int matchRegister(Map<String, String> paramap);

	// 동호회 이름으로 동호회 시퀀스 불러오기
	String getClubseq_forReg(String clubname);

	// 종목 이름으로 종목 시퀀스 불러오기
	String getSportseq_forReg(String sportname);
	


}
