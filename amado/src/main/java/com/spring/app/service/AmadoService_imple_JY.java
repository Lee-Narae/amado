package com.spring.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.FileManager;
import com.spring.app.domain.ClubVO;
import com.spring.app.model.AmadoDAO_JY;

@Service
public class AmadoService_imple_JY implements AmadoService_JY {
	
	@Autowired
	private AmadoDAO_JY dao;

 	// 첨부파일 삭제를 위한것 
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	
	
	
	//////////////////////////////////////////////
	



	// 시군구 정보
	@Override
	public List<Map<String, String>> getCityList() {
		List<Map<String, String>> cityList = dao.getCityList();
		return cityList;
	}



	// 상세지역 정보
	@Override
	public List<String> getLocalList(String cityname) {
		List<String> localList = dao.getLocalList(cityname);
		return localList;
	}


	// 동호회등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(ClubVO clubvo) {
		
		int n = dao.add_withFile(clubvo); //첨부파일이 있는경우
		return n;

	}


	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	@Override
	public void updateRank(String fk_userid) {
		dao.updateRank(fk_userid);
	}


	// 상품 select 헤오기
	@Override
	public List<Map<String, String>> getSportNameList(String sportname) {
		List<Map<String, String>> sportNameList = dao.getSportNameList(sportname);
		return sportNameList;
	}


	

	
	
	
	
	

}
