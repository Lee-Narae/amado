package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
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
	

	// 글쓰기
	@Override
	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("SJ.add", boardvo);
		return n;
	}

	
	// 동호회목록 보기(페이지바 없음)
	@Override
	public List<ClubVO> clubListNoSearch(String params) {
		List<ClubVO> clubList = sqlsession.selectList("SJ.clubListNoSearch", params);
		return clubList;
	}


	// 동호회 총 페이지 수(검색포함)
	@Override
	public int getClubSearchTotalPage(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("SJ.getClubSearchTotalPage", paraMap);
		return totalCount;
	}

	// 검색타입 있는 리스트 가져오기(페이징)
	@Override
	public List<ClubVO> searchPaging(Map<String, String> paraMap) {
		List<ClubVO> clubPagingList = sqlsession.selectList("SJ.searchPaging", paraMap);
		return clubPagingList;
	}

	//////////////////////////////////////////////////////////////////////////
	
	// 게시판 총 페이지 수(검색포함)
	@Override
	public int getListSearchTotalPage(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("SJ.getListSearchTotalPage", paraMap);
		return totalCount;
	}

	// 검색타입 있거나 없는 리스트 가져오기(페이징)
	@Override
	public List<BoardVO> boardListSearchPaging(Map<String, String> paraMap) {
		List<BoardVO> boardPagingList = sqlsession.selectList("SJ.boardListSearchPaging", paraMap);
		return boardPagingList;
	}

	// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = sqlsession.selectOne("SJ.getView", paraMap);
		return boardvo;
	}

	// 글 조회수 1 증가하기
	@Override
	public int increase_viewcount(String boardseq) {
		int n = sqlsession.update("SJ.increase_viewcount", boardseq);
		return n;
	}



}
