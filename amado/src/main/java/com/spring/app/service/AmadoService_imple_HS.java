package com.spring.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.model.AmadoDAO_HS;



@Service
public class AmadoService_imple_HS implements AmadoService_HS {


	@Autowired
	private AmadoDAO_HS dao;
	
    @Autowired
    private AES256 aES256;
	
	
	
	
	// ===#186. 첨부파일 삭제를 위한것 ==
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	
	


	//체육관 등록
	@Override
	public int add_withFile(GymVO gymvo) {
	
		int n = dao.add_withFile(gymvo);
		return n;
	}





	@Override
	public int add_photofile(PhotoVO photovo) {
		int n = dao.add_photofile(photovo);
		return n;
	}





	@Override
	public List<GymVO> getAllGymList() {
		 List<GymVO> allGymList = dao.getAllGymList();
		return allGymList;
	}


	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addComment(FleamarketCommentVO fmcommentvo) throws Throwable{
		int n1=0, result=0;
		
		n1 = dao.addComment(fmcommentvo); // 댓글쓰기(tbl_comment 테이블에 insert)
		//System.out.println("~~~ 확인용n1: " + n1);
		
		if(n1 == 1) {
			result = dao.updateCommentCount(fmcommentvo.getFleamarketseq());  // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			//System.out.println("~~~ 확인용result: " + result);
		}
		
		return result;
	}



	@Override
	public List<FleamarketCommentVO> getCommentList(String parentSeq) {
		List<FleamarketCommentVO> commentList = dao.getCommentList(parentSeq);
		return commentList;
	}


	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = dao.updateComment(paraMap);
		return n;
	}



	@Override
	public int deleteComment(Map<String, String> paraMap) {
		
		int n = dao.deleteComment(paraMap.get("fleamarketcommentseq"));
		
		int m = 0;
		if(n==1) {
			// 댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update)
			m = dao.updateCommentCount_decrease(paraMap.get("fleamarketseq"));
		//	System.out.println("~~~ 확인용 m : " + m);
			// ~~~ 확인용 m : 1
		}
		
		return n*m;
	}


	
	@Override
	public List<FleamarketCommentReVO> getCommentreList(String fleamarketcommentseq) {
		List<FleamarketCommentReVO> commentreList = dao.getCommentreList(fleamarketcommentseq);
		return commentreList;
	}



	@Override
	public int addReComment(FleamarketCommentReVO fmcommentrevo) throws Throwable {
		int n1=0, result=0;
		
		n1 = dao.addReComment(fmcommentrevo); // 댓글쓰기(tbl_comment 테이블에 insert)
		//System.out.println("~~~ 확인용n1: " + n1);
		
		if(n1 == 1) {
			result = dao.updateReCommentCount(fmcommentrevo.getFleamarketcommentseq());  // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			//System.out.println("~~~ 확인용result: " + result);
		}
		
		return result;
	}



	@Override
	public int updateReComment(Map<String, String> paraMap) {
		int n = dao.updateReComment(paraMap);
		return n;
	}



	@Override
	public int deleteReComment(Map<String, String> paraMap) {

		int n = dao.deleteReComment(paraMap.get("fleamarketcommentreplyseq"));
		
		int m = 0;
		if(n==1) {
			// 댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update)
			m = dao.updateReCommentCount_decrease(paraMap.get("fleamarketcommentseq"));
			// System.out.println("~~~ 확인용 m : " + m);
			// ~~~ 확인용 m : 1
		}
		
		return n*m;
	}





}
