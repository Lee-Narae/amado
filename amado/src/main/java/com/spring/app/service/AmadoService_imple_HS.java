package com.spring.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.spring.app.common.FileManager;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.model.AmadoDAO_HS;



@Service
public class AmadoService_imple_HS implements AmadoService_HS {


	@Autowired
	private AmadoDAO_HS dao;
	
	
	
	
	// ===#186. 첨부파일 삭제를 위한것 ==
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	
	


	//체육관 등록
	@Override
	public int add_withFile(GymVO gymvo) {
	
		int n = dao.add_withFile(gymvo);
		return n;
	}





	@Override
	public int add_photofile(PhotoVO photovo) {
		int n = dao.add_photofile(photovo);
		return n;
	}





	@Override
	public List<GymVO> getAllGymList() {
		 List<GymVO> allGymList = dao.getAllGymList();
		return allGymList;
	}







}
