package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardCommentVO;
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


	
	// 글쓰기
	int add(BoardVO boardvo);

	
	
	// 동호회목록 보기(페이지바 없음)
	List<ClubVO> clubListNoSearch(String params);

	// 동호회 총 페이지 수(검색포함)
	int getClubSearchTotalPage(Map<String, String> paraMap);

	// 검색타입 있는 리스트 가져오기(페이징)
	List<ClubVO> searchPaging(Map<String, String> paraMap);

	/////////////////////////////////////////////////////////////
	
	// 게시판 총 페이지 수(검색포함)
	int getListSearchTotalPage(Map<String, String> paraMap);

	// 검색타입 있거나 없는 리스트 가져오기(페이징)
	List<BoardVO> boardListSearchPaging(Map<String, String> paraMap);

	BoardVO getView(Map<String, String> paraMap);

	
	// 댓글쓰기(Transaction)
	int addBoardComment(BoardCommentVO bdcmtvo) throws Throwable;

	// 원게시물에 딸린 댓글들을 조회해오기
	List<BoardCommentVO> readComment(String parentseq);

	// 댓글 삭제
	int deleteComment(Map<String, String> paraMap) throws Throwable;

	// 댓글 수정
	int updateComment(Map<String, String> paraMap);


}
