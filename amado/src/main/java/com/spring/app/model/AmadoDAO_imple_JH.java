package com.spring.app.model;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.FleamarketCommentReVO;
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

	@Override
	public List<FleamarketCommentVO> getCommentList(String parentSeq) {
		List<FleamarketCommentVO> commentList = sqlsession.selectList("JH.getCommentList", parentSeq);
		return commentList;
	}

	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = sqlsession.update("JH.updateComment", paraMap);
		return n;
	}

	@Override
	public int deleteComment(String fleamarketcommentseq) {
		int n = sqlsession.delete("JH.deleteComment", fleamarketcommentseq);
		return n;
	}

	// === #102.-2  댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update) === //
	@Override
	public int updateCommentCount_decrease(String fleamarketseq) {
		int n = sqlsession.update("JH.updateCommentCount_decrease", fleamarketseq);
		return n;
	}

	@Override
	public List<FleamarketCommentReVO> getCommentreList(String fleamarketcommentseq) {
		List<FleamarketCommentReVO> commentreList = sqlsession.selectList("JH.getCommentreList", fleamarketcommentseq);
		return commentreList;
	}

	@Override
	public int addReComment(FleamarketCommentReVO fmcommentrevo) {
		int n = sqlsession.insert("JH.addReComment", fmcommentrevo);
		return n;
	}

	@Override
	public int updateReCommentCount(String fleamarketcommentseq) {
		int n = sqlsession.update("JH.updateReCommentCount", fleamarketcommentseq);
		return n;
	}


}
