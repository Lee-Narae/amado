package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.AnswerVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
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





}
