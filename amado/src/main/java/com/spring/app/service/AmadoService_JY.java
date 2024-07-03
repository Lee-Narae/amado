package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.ClubVO;

public interface AmadoService_JY {

	// 동호회등록  완료 요청(파일첨부ㅇ)
	int add_withFile(ClubVO clubvo);

	// 시군구 정보
	List<Map<String, String>> getCityList();

	// 상세지역 정보
	List<String> getLocalList(String cityname);
	
	
	

}
