package com.spring.app.model;


import com.spring.app.domain.FleamarketCommentVO;

public interface AmadoDAO_JH {

	int addComment(FleamarketCommentVO fmcommentvo);

	int updateCommentCount(String fleamarketseq);


}
