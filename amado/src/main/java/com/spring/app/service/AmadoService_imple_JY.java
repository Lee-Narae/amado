package com.spring.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.model.AmadoDAO_JY;

@Service
public class AmadoService_imple_JY implements AmadoService_JY {

	@Autowired
	private AmadoDAO_JY dao;  

	
	// 동호회명 중복체크
	@Override
	public int clubnameDuplicateCheck(String clubname) {
		int n = 0;
		n = dao.clubnameDuplicateCheck(clubname);
		
		return n;
	}

}
