package com.spring.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.common.AES256;
import com.spring.app.domain.FleamarketCommentReVO;
import com.spring.app.domain.FleamarketCommentVO;
import com.spring.app.model.AmadoDAO_JH;

@Service
public class AmadoService_imple_JH implements AmadoService_JH {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AmadoDAO_JH dao;

	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
    @Autowired
    private AES256 aES256;
    // Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aES256 에 주입시켜준다. 
    // 그러므로 aES256 는 null 이 아니다.
   // com.spring.app.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
	
	
	
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
		System.out.println("~~~ 확인용n1: " + n1);
		
		if(n1 == 1) {
			result = dao.updateReCommentCount(fmcommentrevo.getFleamarketcommentseq());  // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			System.out.println("~~~ 확인용result: " + result);
		}
		
		return result;
	}

}
