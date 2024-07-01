package com.spring.app.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class AmadoDAO_imple_JY implements AmadoDAO_JY {

	@Autowired				 
	@Qualifier("sqlsession") 
	private SqlSessionTemplate sqlsession;
	
	
	// 동호회명 중복 체크
	@Override
	public int clubnameDuplicateCheck(String clubname) {
		int n = 0;
		n = sqlsession.selectOne("JY.clubnameDuplicateCheck", clubname);
		return n;
	}

}
