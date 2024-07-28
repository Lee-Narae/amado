package com.spring.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
import com.spring.app.domain.AnswerVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PhotoVO;
import com.spring.app.domain.QuestionVO;
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
	public int addComment(QuestionVO questionvo) throws Throwable{
		int n1=0, result=0;
		
		n1 = dao.addComment(questionvo); // 댓글쓰기(tbl_comment 테이블에 insert)
		System.out.println("~~~ 확인용n1: " + n1);
		
		if(n1 == 1) {
			result = dao.updateCommentCount(questionvo.getGymseq());  // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			System.out.println("~~~ 확인용result: " + result);
		}
		
		return result;
	}



	@Override
	public List<QuestionVO> getCommentList(String parentSeq) {
		List<QuestionVO> commentList = dao.getCommentList(parentSeq);
		return commentList;
	}


	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = dao.updateComment(paraMap);
		return n;
	}



	@Override
	public int deleteComment(Map<String, String> paraMap) {
		
		int n = dao.deleteComment(paraMap.get("gymquestionseq"));
		
		int m = 0;
		if(n==1) {
			// 댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update)
			m = dao.updateCommentCount_decrease(paraMap.get("gymseq"));
		//	System.out.println("~~~ 확인용 m : " + m);
			// ~~~ 확인용 m : 1
		}
		
		return n*m;
	}


	
	@Override
	public List<AnswerVO> getCommentreList(String gymquestionseq) {
		List<AnswerVO> commentreList = dao.getCommentreList(gymquestionseq);
		return commentreList;
	}



	@Override
	public int addReComment(AnswerVO answervo) throws Throwable {
		int n1=0, result=0;
		
		n1 = dao.addReComment(answervo); // 댓글쓰기(tbl_comment 테이블에 insert)
		System.out.println("~~~ 확인용n1: " + n1);
		
		if(n1 == 1) {
			result = dao.updateReCommentCount(answervo.getGymquestionseq());  // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
			// System.out.println("~~~ 확인용result: " + result);
		}
		
		return result;
	}



	@Override
	public int updateReComment(Map<String, String> paraMap) {
		int n = dao.updateReComment(paraMap);
		//System.out.println("paraMap" + paraMap.get("gymanswerseq"));
		return n;
	}



	@Override
	public int deleteReComment(Map<String, String> paraMap) {

		int n = dao.deleteReComment(paraMap.get("gymanswerseq"));
		
		int m = 0;
		if(n==1) {
			// 댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update)
			m = dao.updateReCommentCount_decrease(paraMap.get("gymquestionseq"));
			 System.out.println("~~~ 확인용 m : " + m);
			// ~~~ 확인용 m : 1
		}
		
		return n*m;
	}
	
	
	// gymseq 채번
		@Override
		public String getGymseq() {
			String gymseq = dao.getGymseq();
			return gymseq;
		}

		// 관리자 - 체육관 등록하기(대표이미지)
		@Override
		public int Gymreg(GymVO gym) {
			int n = dao.Gymreg(gym);
			return n;
		}

		// 관리자 - 체육관 등록하기(추가이미지)
		@Override
		public int insertGymImg(Map<String, String> paramap) {
			int n = dao.insertGymImg(paramap);
			return n;
		}





		@Override
		public List<GymVO> getGymAdd() {
			
			List<GymVO> GymAddList = dao.getGymAdd();
			return GymAddList;
		}





		@Override
		public GymVO getGym(String gymseq) {
		
			GymVO GetGym =dao.getGym(gymseq);
			return GetGym;
		}





		@Override
		public List<Map<String, String>> getGymImg(String gymseq) {
			 List<Map<String, String>> gymImgList= dao.getGymImg(gymseq);
			 return gymImgList;
		}




		// 관리자 -전체 클럽수 알아오기 
		@Override
		public int getclubTotalPage(Map<String, String> paramap) {
		
			
			int n = dao.getclubTotalPage(paramap);
			return n;
		}




		// 관리자  -클럽 조회 
		@Override
		public List<ClubVO> select_club_paging(Map<String, String> paramap) {
			
			List<ClubVO> clubList = dao.select_club_paging(paramap);
		
			return clubList;
		}




		// 관리자 - 전체 클럽 수 조회
		@Override
		public int getTotalClubCount(Map<String, String> paramap) {
			int n = dao.getTotalClubCount(paramap);
			return n;
		}





		@Override
		public ClubVO getClubDetail(String clubseq) {
			 ClubVO club = dao.getClubDetail(clubseq);
			return club;
		}









	
		 





}
