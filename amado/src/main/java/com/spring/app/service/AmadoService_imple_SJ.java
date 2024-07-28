package com.spring.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
import com.spring.app.common.Sha256;
import com.spring.app.domain.BoardCommentVO;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.InquiryFileVO;
import com.spring.app.domain.InquiryVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.model.AmadoDAO_SJ;

// 승진 서비스 임플
@Service
public class AmadoService_imple_SJ implements AmadoService_SJ {

	@Autowired
	private AmadoDAO_SJ dao;

	@Autowired
	private AES256 aES256;
	
 	@Autowired  
	private FileManager fileManager;

	// 아이디 중복 체크
	@Override
	public int idDuplicateCheck(String userid) {
		int n = 0;
		n = dao.idDuplicateCheck(userid);

		return n;
	}

	// 이메일 중복 체크
	@Override
	public int emailDuplicateCheck(String email) {
		int n = 0;
		try {
			email = aES256.encrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		n = dao.emailDuplicateCheck(email);

		return n;
	}

	// 회원가입
	@Override
	public int memberRegisterEnd(MemberVO membervo) {
		String password = membervo.getPassword();
		String email = membervo.getEmail();
		String mobile = membervo.getMobile();

		int n = 0;
		try {
			membervo.setPassword(Sha256.encrypt(password));
			membervo.setEmail(aES256.encrypt(email));
			membervo.setMobile(aES256.encrypt(mobile));

			n = dao.memberRegisterEnd(membervo);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}

		return n;
	}

	// 글쓰기
	@Override
	public int add(BoardVO boardvo) {
		int n = dao.add(boardvo);
		return n;
	}

	// 동호회목록 보기(페이지바 없음)
	@Override
	public List<ClubVO> clubListNoSearch(String params) {
		List<ClubVO> clubList = dao.clubListNoSearch(params);
		return clubList;
	}

	// 동호회 총 페이지 수(검색포함)
	@Override
	public int getClubSearchTotalPage(Map<String, String> paraMap) {
		int totalCount = dao.getClubSearchTotalPage(paraMap);
		return totalCount;
	}

	// 검색타입 있는 리스트 가져오기(페이징)
	@Override
	public List<ClubVO> searchPaging(Map<String, String> paraMap) {
		List<ClubVO> clubPagingList = dao.searchPaging(paraMap);
		return clubPagingList;
	}

	/////////////////////////////////////////////////////////////////

	// 게시판 총 페이지 수(검색포함)
	@Override
	public int getListSearchTotalPage(Map<String, String> paraMap) {
		int totalCount = dao.getListSearchTotalPage(paraMap);
		return totalCount;
	}

	// 검색타입 있거나 없는 리스트 가져오기(페이징)
	@Override
	public List<BoardVO> boardListSearchPaging(Map<String, String> paraMap) {
		List<BoardVO> boardPagingList = dao.boardListSearchPaging(paraMap);
		return boardPagingList;
	}

	// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap); // 글 1개 조회하기

		String loginuser = paraMap.get("loginuser");
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면 paraMap.get("login_userid") 은 null 이다.

		if (loginuser != null && boardvo != null && !loginuser.equals(boardvo.getFk_userid())) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다.

			int n = dao.increase_viewcount(boardvo.getBoardseq()); // 글 조회수 1 증가하기
			if (n == 1) {
				boardvo.setViewcount(String.valueOf(Integer.parseInt(boardvo.getViewcount()) + 1));
			}
		}

