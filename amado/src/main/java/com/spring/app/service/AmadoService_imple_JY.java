package com.spring.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.FileManager;
import com.spring.app.domain.Calendar_schedule_VO;
import com.spring.app.domain.Calendar_small_category_VO;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.model.AmadoDAO_JY;

@Service
public class AmadoService_imple_JY implements AmadoService_JY {
	
	@Autowired
	private AmadoDAO_JY dao;

 	// 첨부파일 삭제를 위한것 
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	
	
	
	//////////////////////////////////////////////
	



	// 시군구 정보
	@Override
	public List<Map<String, String>> getCityList() {
		List<Map<String, String>> cityList = dao.getCityList();
		return cityList;
	}



	// 상세지역 정보
	@Override
	public List<String> getLocalList(String cityname) {
		List<String> localList = dao.getLocalList(cityname);
		return localList;
	}


	// 동호회등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(ClubVO clubvo) {
		int n = dao.add_withFile(clubvo); //첨부파일이 있는경우
		return n;
	}
	
	

	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	@Override
	public int updateRank(String fk_userid) {
		int n = dao.updateRank(fk_userid);
		return n;
	}
	
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	@Override
	public void insertCmemberTbl(ClubVO clubvo) {
		dao.insertCmemberTbl(clubvo);
			
	}

	// 상품 select 헤오기
	@Override
	public List<Map<String, String>> getSportNameList(String sportname) {
		List<Map<String, String>> sportNameList = dao.getSportNameList(sportname);
		return sportNameList;
	}


	// 상품등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(FleamarketVO fvo) {
		int n = dao.add_withFile(fvo); //첨부파일이 있는경우
		return n;
	}


	// 모든 상품 select 해오기
	@Override
	public List<FleamarketVO> getAllItemList() {
		List<FleamarketVO> allItemList = dao.getAllItemList();
		return allItemList;
	}


	// 상품 전체 개수 불러오기
	@Override
	public int getItemCnt(Map<String, String> paraMap) {
		int itemCnt = dao.getItemCnt(paraMap);
		return itemCnt;
	}




	// 동일한 종목의 동호회 가입하는지 확인
	@Override
	public String checkseq(Map<String, String> paraMap) {
		String checkseq = dao.checkseq(paraMap);
		return checkseq;
	}



	// 동호회 게시판 - 총페이지수
	@Override
	public int getTotalPage(Map<String, String> paramap) {
		int n = dao.getTotalPage(paramap);
		return n;
	}


	// 동호회 게시판 - 페이징처리
	@Override
	public List<ClubBoardVO> select_clubboard_paging(Map<String, String> paramap) {
		List<ClubBoardVO> clubboardList = dao.select_clubboard_paging(paramap);
		return clubboardList;
	}


	// 동호회 게시판 - 게시글 개수
	@Override
	public int getTotalCount(Map<String, String> paramap) {
		int n = dao.getTotalCount(paramap);
		return n;
	}


	// 동호회 게시판 - 디테일
	@Override
	public ClubBoardVO getClubboardDetail(Map<String, String> paramap) {
		ClubBoardVO cboard = dao.getClubboardDetail(paramap);
		return cboard;
	}


	// 동호회게시판 조회수 올리기
	@Override
	public void updateCboardViewcount(String clubboardseq) {
		dao.updateCboardViewcount(clubboardseq);
		
	}

	
	// 등록된 일정 가져오기
	@Override
	public List<Calendar_schedule_VO> selectSchedule(String fk_userid) {
		List<Calendar_schedule_VO> scheduleList = dao.selectSchedule(fk_userid);
		return scheduleList;
	}

	
	
	// 동호회캘린더에 소분류 추가하기
	@Override
	public int addComCalendar(Map<String, String> paraMap) throws Throwable {
		
		int n=0;
		String com_smcatgoname = paraMap.get("com_smcatgoname");
		
		// 동호회캘린더에 캘린더 소분류 명 존재 여부 알아오기
		int m = dao.existComCalendar(com_smcatgoname);
		
		if(m==0) {
			n = dao.addComCalendar(paraMap);
		}
		
		return n;
	}


	// 동호회캘린더에서 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showCompanyCalendar() {
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = dao.showCompanyCalendar(); 
		return calendar_small_category_VO_CompanyList;
	}


	// (동호회캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기
	@Override
	public int editCalendar(Map<String, String> paraMap) {
		int n = 0;
		
		int m = dao.existsCalendar(paraMap); 
		// 수정된 (동호회캘린더 또는 내캘린더)속의 소분류 카테고리명이 이미 해당 사용자가 만든 소분류 카테고리명으로 존재하는지 유무 알아오기  
		
		if(m==0) {
			n = dao.editCalendar(paraMap);	
		}
		
		return n;
	}


	// 내 캘린더에 내캘린더 소분류 추가하기
	@Override
	public int addMyCalendar(Map<String, String> paraMap) {
		int n=0;
		
		// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		int m = dao.existMyCalendar(paraMap);
		
		if(m==0) {
			n = dao.addMyCalendar(paraMap);
		}
		
		return n;
	}



	// 내 캘린더에서 내캘린더 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showMyCalendar(String fk_userid) {
		List<Calendar_small_category_VO> calendar_small_category_VO_MyList = dao.showMyCalendar(fk_userid); 
		return calendar_small_category_VO_MyList;
	}


	// (동호회캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기 
	@Override
	public int deleteSubCalendar(String smcatgono) {
		int n = dao.deleteSubCalendar(smcatgono);
		return n;
	}


	// 총 일정 검색 건수
	@Override
	public int getS_totalCount(Map<String, String> paraMap) {
		int n = dao.getS_totalCount(paraMap);
		return n;
	}



	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap) {
		List<Map<String,String>> scheduleList = dao.scheduleListSearchWithPaging(paraMap);
		return scheduleList;
	}


	// 일정 상세
	@Override
	public Map<String, String> detailSchedule(String scheduleno) {
		Map<String,String> map = dao.detailSchedule(scheduleno);
		return map;
	}


	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 
	@Override
	public List<Calendar_small_category_VO> selectSmallCategory(Map<String, String> paraMap) {
		List<Calendar_small_category_VO> small_category_VOList = dao.selectSmallCategory(paraMap);
		return small_category_VOList;
	}


	// 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기
	@Override
	public List<MemberVO> searchJoinUserList(String joinUserName) {
		List<MemberVO> joinUserList = dao.searchJoinUserList(joinUserName);
		return joinUserList;
	}


	// 일정 등록하기
	@Override
	public int registerSchedule_end(Map<String, String> paraMap) {
		int n = dao.registerSchedule_end(paraMap);
		return n;
	}


	// 일정삭제하기 
	@Override
	public int deleteSchedule(String scheduleno) {
		int n = dao.deleteSchedule(scheduleno);
		return n;
	}


	// 일정수정하기
	@Override
	public int editSchedule_end(Calendar_schedule_VO svo) {
		int n = dao.editSchedule_end(svo);
		return n;
	}


	// 내가 속한 동호회 종목 리스트 가져오기
	@Override
	public List<ClubmemberVO> selectclubCategoryList(String fk_userid) {
		List<ClubmemberVO> clubCategoryList = dao.selectclubCategoryList(fk_userid);
		return clubCategoryList;
	}


	// 동호회게시판 댓글 불러오기
	@Override
	public List<Map<String, String>> getCBoardComment(String clubboardseq) {
		List<Map<String, String>> commentList = dao.getCBoardComment(clubboardseq);
		return commentList;
	}


	// 동호회게시판  - 댓글 개수
	@Override
	public String getCBoardCommentCount(String clubboardseq) {
		String commentCount = dao.getCBoardCommentCount(clubboardseq);
		return commentCount;
	}


	// 동호회게시판  - 댓글 insert
	@Override
	public int insertCBoardComment(Map<String, String> paramap) {
		int n = dao.insertCBoardComment(paramap);
		return n;
	}


	// 댓글cnt 올리기
	@Override
	public void updateCBoardCommentcount(String clubboardseq) {
		dao.updateCBoardCommentcount(clubboardseq);
	}


	// 댓글 삭제
	@Override
	public int delCBoardComment(String clubboardcommentseq) {
		int n = dao.delCBoardComment(clubboardcommentseq);
		return n;
	}



	@Override
	public void updateCBoardCommentcount_del(String clubboardseq) {
		dao.updateCBoardCommentcount_del(clubboardseq);			
	}


	// 댓글 수정
	@Override
	public int editCBoardComment(Map<String, String> paramap) {
		int n = dao.editCBoardComment(paramap);
		
		return n;
	}


	// 글삭하기
	@Override
	public int deleteCBoard(String clubboardseq) {
		int n = dao.deleteCBoard(clubboardseq);
		return n;
	}


	


	
	












	

	
	
	
	
	

}
