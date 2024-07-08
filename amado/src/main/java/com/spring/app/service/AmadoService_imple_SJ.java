package com.spring.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.domain.BoardCommentVO;
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


	// 동호회 총 페이지 수(검색포함)
	@Override
	public int getClubSearchTotalPage(Map<String, String> paraMap) {
		int totalCount = dao.getClubSearchTotalPage(paraMap);
		return totalCount;
	}

	// 검색타입 있는 리스트 가져오기(페이징)
	@Override
	public List<ClubVO> searchPaging(Map<String, String> paraMap) {
	      List<ClubVO> clubPagingList = dao.searchPaging(paraMap);
	      return clubPagingList;
	}

	/////////////////////////////////////////////////////////////////
	
	// 게시판 총 페이지 수(검색포함)
	@Override
	public int getListSearchTotalPage(Map<String, String> paraMap) {
		int totalCount = dao.getListSearchTotalPage(paraMap);
		return totalCount;
	}

	// 검색타입 있거나 없는 리스트 가져오기(페이징)
	@Override
	public List<BoardVO> boardListSearchPaging(Map<String, String> paraMap) {
		  List<BoardVO> boardPagingList = dao.boardListSearchPaging(paraMap);
	      return boardPagingList;
	}

	// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap);		// 글 1개 조회하기
		
		String loginuser = paraMap.get("loginuser");
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
	    // 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.
		
		if(loginuser != null && boardvo != null && !loginuser.equals(boardvo.getFk_userid())) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다.
			
			int n = dao.increase_viewcount(boardvo.getBoardseq()); // 글 조회수 1 증가하기
			if(n == 1) {
				boardvo.setViewcount(String.valueOf(Integer.parseInt(boardvo.getViewcount()) + 1));
			}
		}
		
		return boardvo;
	}

	
	// 댓글쓰기(Transaction)
	// rollbackFor= {Throwable.class} 오류 뜨면 그냥 롤백해줌. 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addBoardComment(BoardCommentVO bdcmtvo) throws Throwable {
		
		int n1 = 0; int n2 = 0; int result = 0;
		n1 = dao.addBoardComment(bdcmtvo); // 댓글쓰기(tbl_boardcomment 테이블에 insert)
//		System.out.println("~~~ 확인용 n1 : " + n1);
		
		/*
		 * if(n1 == 1) { n2 = dao.updateBoardCommentCount(bdcmtvo.getParentseq()); //
		 * tbl_board 테이블에 commentCount 컬럼이 1증가(update) //
		 * System.out.println("~~~ 확인용 n2 : " + n2); }
		 * 
		 * if(n2 == 1) { Map<String,String> paraMap = new HashMap<>();
		 * paraMap.put("userid", bdcmtvo.getFk_userid()); paraMap.put("point", "50");
		 * 
		 * result = dao.updateMemberPoint(paraMap);// tbl_member 테이블의 point 컬럼의 값을 50점을
		 * 증가(update) // System.out.println("~~~ 확인용 result : " + result); }
		 */

		
		return result;
	}


	
}
