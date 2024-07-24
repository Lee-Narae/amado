package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.AnswerVO;
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




	

}
