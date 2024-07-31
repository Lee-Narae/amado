package com.spring.app.model;


import java.util.List;
import java.util.Map;

import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.GymresVO;
import com.spring.app.domain.MatchingVO;

public interface AmadoDAO_JH {

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

	ClubVO getMyClub(Map<String, String> paraMap);

	void updateviewcount(String clubseq);

	List<MatchingVO> getmatchingList(String clubseq);

	List<GymVO> getGymAdd();

	GymVO getGymInfo(String gymseq);

	GymVO getgymPay(String gymseq);

	int gymPayEnd(Map<String, String> paraMap);

	List<Map<String, String>> getgymPayDate(Map<String, String> paraMap);

	String getCost(String gymseq);

	List<Map<String, String>> getresinfo(String userid);

	int res_cancel(Map<String, String> paraMap);


}
