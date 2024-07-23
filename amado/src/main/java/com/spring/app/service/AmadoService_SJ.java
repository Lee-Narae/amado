package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.InquiryFileVO;
import com.spring.app.domain.InquiryVO;
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
	int addBoardComment(BoardCommentVO boardcommentvo) throws Throwable;

	// 원게시물에 딸린 댓글들을 조회해오기
	List<BoardCommentVO> readComment(String parentseq);

	// 댓글 삭제
	int deleteComment(Map<String, String> paraMap) throws Throwable;

	// 댓글 수정
	int updateComment(Map<String, String> paraMap);

	// 답글 쓰기
	int addReply(BoardCommentVO boardcommentvo);

	// 답글 읽기
	List<BoardCommentVO> getCommentreList(String boardcommentseq);

	// 첨부파일 있는 글쓰기
	int add_withFile(BoardVO boardvo);

	// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
	BoardVO getView_no_increase_readCount(Map<String, String> paraMap);

	// 글 수정하기
	int edit(BoardVO boardvo);

	// 글 삭제하기
	int del(Map<String, String> paraMap);

	// 파일첨부가 있는 글 수정하기
	int edit_withFile(BoardVO boardvo);


	// 내가 가입한 클럽 가져오기
	List<ClubmemberVO> getClubmemberList(String fk_userid) throws Exception;

	// 클럽 가입 신청
	int clubMRegisterSJ(ClubmemberVO clubmembervo);

	// 파일첨부가 있는 1대1 문의
	int InquiryFile(Map<String, Object> paraMap);

	// 파일첨부가 없는 1대1 문의
	int Inquiry(Map<String, Object> paraMap);

	int findseq_inquiry(Map<String, Object> paraMap);

	// 멤버정보 가져오기
	MemberVO getMemberInfo(String fk_userid);

	// 문의목록 가져오기
	List<InquiryVO> getinquiryList(String fk_userid);

	int getTotalInquiryCount(Map<String, String> paraMap);

	List<InquiryVO> getPaginginquiryList(Map<String, String> paraMap);

	InquiryVO inquiryGoDetail(String inquiryseq);

	List<InquiryFileVO> inquiryFileGoDetail(String inquiryseq);

	InquiryFileVO getView_inquiry(Map<String, String> paraMap);


}
