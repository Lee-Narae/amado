package com.spring.app.model;


import java.util.List;

import com.spring.app.domain.FleamarketCommentVO;

public interface AmadoDAO_JH {

	int addComment(FleamarketCommentVO fmcommentvo);

	int updateCommentCount(String fleamarketseq);

	List<FleamarketCommentVO> getCommentList(String parentSeq);


}
