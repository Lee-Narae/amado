package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.AnswerVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.domain.QuestionVO;

public interface AmadoService_HS {



	int add_withFile(GymVO gymvo);

	
	int add_photofile(PhotoVO photovo);


	List<GymVO> getAllGymList();
	


	int addComment(QuestionVO questionvo) throws Throwable;

	List<QuestionVO> getCommentList(String parentSeq);

	int updateComment(Map<String, String> paraMap);

	int deleteComment(Map<String, String> paraMap);

	List<AnswerVO> getCommentreList(String gymquestionseq);

	int addReComment(AnswerVO answervo) throws Throwable;

	int updateReComment(Map<String, String> paraMap);

	int deleteReComment(Map<String, String> paraMap);

	// gymseq 채번
	String getGymseq();
	
	// 체육관 등록하기(대표이미지)
	int Gymreg(GymVO gym);
	//  체육관 등록하기(추가이미지)
	int insertGymImg(Map<String, String> paramap);


	
	List<GymVO> getGymAdd();


	
	
	
	GymVO getGym(String gymseq);


	List<Map<String, String>> getGymImg(String gymseq);

	// 관리자 -전체 클럽수 알아오기 
	int getclubTotalPage(Map<String, String> paramap);

	// 관리자 - 전체 클럽 수 조회
	List<ClubVO> select_club_paging(Map<String, String> paramap);

	// 관리자 - 전체 클럽 수 조회
	int getTotalClubCount(Map<String, String> paramap);

	// 관리자 - 클럽 상세정보
	ClubVO getClubDetail(String clubname);





	List<GymVO> getmypageGymList(String fk_userid);


	//mypage 체육관지우기
	int quitGym(Map<String, String> paramap);


	//체육관 수정하기
	int Gymreg2(GymVO gym);

	
	//체육관페이징처리
	


	int getgymTotalPage(Map<String, String> paramap);


	List<GymVO> select_gym_paging(Map<String, String> paramap);


	int getTotalgymCount(Map<String, String> paramap);


	
















}
