package com.spring.app.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class AmadoDAO_imple_SJ implements AmadoDAO_SJ {

	@Autowired				 
	@Qualifier("sqlsession") 
	private SqlSessionTemplate sqlsession;
	
	// 아이디 중복 체크
	@Override
	public int idDuplicateCheck(String userid) {
		int n = 0;
		n = sqlsession.selectOne("SJ.idDuplicateCheck", userid);
		return n;
	}
	
	// 이메일 중복 체크
	@Override
	public int emailDuplicateCheck(String email) {
		int n = 0;
		n = sqlsession.selectOne("SJ.emailDuplicateCheck", email);
		return n;
	}

}
