package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.Calendar_schedule_VO;
import com.spring.app.domain.Calendar_small_category_VO;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.ClubmemberVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;

@Repository
public class AmadoDAO_imple_JY implements AmadoDAO_JY {

	@Autowired				 
	@Qualifier("sqlsession") 
	private SqlSessionTemplate sqlsession;

	
	////////////////////////////////////////////////////////////////
	

	// 시군구 정보
	@Override
	public List<Map<String, String>> getCityList() {
		List<Map<String, String>> cityList = sqlsession.selectList("JY.getCityList");
		return cityList;
	}

	// 상세지역 정보
	@Override
	public List<String> getLocalList(String cityname) {
		List<String> localList = sqlsession.selectList("JY.getLocalList", cityname);
		return localList;
	}
	
	
	// 동호회등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(ClubVO clubvo) {
		int n = sqlsession.insert("JY.add_withFile",clubvo);
		return n;

	}

	
	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	@Override
	public int updateRank(String fk_userid) {
		int n = sqlsession.update("JY.updateRank",fk_userid);
		return n;
	}
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	@Override
	public int insertCmemberTbl(ClubVO clubvo) {
		int n2 = sqlsession.insert("JY.insertCmemberTbl",clubvo);
		return n2;
	}

	
	// 운동 종목 시퀀스가져오기
	@Override
	public List<String> getSportList() {
		List<String> sportList = sqlsession.selectList("JY.getSportList");
		return sportList;
	}

	
	// 상품 select 헤오기
	@Override
	public List<Map<String, String>> getSportNameList(String sportname) {
		List<Map<String, String>> sportNameList = sqlsession.selectList("JY.getSportNameList", sportname);
		return sportNameList;
	}

	// 상품등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(FleamarketVO fvo) {
		int n = sqlsession.insert("JY.add_withFilee",fvo);
		return n;
	}

	// 모든 상품 select 해오기
	@Override
	public List<FleamarketVO> getAllItemList() { 
		//리턴타입이 맵인경우 = 맵퍼에서 resultType이 map? 인경우에만 <result>쓴다.  지금은 x
		List<FleamarketVO> allItemList = sqlsession.selectList("JY.getAllItemList");
		return allItemList;
	}

	// 상품 전체 개수 불러오기
	@Override
	public int getItemCnt(Map<String, String> paraMap) {
		int itemCnt = sqlsession.selectOne("JY.getItemCnt", paraMap);
		return itemCnt;
	}
	


	// 동일한 종목의 동호회 가입하는지 확인
	@Override
	public String checkseq(Map<String, String> paraMap) {
		String checkseq = sqlsession.selectOne("JY.checkseq", paraMap);
		return checkseq;
	}

	
	// 동호회 게시판 - 총페이지수
	@Override
	public int getTotalPage(Map<String, String> paramap) {
		int n = sqlsession.selectOne("JY.getTotalPage", paramap);
		return n;
	}

	
	// 동호회 게시판 - 페이징처리
	@Override
	public List<ClubBoardVO> select_clubboard_paging(Map<String, String> paramap) {
		List<ClubBoardVO> clubboard = sqlsession.selectList("JY.select_clubboard_paging", paramap);
		return clubboard;
	}

	
	// 동호회 게시판 - 게시글 개수
	@Override
	public int getTotalCount(Map<String, String> paramap) {
		int n = sqlsession.selectOne("JY.getTotalCount", paramap);
		return n;
	}

	// 동호회 게시판 - 디테일
	@Override
	public ClubBoardVO getClubboardDetail(Map<String, String> paramap) {
		ClubBoardVO cboard = sqlsession.selectOne("JY.getClubboardDetail", paramap);
		return cboard;
	}

	

	// 동호회게시판 조회수 올리기
	@Override
	public void updateCboardViewcount(String clubboardseq) {
		sqlsession.update("JY.updateCboardViewcount", clubboardseq);
	}

	
	
	// 등록된 일정 가져오기
	@Override
	public List<Calendar_schedule_VO> selectSchedule(String fk_userid) {
		List<Calendar_schedule_VO> scheduleList = sqlsession.selectList("JY.selectSchedule", fk_userid);
		return scheduleList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 동호회캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existComCalendar(String com_smcatgoname) {
		int m = sqlsession.selectOne("JY.existComCalendar", com_smcatgoname);
		return m;
	}

	// 사내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addComCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("JY.addComCalendar", paraMap);
		return n;
	}

	
	// 동호회캘린더에서 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showCompanyCalendar() {
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = sqlsession.selectList("JY.showCompanyCalendar");  
		return calendar_small_category_VO_CompanyList;
	}

	
	// 수정된 (동호회캘린더 또는 내캘린더)속의 소분류 카테고리명이 이미 해당 사용자가 만든 소분류 카테고리명으로 존재하는지 유무 알아오기  
	@Override
	public int existsCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("JY.existsCalendar", paraMap);
		return m;
	}

	
	// (동호회캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기
	@Override
	public int editCalendar(Map<String, String> paraMap) {
		int n = sqlsession.update("JY.editCalendar", paraMap);
		return n;
	}

	
	// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existMyCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("JY.existMyCalendar", paraMap);
		return m;
	}

	
	// 내 캘린더에 내캘린더 소분류 추가하기
	@Override
	public int addMyCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("JY.addMyCalendar", paraMap);
		return n;
	}

	
	// 내 캘린더에서 내캘린더 소분류  보여주기 
	@Override
	public List<Calendar_small_category_VO> showMyCalendar(String fk_userid) {
		List<Calendar_small_category_VO> calendar_small_category_VO_MyList = sqlsession.selectList("JY.showMyCalendar", fk_userid);  
		return calendar_small_category_VO_MyList;
	}

	
	// (동호회캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기 
	@Override
	public int deleteSubCalendar(String smcatgono) {
		int n = sqlsession.delete("JY.deleteSubCalendar", smcatgono);
		return n;
	}

	
	// 총 일정 검색 건수
	@Override
	public int getS_totalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("JY.getS_totalCount", paraMap);
		return n;
	}

	
	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String,String>> scheduleListSearchWithPaging(Map<String, String> paraMap) { 
		List<Map<String,String>> scheduleList = sqlsession.selectList("JY.scheduleListSearchWithPaging", paraMap);
		return scheduleList;
	}

	
	// 일정 상세 보기 
	@Override
	public Map<String, String> detailSchedule(String scheduleno) {
		Map<String,String> map = sqlsession.selectOne("JY.detailSchedule", scheduleno);
		return map;
	}

	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 
	@Override
	public List<Calendar_small_category_VO> selectSmallCategory(Map<String, String> paraMap) {
		List<Calendar_small_category_VO> small_category_VOList = sqlsession.selectList("JY.selectSmallCategory", paraMap);
		return small_category_VOList;
	}

	
	// 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기
	@Override
	public List<MemberVO> searchJoinUserList(String joinUserName) {
		List<MemberVO> joinUserList = sqlsession.selectList("JY.searchJoinUserList", joinUserName);
		return joinUserList;
	}

	
	// 일정 등록하기
	@Override
	public int registerSchedule_end(Map<String, String> paraMap) {
		int n = sqlsession.insert("JY.registerSchedule_end", paraMap);
		return n;
	}

	
	// 일정삭제하기
	@Override
	public int deleteSchedule(String scheduleno) {
		int n = sqlsession.delete("JY.deleteSchedule", scheduleno);
		return n;
	}

	
	// 일정수정하기
	@Override
	public int editSchedule_end(Calendar_schedule_VO svo) {
		int n = sqlsession.update("JY.editSchedule_end", svo);
		return n;
	}

	
	// 내가 속한 동호회 종목 리스트 가져오기
	@Override
	public List<ClubmemberVO> selectclubCategoryList(String fk_userid) {
		List<ClubmemberVO> clubCategoryList = sqlsession.selectList("JY.selectclubCategoryList", fk_userid);
		return clubCategoryList;
	}

	
	// 동호회게시판 댓글 불러오기
	@Override
	public List<Map<String, String>> getCBoardComment(String clubboardseq) {
		List<Map<String, String>> commentList = sqlsession.selectList("JY.getCBoardComment", clubboardseq);
		return commentList;
	}

	
	// 동호회게시판 댓글 개수
	@Override
	public String getCBoardCommentCount(String clubboardseq) {
		String commentCount = sqlsession.selectOne("JY.getCBoardCommentCount", clubboardseq);
		return commentCount;
	}

	
	// 동호회게시판  - 댓글 insert
	@Override
	public int insertCBoardComment(Map<String, String> paramap) {
		int n = sqlsession.insert("JY.insertCBoardComment", paramap);
		return n;
	}

	
	// 댓글cnt 올리기
	@Override
	public void updateCBoardCommentcount(String clubboardseq) {
		sqlsession.update("JY.updateCBoardCommentcount", clubboardseq);
		
	}

	
	// 댓글 삭제
	@Override
	public int delCBoardComment(String clubboardcommentseq) {
		int n = sqlsession.delete("JY.delCBoardComment", clubboardcommentseq);
		return n;
	}

	@Override
	public void updateCBoardCommentcount_del(String clubboardseq) {
		sqlsession.update("JY.updateCBoardCommentcount_del", clubboardseq);
		
	}

	
	// 댓글 수정
	@Override
	public int editCBoardComment(Map<String, String> paramap) {
		int n = sqlsession.update("JY.editCBoardComment", paramap);
		
		return n;
	}

	
	// 글삭하기
	@Override
	public int deleteCBoard(String clubboardseq) {
		int n = sqlsession.delete("JY.deleteCBoard", clubboardseq);
		return n;
	}

	
	// 동호회게ㅛ시판글쓰기
	@Override
	public int add_withFile2(Map<String, String> paramap) {
		int n = sqlsession.insert("JY.add_withFile2",paramap);
		return n;
	}
	@Override
	public int add(Map<String, String> paraMap) {
		int n = sqlsession.insert("JY.add", paraMap);
		return n;
	}

	@Override
	public List<Map<String, String>> getGymBarchart(String gymname) {
		List<Map<String, String>> mapList = sqlsession.selectList("JY.getGymBarchart", gymname);
		return mapList;
	}

	
	// 체육관이름 가져오기
	@Override
	public List<GymVO> getGymList() {
		List<GymVO> gymList = sqlsession.selectList("JY.getGymList");
		return gymList;
	}

	
	// 동호회 - 종목별로 가입요청이 가장 많은 동호회 이름 가져오기
	@Override
	public String getMostclubName(int i) {
		String mostclubName = sqlsession.selectOne("JY.getMostclubName", i);
		return mostclubName;
	}

	@Override
	public Map<String, String> getMostclubNameSeq(int i) {
		Map<String, String> mostclubNameSeq = sqlsession.selectOne("JY.getMostclubNameSeq", i);
		return mostclubNameSeq;
	}

	@Override
	public String getNewClubseq() {
		String clubseq = sqlsession.selectOne("JY.getNewClubseq");
		return clubseq;
	}

	

	@Override
	public void insertCalcname(ClubVO clubvo) {
		sqlsession.insert("JY.insertCalcname", clubvo);
		
	}

	@Override
	public List<Map<String,String>> getMyclubList(String fk_userid) {
		List<Map<String,String>> myclubList = sqlsession.selectList("JY.getMyclubList", fk_userid);
		return myclubList;
	}

	@Override
	public ClubBoardVO editClubBoard(String clubseq) {
		ClubBoardVO editCBoard = sqlsession.selectOne("JY.editClubBoard", clubseq);
		return editCBoard;
	}

	@Override
	public ClubBoardVO editCBoard_get(String clubboardseq) {
		ClubBoardVO editCBoard = sqlsession.selectOne("JY.editCBoard_get", clubboardseq);
		return editCBoard;
	}

	@Override
	public Map<String, String> getOrgfilename(String clubboardseq) {
		Map<String, String> filenameMap = sqlsession.selectOne("JY.getOrgfilename", clubboardseq);
		return filenameMap;
	}

	
	// 동호회게시판 수정하기(1)
	@Override
	public int editCBoardBy1(ClubBoardVO cvo) {
		int n = sqlsession.update("JY.editCBoardBy1", cvo);
		return n;
	}





}
