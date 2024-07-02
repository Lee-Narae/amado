package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.MemberVO;

// 승진 서비스
public interface AmadoService_SJ {

	// 아이디 중복 체크
	int idDuplicateCheck(String userid);

	// 이메일 중복 체크
	int emailDuplicateCheck(String email);

	// 회원가입
	int memberRegisterEnd(MemberVO membervo);

	// 글목록 보기(페이지바 없음)
	List<BoardVO> boardListNoSearch();

	// 글목록 보기(검색가능)(페이지바 없음)
	List<BoardVO> boardListSearch(Map<String, String> paraMap);

	
	// 글쓰기
	int add(BoardVO boardvo);

	// 동호회목록 보기(페이지바 없음)
	List<ClubVO> clubListNoSearch(String params);

	// 검색타입 있는 리스트 가져오기
	List<ClubVO> searchType(Map<String, String> paraMap);


}
