package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;

public interface AmadoDAO_HS {

	//체육관  완료 요쳥(파일 첨부o)
	int add_withFile(GymVO gymvo);

	int add_photofile(PhotoVO photovo);

	List<GymVO> getAllGymList();
	
	
	
	// 댓글 시작 
	int addComment(FleamarketCommentVO fmcommentvo);

	int updateCommentCount(String fleamarketseq);

	List<FleamarketCommentVO> getCommentList(String parentSeq);
	
	
	int updateComment(Map<String, String> paraMap);

	int deleteComment(String string);

	int updateCommentCount_decrease(String string);

	List<FleamarketCommentReVO> getCommentreList(String fleamarketcommentseq);

	int addReComment(FleamarketCommentReVO fmcommentrevo);

	int updateReCommentCount(String fleamarketcommentseq);

	int updateReComment(Map<String, String> paraMap);

	int deleteReComment(String fleamarketcommentreplyseq);

	int updateReCommentCount_decrease(String fleamarketcommentseq);
	// 댓글  끝
	

}
