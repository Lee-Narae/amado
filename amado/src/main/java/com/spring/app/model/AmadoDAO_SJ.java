package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.MemberVO;

public interface AmadoDAO_SJ {

	// 아이디 중복 체크
	int idDuplicateCheck(String userid);

	// 이메일 중복 체크
	int emailDuplicateCheck(String email);

	// 회원가입
	int memberRegisterEnd(MemberVO membervo);

	// 글목록 보기
	List<BoardVO> boardListNoSearch();
	
	// 글목록 목비(검색가능)
	List<BoardVO> boardListSearch(Map<String, String> paraMap);

	// 글쓰기
	int add(BoardVO boardvo);

	

}
