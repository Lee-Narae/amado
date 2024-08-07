package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.AnswerVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.domain.QuestionVO;

public interface AmadoDAO_HS {

	//체육관  완료 요쳥(파일 첨부o)
	int add_withFile(GymVO gymvo);

	int add_photofile(PhotoVO photovo);

	List<GymVO> getAllGymList();
	

	
	// 댓글 시작 
	int addComment(QuestionVO questionvo);

	int updateCommentCount(String fleamarketseq);

	List<QuestionVO> getCommentList(String parentSeq);
	
	
	int updateComment(Map<String, String> paraMap);

	int deleteComment(String string);

	int updateCommentCount_decrease(String string);

	List<AnswerVO> getCommentreList(String gymquestionseq);

	int addReComment(AnswerVO answervo);

	int updateReCommentCount(String fleamarketcommentseq);

	int updateReComment(Map<String, String> paraMap);

	int deleteReComment(String fleamarketcommentreplyseq);

	int updateReCommentCount_decrease(String fleamarketcommentseq);
	// 댓글  끝

	// gymseq 채번
    String getGymseq();

	// 체육관 등록하기(대표이미지)
	int Gymreg(GymVO gym);
	// 체육관 등록하기(추가이미지)
	int insertGymImg(Map<String, String> paramap);
	List<GymVO> getGymAdd();

	
	GymVO getGym(String gymseq);

	List<Map<String, String>> getGymImg(String gymseq);

	
	// 관리자 - 전체 페이지 수 알아오기
	int getclubTotalPage(Map<String, String> paramap);

	// 관리자  -클럽 조회 
	List<ClubVO> select_club_paging(Map<String, String> paramap);
	
	// 관리자 - 전체 클럽 수 조회
	int getTotalClubCount(Map<String, String> paramap);
	


	// 관리자 - 클럽 상세정보
	ClubVO getClubDetail(String clubname);

	//mypage의 체육관 보기
	List<GymVO> getmypageGymList(String fk_userid);
	
	//mypage 체육관지우기
	int quitGym(Map<String, String> paramap);

	//mypage 체육관수정하기
	int Gymreg2(GymVO gym);

	

	int getgymTotalPage(Map<String, String> paramap);

	List<GymVO> select_gym_paging(Map<String, String> paramap);

	int getTotalgymCount(Map<String, String> paramap);

	




	

}
