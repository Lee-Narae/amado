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
	
	@Override
	public int idDuplicateCheck(String userid) {
		int n = sqlsession.selectOne("SJ.idDuplicateCheck", userid);
		return n;
	}

}