		return boardvo;
	}

	// 댓글쓰기(Transaction)
	// rollbackFor= {Throwable.class} 오류 뜨면 그냥 롤백해줌.
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addBoardComment(BoardCommentVO boardcommentvo) throws Throwable {
		
		int n = 0; int result = 0;
		
		int groupno = dao.getGroupnoMax()+1;
		boardcommentvo.setGroupno(Integer.toString(groupno));
		n = dao.addBoardComment(boardcommentvo); // 댓글쓰기(tbl_boardcomment 테이블에 insert)

		if(n == 1) { 
		  result = dao.updateBoardCommentCount(boardcommentvo.getParentseq()); 
		  //tbl_board 테이블에 commentCount 컬럼이 1증가(update) //
	  }
	  
		return result;
	}

	// 원게시물에 딸린 댓글들을 조회해오기
	@Override
	public List<BoardCommentVO> readComment(String parentseq) {
		List<BoardCommentVO> bdcmtList = dao.readComment(parentseq);
		return bdcmtList;
	}

	// 댓글 삭제(Ajax 로 처리) //
	// 여러 개의 쿼리를 보낼 때 하나는 성공하고 하나는 실패했을 경우 모두 롤백처리하기 위해서 @Transactional 을 사용한다.
	// (@service에서 사용한다)
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = { Throwable.class })
	public int deleteComment(Map<String, String> paraMap) throws Throwable {
		int n = 0;
		int result = 0;

		String boardcommentseq = paraMap.get("boardcommentseq");
		String parentseq = paraMap.get("parentseq");

		n = dao.deleteComment(boardcommentseq); // 댓글 삭제
//		System.out.println("~~~ 확인용 n1 : " + n1);

		if (n == 1) {
			// 댓글삭제시 tbl_board 테이블에 commentCount 컬럼이 1감소(update)
			result = dao.updateCommentCount_decrease(parentseq); // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
		}


		return result;
	}

	
	// 댓글 수정
	@Override
	public int updateComment(Map<String, String> paraMap) {
		int n = dao.updateComment(paraMap);
		return n;
	}

	
	// 답글 쓰기
	@Override
	public int addReply(BoardCommentVO boardcommentvo) {

		int n = 0;
		int result = 0;
		
		int groupno = dao.getGroupnoMax()+1;
		System.out.println("groupno 확인용~~ : " + groupno);
		boardcommentvo.setGroupno(Integer.toString(groupno)); 
		
		boardcommentvo.setGroupno(String.valueOf(groupno));
		n = dao.addReply(boardcommentvo);
		
		if(n == 1) { 
			result = dao.updateBoardCommentCount(boardcommentvo.getParentseq()); 
		    //tbl_board 테이블에 commentCount 컬럼이 1증가(update) //
		}
		
		return result;
	}

	// 답글 읽기
	@Override
	public List<BoardCommentVO> getCommentreList(String boardcommentseq) {

		List<BoardCommentVO> commentreList = null;
		
		// 답글이 있는지 없는지 확인
		int totalCount = dao.checkComment(boardcommentseq);
		
		if (totalCount != 0) {
			// 답글이 있을 경우
			
			// 댓글에 딸린 답글 가져오기
			commentreList = dao.getCommentreList(boardcommentseq);
			
		}

		return commentreList;
	}

	// 첨부파일 있는 글쓰기
	@Override
	public int add_withFile(BoardVO boardvo) {
		int n = dao.add_withFile(boardvo); // 첨부파일이 있는 경우 
		return n;
	}

	
	// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
	@Override
	public BoardVO getView_no_increase_readCount(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap); // 글 1개 조회하기
		return boardvo;
	}

	
	// 글 수정하기
	@Override
	public int edit(BoardVO boardvo) {
		int n = dao.edit(boardvo);
		return n;
	}

	
	// 글 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		
		int n = dao.del(paraMap.get("boardseq"));
		
		if(n==1) {
			String path = paraMap.get("path");
			String filename = paraMap.get("filename");
			
			if(filename != null && !"".equals(filename)) {
				try {
					fileManager.doFileDelete(filename, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return n;
	}

	
	// 파일첨부가 있는 글 수정하기
	@Override
	public int edit_withFile(BoardVO boardvo) {
		int n = dao.edit_withFile(boardvo); // 첨부파일이 있는 경우 
		return n;
	}

	
	
	
	// 내가 가입한 클럽 가져오기
	@Override
	public List<ClubmemberVO> getClubmemberList(String fk_userid) throws Exception {
		List<ClubmemberVO> clubmemberList = dao.getClubmemberList(fk_userid);
		return clubmemberList;
	}

	// 클럽 가입신청
	@Override
	public int clubMRegisterSJ(ClubmemberVO clubmembervo) {

		int n, n1, result = 0;
		
		// 한 카테고리에 이미 가입한 클럽이 있는지 확인용
		n = dao.checkClubSportseq(clubmembervo);
		result = 99;
		if(n == 0) {
			// 이미 클럽가입 신청했거나 가입됐는지 확인용
			n1 = dao.getclubAry(clubmembervo);
			
			if(n1 == 0) {
				// 가입하려는 카테고리에 이미 가입한 클럽이 없고, 가입신청하지 않았을 경우
				
				// 클럽 가입신청
				result = dao.clubMRegisterSJ(clubmembervo);
			}
		}
		
		return result;
	}

	
	
	@Override
	public int findseq_inquiry(Map<String, Object> paraMap) {
		int inquiryseq = dao.findseq_inquiry(paraMap);
		return inquiryseq;
	}
	
	// 파일첨부가 있는 1대1 문의
	@Override
	public int InquiryFile(Map<String, Object> paraMap){
		int result = 0;
		// 자식테이블인 첨부파일 쪽에다가 insert 해준다.
		result = dao.InquiryFileTable(paraMap); // tbl_inquiryFile 에 넣기 (첨부파일이 있는 경우)
		return result;
	}

	// 파일첨부가 없는 1대1 문의
	@Override
	public int Inquiry(Map<String, Object> paraMap) {
		int result = dao.Inquiry(paraMap); // tbl_inquiry 에 넣기
		return result;
	}

	// 멤버정보 가져오기
	@Override
	public MemberVO getMemberInfo(String fk_userid) {
			
		MemberVO loginuser = dao.getMemberInfo(fk_userid);	
			
		String email = "";
		String mobile = "";
		try {
			email = aES256.decrypt(loginuser.getEmail());
			mobile = aES256.decrypt(loginuser.getMobile());
			
			loginuser.setEmail(email);
			loginuser.setMobile(mobile);
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return loginuser;
	}

	
	// 문의목록 가져오기
	@Override
	public List<InquiryVO> getinquiryList(String fk_userid) {
	    List<Map<String, String>> inquiryLista = dao.getinquiryList(fk_userid);
	    List<InquiryVO> inquiryList = new ArrayList<>(); // 초기화
	    
	    System.out.println("getinquiryList fk_userid : " + fk_userid);

	    if (inquiryLista != null && !inquiryLista.isEmpty()) {
	        for (Map<String, String> inquiryMap : inquiryLista) {
	            InquiryVO inquiryVO = new InquiryVO(); // 새 객체 생성
	            
	            inquiryVO.setInquiryseq(inquiryMap.get("inquiryseq"));
	            inquiryVO.setContent(inquiryMap.get("content"));
	            inquiryVO.setFk_userid(inquiryMap.get("fk_userid"));
	            inquiryVO.setEmail(inquiryMap.get("email"));
	            inquiryVO.setPhone(inquiryMap.get("phone"));
	            inquiryVO.setRegisterdate(inquiryMap.get("registerdate"));
	            inquiryVO.setSearchtype_a(inquiryMap.get("searchtype_a"));
	            inquiryVO.setSearchtype_b(inquiryMap.get("searchtype_b"));
	            inquiryVO.setStatus(inquiryMap.get("status"));
	            inquiryVO.setAnswer(inquiryMap.get("answer"));

	            if (inquiryMap.get("filename") != null || inquiryMap.get("filesize") != null || inquiryMap.get("orgfilename") != null) {
	                InquiryFileVO inquiryfilevo = new InquiryFileVO();
	                inquiryfilevo.setFilename(inquiryMap.get("filename"));
	                inquiryfilevo.setFilesize(inquiryMap.get("filesize"));
	                inquiryfilevo.setOrgfilename(inquiryMap.get("orgfilename"));
	                inquiryVO.setInquiryfilevo(inquiryfilevo);
	            }

	            inquiryList.add(inquiryVO); // 리스트에 추가
	        }
	    }

	    return inquiryList;
	}

	
	@Override
	public int getTotalInquiryCount(Map<String, String> paraMap) {
		int totalCount = dao.getTotalInquiryCount(paraMap);
		System.out.println("getTotalInquiryCount fk_userid : " + paraMap.get("fk_userid"));
		return totalCount;
	}

	
	@Override
	public List<InquiryVO> getPaginginquiryList(Map<String, String> paraMap) {
		List<InquiryVO> inquiryPagingList = dao.getPaginginquiryList(paraMap); 
		System.out.println("getPaginginquiryList fk_userid : " + paraMap.get("fk_userid"));
		return inquiryPagingList;
	}

	
	@Override
	public InquiryVO inquiryGoDetail(String inquiryseq) {
		InquiryVO inquiryvo = dao.inquiryGoDetail(inquiryseq);
		
		return inquiryvo;
	}

	@Override
	public List<InquiryFileVO> inquiryFileGoDetail(String inquiryseq) {
		List<InquiryFileVO> inquiryfileList = dao.inquiryFileGoDetail(inquiryseq);
		return inquiryfileList;
	}

	
	@Override
	public InquiryFileVO getView_inquiry(Map<String, String> paraMap) {
		InquiryFileVO inquiryfilevo = dao.getView_inquiry(paraMap);
		return inquiryfilevo;
	}



}