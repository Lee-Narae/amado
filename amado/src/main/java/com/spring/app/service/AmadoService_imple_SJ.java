package com.spring.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.MemberVO;
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

	// 회원가입
	@Override
	public int memberRegisterEnd(MemberVO membervo) {
		String password = membervo.getPassword();
		String email = membervo.getEmail();
		String mobile = membervo.getMobile();
		
		int n = 0;
		try {
			membervo.setPassword(Sha256.encrypt(password));
			membervo.setEmail(aES256.encrypt(email));
			membervo.setMobile(aES256.encrypt(mobile));
			
			n = dao.memberRegisterEnd(membervo);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		return n;
	}

	// 글목록 보기
	@Override
	public List<BoardVO> boardListNoSearch() {
		List<BoardVO> boardList = dao.boardListNoSearch();
		return boardList;
	}
	
	// 글목록 보기(검색가능)	
	@Override
	public List<BoardVO> boardListSearch(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearch(paraMap);
		return boardList;
	}

	// 글쓰기
	@Override
	public int add(BoardVO boardvo) {
		int n = dao.add(boardvo);
		return n;
	}

	// 동호회목록 보기(페이지바 없음)
	@Override
	public List<ClubVO> clubListNoSearch(String params) {
		List<ClubVO> clubList = dao.clubListNoSearch(params);
		return clubList;
	}

	// 검색타입 있는 리스트 가져오기
	@Override
	public List<ClubVO> searchType(Map<String, String> paraMap) {
		List<ClubVO> clubList = dao.searchType(paraMap);
		return clubList;
	}

	// === 페이징 처리를 안한 검색어가 있는 전체 동호회 보여주기 === //
	@Override
	public List<ClubVO> clubListSearch(Map<String, String> paraMap) {
		List<ClubVO> clubList = dao.clubListSearch(paraMap);
		return clubList;
	}


	
}
