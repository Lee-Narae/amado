package com.spring.app.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.MemberVO;

@Repository
public class AmadoDAO_imple_NR implements AmadoDAO_NR {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	// 로그인
	@Override
	public MemberVO getLoginMember(Map<String, String> paramap) {
		
		MemberVO loginuser = sqlsession.selectOne("NR.getLoginMember", paramap);
		
		return loginuser;
	}

	// 휴면 처리
	@Override
	public void updateIdle(String userid) {
		sqlsession.update("NR.updateIdle", userid);
	}

	// loginhistory insert
	@Override
	public void insert_tbl_loginhistory(Map<String, String> paramap) {
		sqlsession.insert("NR.insert_tbl_loginhistory", paramap);
	}

}
