package com.spring.app.model;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.FleamarketCommentVO;


@Repository
public class AmadoDAO_imple_JH implements AmadoDAO_JH {
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	// /board/src/main/webapp/WEB-INF/spring/root-context.xml 의  bean에서 id가 sqlsession 인 bean을 주입하라는 뜻이다. 
    // 그러므로 sqlsession 는 null 이 아니다.
	

	@Override
	public int addComment(FleamarketCommentVO fmcommentvo) {
		int n = sqlsession.insert("JH.addComment", fmcommentvo);
		return n;
	}

	@Override
	public int updateCommentCount(String fleamarketseq) {
		int n = sqlsession.update("JH.updateCommentCount", fleamarketseq);
		return n;
	}


}
