package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;

public interface AmadoService_JH {

	int addComment(FleamarketCommentVO fmcommentvo) throws Throwable;

	List<FleamarketCommentVO> getCommentList(String parentSeq);

	int updateComment(Map<String, String> paraMap);

	int deleteComment(Map<String, String> paraMap);

	List<FleamarketCommentReVO> getCommentreList(String fleamarketcommentseq);

	int addReComment(FleamarketCommentReVO fmcommentrevo) throws Throwable;

	
}
