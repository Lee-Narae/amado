package com.spring.app.model;


import java.util.List;
import java.util.Map;

import com.spring.app.domain.FleamarketCommentVO;

public interface AmadoDAO_JH {

	int addComment(FleamarketCommentVO fmcommentvo);

	int updateCommentCount(String fleamarketseq);

	List<FleamarketCommentVO> getCommentList(String parentSeq);

	int updateComment(Map<String, String> paraMap);

	int deleteComment(String string);

	int updateCommentCount_decrease(String string);


}
