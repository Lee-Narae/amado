package com.spring.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

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

	// 이메일 중복 체크
	@Override
	public int emailDuplicateCheck(String email) {
		int n = 0;
		try {
			email = aES256.encrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		n = dao.emailDuplicateCheck(email);
		
		return n;
	}
	
}
