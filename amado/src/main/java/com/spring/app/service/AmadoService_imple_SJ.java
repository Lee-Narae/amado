package com.spring.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.model.AmadoDAO_SJ;

// 승진 서비스 임플
@Service
public class AmadoService_imple_SJ implements AmadoService_SJ {

	@Autowired
	private AmadoDAO_SJ dao;  
	
    @Autowired
    private AES256 aES256;
	
    // 아이디 중복 체크
	@Override
	public int idDuplicateCheck(String userid) {
		int n = 0;
		n = dao.idDuplicateCheck(userid);
		
		return n;
	}
	
}
