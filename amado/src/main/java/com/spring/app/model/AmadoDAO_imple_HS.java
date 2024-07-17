package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;

@Repository
public class AmadoDAO_imple_HS implements AmadoDAO_HS {

	@Autowired // @Autowired 이것을 적고나면, 이미 SqlSessionTemplate 이 타입의 bean이 생성되어져있기에 초기값이 null이 아닌  bean id="sqlsession"이 된다.
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	
	
	
	
	//체욱관 등록
	@Override
	public int add_withFile(GymVO gymvo) {
		int n = sqlsession.insert("HS.add_withFile", gymvo);
		return n;
	}





	@Override
	public int add_photofile(PhotoVO pthotovo) {
		int n = sqlsession.insert("HS.add_photofile", pthotovo);
		return n;
	}
	
	



	@Override
	public List<GymVO> getAllGymList() {
	      //리턴타입이 맵인경우 = 맵퍼에서 resultType이 map? 인경우에만 <result>쓴다.  지금은 x
	      List<GymVO> allGymList = sqlsession.selectList("HS.getAllGymList");
	      return allGymList;
	}
	
	
	
	@Override
	public int addComment(FleamarketCommentVO fmcommentvo) {
		int n = sqlsession.insert("HS.addComment", fmcommentvo);
		return n;
	}

	@Override
	public int updateCommentCount(String fleamarketseq) {
		int n = sqlsession.update("HS.updateCommentCount", fleamarketseq);
		return n;
	}

	@Override
	public List<FleamarketCommentVO> getCommentList(String parentSeq) {
		List<FleamarketCommentVO> commentList = sqlsession.selectList("HS.getCommentList", parentSeq);
		return commentList;
	}

	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = sqlsession.update("HS.updateComment", paraMap);
		return n;
	}

	@Override
	public int deleteComment(String fleamarketcommentseq) {
		int n = sqlsession.delete("HS.deleteComment", fleamarketcommentseq);
		return n;
	}

	// === #102.-2  댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update) === //
	@Override
	public int updateCommentCount_decrease(String fleamarketseq) {
		int n = sqlsession.update("HS.updateCommentCount_decrease", fleamarketseq);
		return n;
	}

	@Override
	public List<FleamarketCommentReVO> getCommentreList(String fleamarketcommentseq) {
		List<FleamarketCommentReVO> commentreList = sqlsession.selectList("HS.getCommentreList", fleamarketcommentseq);
		return commentreList;
	}

	@Override
	public int addReComment(FleamarketCommentReVO fmcommentrevo) {
		int n = sqlsession.insert("HS.addReComment", fmcommentrevo);
		return n;
	}

	@Override
	public int updateReCommentCount(String fleamarketcommentseq) {
		int n = sqlsession.update("HS.updateReCommentCount", fleamarketcommentseq);
		return n;
	}

	@Override
	public int updateReComment(Map<String, String> paraMap) {
		int n = sqlsession.update("HS.updateReComment", paraMap);
		return n;
	}

	@Override
	public int deleteReComment(String fleamarketcommentreplyseq) {
		int n = sqlsession.delete("HS.deleteReComment", fleamarketcommentreplyseq);
		return n;
	}

	@Override
	public int updateReCommentCount_decrease(String fleamarketcommentseq) {
		int n = sqlsession.update("HS.updateReCommentCount_decrease", fleamarketcommentseq);
		return n;
	}
	
	
	


}
