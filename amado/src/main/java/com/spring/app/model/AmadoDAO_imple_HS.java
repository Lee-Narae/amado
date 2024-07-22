package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.AnswerVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.domain.QuestionVO;

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
	public int addComment(QuestionVO questionvo) {
		int n = sqlsession.insert("HS.addComment", questionvo);
		return n;
	}

	@Override
	public int updateCommentCount(String gymseq) {
		int n = sqlsession.update("HS.updateCommentCount", gymseq);
		return n;
	}

	@Override
	public List<QuestionVO> getCommentList(String parentSeq) {
		List<QuestionVO> commentList = sqlsession.selectList("HS.getCommentList", parentSeq);
		return commentList;
	}

	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = sqlsession.update("HS.updateComment", paraMap);
		return n;
	}

	@Override
	public int deleteComment(String gymquestionseq) {
		int n = sqlsession.delete("HS.deleteComment", gymquestionseq);
		return n;
	}

	// === #102.-2  댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update) === //
	@Override
	public int updateCommentCount_decrease(String gymseq) {
		int n = sqlsession.update("HS.updateCommentCount_decrease", gymseq);
		return n;
	}

	@Override
	public List<AnswerVO> getCommentreList(String gymquestionseq) {
		List<AnswerVO> commentreList = sqlsession.selectList("HS.getCommentreList", gymquestionseq);
		return commentreList;
	}

	@Override
	public int addReComment(AnswerVO answervo) {
		int n = sqlsession.insert("HS.addReComment", answervo);
		return n;
	}

	@Override
	public int updateReCommentCount(String gymquestionseq) {
		int n = sqlsession.update("HS.updateReCommentCount", gymquestionseq);
		return n;
	}

	@Override
	public int updateReComment(Map<String, String> paraMap) {
		int n = sqlsession.update("HS.updateReComment", paraMap);
		return n;
	}

	@Override
	public int deleteReComment(String gymanswerseq) {
		int n = sqlsession.delete("HS.deleteReComment", gymanswerseq);
		return n;
	}

	@Override
	public int updateReCommentCount_decrease(String gymquestionseq) {
		int n = sqlsession.update("HS.updateReCommentCount_decrease", gymquestionseq);
		return n;
	}
	
	
	// gymseq 채번
		@Override
		public String getGymseq() {
			String gymseq = sqlsession.selectOne("HS.getGymseq");
			return gymseq;
		}

		// 관리자 - 체육관 등록하기(대표이미지)
		@Override
		public int Gymreg(GymVO gym) {
			int n = sqlsession.insert("HS.Gymreg", gym);
			return n;
		}
		// 관리자 - 체육관 등록하기(추가이미지)
		@Override
		public int insertGymImg(Map<String, String> paramap) {
			int n = sqlsession.insert("HS.insertGymImg", paramap);
			return n;
		}


		@Override
		public List<GymVO> getGymAdd() {
			
			List<GymVO> GymAddList = sqlsession.selectList("HS.getGymAdd");
			return GymAddList;
		}

	
	


}
