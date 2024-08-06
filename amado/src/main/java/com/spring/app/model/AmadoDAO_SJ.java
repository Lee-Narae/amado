package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.InquiryAnswersVO;
import com.spring.app.domain.InquiryFileVO;
import com.spring.app.domain.InquiryVO;
import com.spring.app.domain.MemberVO;

public interface AmadoDAO_SJ {

	// 아이디 중복 체크
	int idDuplicateCheck(String userid);

	// 이메일 중복 체크
	int emailDuplicateCheck(String email);

	// 회원가입
	int memberRegisterEnd(MemberVO membervo);

	// 회원가입(이미지 파일이 있는 경우)	
	int memberRegisterEnd_withFile(MemberVO membervo);
	

	// 글쓰기
	int add(BoardVO boardvo);

	// 동호회목록 보기(페이지바 없음)
	List<ClubVO> clubListNoSearch(String params);

	// 동호회 총 페이지 수(검색포함)
	int getClubSearchTotalPage(Map<String, String> paraMap);

	// 검색타입 있는 리스트 가져오기(페이징)
	List<ClubVO> searchPaging(Map<String, String> paraMap);

	
	////////////////////////////////////////////////////////////////
	
	// 게시판 총 페이지 수(검색포함)
	int getListSearchTotalPage(Map<String, String> paraMap);

	// 검색타입 있거나 없는 리스트 가져오기(페이징)
	List<BoardVO> boardListSearchPaging(Map<String, String> paraMap);

	BoardVO getView(Map<String, String> paraMap);

	int increase_viewcount(String boardseq);

	
	
	// 댓글쓰기(tbl_boardcomment 테이블에 insert)
	int addBoardComment(BoardCommentVO boardcommentvo);

	// 원게시물에 딸린 댓글들을 조회해오기
	List<BoardCommentVO> readComment(String parentseq);

	// 댓글 작성 시 댓글카운트 증가
	int updateBoardCommentCount(String parentseq);

	// 댓글 삭제
	int deleteComment(String boardcommentseq);

	// 댓글 삭제 시 댓글카운트 감소
	int updateCommentCount_decrease(String parentseq);

	// 댓글 수정
	int updateComment(Map<String, String> paraMap);

	// 댓글의 GroupnoMax 알아오기
	int getGroupnoMax();

	// 답글쓰기
	int addReply(BoardCommentVO boardcmtvo);

	// 답글이 있는지 확인
	int checkComment(String boardcommentseq);

	// 답글 가져오기
	List<BoardCommentVO> getCommentreList(String boardcommentseq);

	// 첨부파일 있는 글쓰기
	int add_withFile(BoardVO boardvo);

	// 글 수정하기
	int edit(BoardVO boardvo);

	// 글 삭제하기
	int del(String boardseq);

	// 파일첨부가 있는 글 수정하기
	int edit_withFile(BoardVO boardvo);


	// 내가 가입한 클럽 가져오기
	List<ClubmemberVO> getClubmemberList(String fk_userid) throws Exception;

	// 이미 클럽가입 신청했거나 가입됐는지 확인용
	int getclubAry(ClubmemberVO clubmembervo);

	// 클럽 가입신청
	int clubMRegisterSJ(ClubmemberVO clubmembervo);

	// tbl_inquiry 에 넣기 (파일첨부가 있는 1대1 문의)
	int Inquiry(Map<String, Object> paraMap);

	// 자식테이블인 첨부파일 쪽에다가 insert 해준다.(파일첨부가 있는 1대1 문의)
	int InquiryFileTable(Map<String, Object> paraMap);

	int findseq_inquiry(Map<String, Object> paraMap);

	// 멤버정보 가져오기
	MemberVO getMemberInfo(String fk_userid);

	// 한 카테고리에 이미 가입한 클럽이 있는지 확인용
	int checkClubSportseq(ClubmemberVO clubmembervo);

	// 문의목록 가져오기
	List<Map<String, String>> getinquiryList(String fk_userid);

	int getTotalInquiryCount(Map<String, String> paraMap);

	List<InquiryVO> getPaginginquiryList(Map<String, String> paraMap);

	InquiryVO inquiryGoDetail(String inquiryseq);

	List<InquiryFileVO> inquiryFileGoDetail(String inquiryseq);

	InquiryFileVO getView_inquiry(Map<String, String> paraMap);

	int addInquiryAD(Map<String, String> paraMap);

	int updateInquiryAW(Map<String, String> paraMap);

	List<InquiryAnswersVO> readInquiryAW(String inquiryseq);

	int delInquiryAW(Map<String, String> paraMap);

	int editInquiryAW(Map<String, String> paraMap);

	int getInquiryCount(Map<String, String> paraMap);

	void updateAnswer(Map<String, String> paraMap);

	ClubVO rankF(String params);
	ClubVO rankS(String params);
	ClubVO rankT(String params);

	ClubmemberVO getClubmember(String clubseq);

	

	

}