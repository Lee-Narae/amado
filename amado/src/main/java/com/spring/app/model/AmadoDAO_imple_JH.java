package com.spring.app.model;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.GymresVO;
import com.spring.app.domain.MatchingVO;


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

	@Override
	public int updateReComment(Map<String, String> paraMap) {
		int n = sqlsession.update("JH.updateReComment", paraMap);
		return n;
	}

	@Override
	public int deleteReComment(String fleamarketcommentreplyseq) {
		int n = sqlsession.delete("JH.deleteReComment", fleamarketcommentreplyseq);
		return n;
	}

	@Override
	public int updateReCommentCount_decrease(String fleamarketcommentseq) {
		int n = sqlsession.update("JH.updateReCommentCount_decrease", fleamarketcommentseq);
		return n;
	}

	@Override
	public ClubVO getMyClub(Map<String, String> paraMap) {
		ClubVO clubvo = sqlsession.selectOne("JH.getMyClub", paraMap);
		return clubvo;
	}

	@Override
	public void updateviewcount(String clubseq) {
		sqlsession.update("JH.updateviewcount", clubseq);
	}

	@Override
	public List<MatchingVO> getmatchingList(String clubseq) {
		List<MatchingVO> getmatchingList = sqlsession.selectList("JH.getmatchingList", clubseq);
		return getmatchingList;
	}

	@Override
	public List<GymVO> getGymAdd() {
		List<GymVO> GymAddList = sqlsession.selectList("JH.getGymAdd");
		return GymAddList;
	}

	@Override
	public GymVO getGymInfo(String gymseq) {
		GymVO gymvo = sqlsession.selectOne("JH.getGymInfo", gymseq);
		return gymvo;
	}

	@Override
	public GymVO getgymPay(String gymseq) {
		GymVO gymvo = sqlsession.selectOne("JH.getgymPay", gymseq);
		return gymvo;
	}

	@Override
	public int gymPayEnd(Map<String, String> paraMap) {
		int n = sqlsession.insert("JH.gymPayEnd", paraMap);
		return n;
	}

	@Override
	public List<Map<String, String>> getgymPayDate(Map<String, String> paraMap) {
		List<Map<String, String>> gymDateList = sqlsession.selectList("JH.getgymPayDate", paraMap);
		return gymDateList;
	}

	@Override
	public String getCost(String gymseq) {
		String cost = sqlsession.selectOne("JH.getCost", gymseq);
		return cost;
	}

	@Override
	public List<Map<String, String>> getresinfo(Map<String, String> paraMap) {
		List<Map<String, String>> resList = sqlsession.selectList("JH.getresinfo", paraMap);
		return resList;
	}

	@Override
	public int res_cancel(Map<String, String> paraMap) {
		int n = sqlsession.delete("JH.res_cancel", paraMap);
		return n;
	}

	@Override
	public int getTotalCount(String userid) {
		int totalCount = sqlsession.selectOne("JH.getTotalCount", userid);
		return totalCount;
	}

	@Override
	public Map<String, String> getviewresList(String userid) {
		Map<String, String> viewresMap = sqlsession.selectOne("JH.getviewresList", userid);
		return viewresMap;
	}

	@Override
	public FleamarketVO getfleMap(String fleamarketseq) {
		FleamarketVO fleMap = sqlsession.selectOne("JH.getfleMap", fleamarketseq);
		return fleMap;
	}


}
