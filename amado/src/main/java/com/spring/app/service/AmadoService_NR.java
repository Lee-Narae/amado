package com.spring.app.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface AmadoService_NR {

	// 메인 페이지
	ModelAndView index(ModelAndView mav);

	// 로그인 처리
	ModelAndView loginEnd(Map<String, String> paramap, ModelAndView mav, HttpServletRequest request);

}
