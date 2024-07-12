package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.MemberVO;

public interface AmadoDAO_SJ {

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

	

}
