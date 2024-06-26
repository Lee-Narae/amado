package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.MemberVO;

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

	// 회원가입
	@Override
	public int memberRegisterEnd(MemberVO membervo) {
		int n = 0;
		n = sqlsession.insert("SJ.memberRegisterEnd", membervo);
		return n;
	}

	// 글목록 보기
	@Override
	public List<BoardVO> boardListNoSearch() {
		List<BoardVO> boardList = sqlsession.selectList("SJ.boardListNoSearch");
		return boardList;
	}
	
	@Override
	public List<BoardVO> boardListSearch(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("SJ.boardListSearch", paraMap);
		return boardList;
	}

	// 글쓰기
	@Override
	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("SJ.add", boardvo);
		return n;
	}



}
