package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.InquiryVO;
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

	
	// 댓글쓰기(tbl_boardcomment 테이블에 insert)
	@Override
	public int addBoardComment(BoardCommentVO boardcommentvo) {
		int n = sqlsession.insert("SJ.addBoardComment", boardcommentvo);
		return n;
	}

	// 원게시물에 딸린 댓글들을 조회해오기
	@Override
	public List<BoardCommentVO> readComment(String parentseq) {
		List<BoardCommentVO> bdcmtList =  sqlsession.selectList("SJ.readComment", parentseq);
		return bdcmtList;
	}

	// 댓글 작성 시 댓글카운트 증가
	@Override
	public int updateBoardCommentCount(String parentseq) {
		int result = sqlsession.update("SJ.updateBoardCommentCount", parentseq);
		return result;
	}

	// 댓글 삭제
	@Override
	public int deleteComment(String boardcommentseq) {
		int n = sqlsession.update("SJ.deleteComment", boardcommentseq);
		return n;
	}

	// 댓글 삭제 시 댓글카운트 감소
	@Override
	public int updateCommentCount_decrease(String parentseq) {
		int result = sqlsession.update("SJ.updateCommentCount_decrease", parentseq);
		return result;
	}

	// 댓글 수정
	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = sqlsession.update("SJ.updateComment", paraMap);
		return n;
	}

	@Override
	public int getGroupnoMax() {
		int maxgrouno = sqlsession.selectOne("SJ.getGroupnoMax");
	    return maxgrouno;
	}

	// 답글쓰기
	@Override
	public int addReply(BoardCommentVO boardcmtvo) {
		int n = 0;
		n = sqlsession.insert("SJ.addReply", boardcmtvo);
		return n;
	}

	// 답글이 있는지 확인
	@Override
	public int checkComment(String boardcommentseq) {
		int totalCount = sqlsession.selectOne("SJ.checkComment", boardcommentseq);
	    return totalCount;
	}

	
	// 답글 가져오기
	@Override
	public List<BoardCommentVO> getCommentreList(String boardcommentseq) {
		List<BoardCommentVO> commentreList = sqlsession.selectList("SJ.getCommentreList", boardcommentseq);
		return commentreList;
	}

	// 첨부파일 있는 글쓰기
	@Override
	public int add_withFile(BoardVO boardvo) {
		int n = sqlsession.insert("SJ.add_withFile", boardvo);
		return n;
	}

	
	// 글 수정하기
	@Override
	public int edit(BoardVO boardvo) {
		int n = sqlsession.update("SJ.edit", boardvo);
		return n;
	}

	
	// 글 삭제하기
	@Override
	public int del(String boardseq) {
		int n = sqlsession.update("SJ.del", boardseq);
		return n;
	}

	
	// 파일첨부가 있는 글 수정하기
	@Override
	public int edit_withFile(BoardVO boardvo) {
		int n = sqlsession.update("SJ.edit_withFile", boardvo);
		return n;
	}

	
	// 내가 가입한 클럽 가져오기
	@Override
	public List<ClubmemberVO> getClubmemberList(String fk_userid) throws Exception {
		List<ClubmemberVO> clubmemberList = sqlsession.selectList("SJ.getClubmemberList", fk_userid);
		return clubmemberList;
	}

	
	// 이미 클럽가입 신청했거나 가입됐는지 확인용
	@Override
	public int getclubAry(ClubmemberVO clubmembervo) {
		int n1 = sqlsession.selectOne("SJ.getclubAry", clubmembervo);
		return n1;
	}

	
	// 클럽 가입신청
	@Override
	public int clubMRegisterSJ(ClubmemberVO clubmembervo) {
		int result = sqlsession.insert("SJ.clubMRegisterSJ", clubmembervo);
		return result;
	}

	
	// 파일첨부가 있는 1대1 문의
	@Override
	public int Inquiry(Map<String, Object> paraMap) {
		int inquiryseq  = sqlsession.insert("SJ.Inquiry", paraMap);
		return inquiryseq;
	}


	// 자식테이블인 첨부파일 쪽에다가 insert 해준다.
	@Override
	public int InquiryFileTable(Map<String, Object> paraMap) {
		int result = sqlsession.insert("SJ.InquiryFileTable", paraMap);
		return result;
	}

	@Override
	public int findseq_inquiry(Map<String, Object> paraMap) {
		int inquiryseq = sqlsession.selectOne("SJ.findseq_inquiry", paraMap);
		return inquiryseq;
	}

	// 멤버정보 가져오기
	@Override
	public MemberVO getMemberInfo(String fk_userid) {
		MemberVO loginuser = sqlsession.selectOne("SJ.getMemberInfo", fk_userid);
		return loginuser;
	}

	
	// 한 카테고리에 이미 가입한 클럽이 있는지 확인용
	@Override
	public int checkClubSportseq(ClubmemberVO clubmembervo) {
		int n = sqlsession.selectOne("SJ.checkClubSportseq", clubmembervo);
		return n;
	}

	
	// 문의목록 가져오기
	@Override
	public List<Map<String, String>> getinquiryList(String fk_userid) {
		List<Map<String, String>> inquiryList = sqlsession.selectList("SJ.getinquiryList", fk_userid);
		return inquiryList;
	}


}
