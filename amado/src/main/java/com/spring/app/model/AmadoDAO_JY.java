package com.spring.app.model;

import java.util.List;
import java.util.Map;

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

public interface AmadoDAO_JY {
	
	
	// 시군구 정보
	List<Map<String, String>> getCityList();
	
	// 상세지역 정보
	List<String> getLocalList(String cityname);
	
	// 동호회등록  완료 요청(파일첨부ㅇ)
	int add_withFile(ClubVO clubvo);

	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	int updateRank(String fk_userid);
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	int insertCmemberTbl(ClubVO clubvo);

	// 운동 종목 시퀀스가져오기
	List<String> getSportList();

	// 상품 select 헤오기
	List<Map<String, String>> getSportNameList(String sportname);

	// 상품등록  완료 요청(파일첨부ㅇ)
	int add_withFile(FleamarketVO fvo);
	
	// 모든 상품 select 해오기
	List<FleamarketVO> getAllItemList();

	// 상품 전체 개수 불러오기
	int getItemCnt(Map<String, String> paraMap);
	

	// 동일한 종목의 동호회 가입하는지 확인
	String checkseq(Map<String, String> paraMap);

	// 동호회 게시판 - 총페이지수
	int getTotalPage(Map<String, String> paramap);

	// 돌아갈페이지
	List<ClubBoardVO> select_clubboard_paging(Map<String, String> paramap);

	// 동호회 게시판 - 게시글 개수
	int getTotalCount(Map<String, String> paramap);

	// 동호회 게시판 - 디테일
	ClubBoardVO getClubboardDetail(Map<String, String> paramap);

	// 동호회게시판 조회수 올리기
	void updateCboardViewcount(String clubboardseq);
	
	
	List<Calendar_schedule_VO> selectSchedule(String fk_userid);
	

	// 사내 캘린더의 소분류인 일정 이름 존재 여부 알아오기
	int existComCalendar(String com_smcatgoname);

	// 사내 캘린더에 캘린더 소분류 추가하기
	int addComCalendar(Map<String, String> paraMap)throws Throwable;

	List<Calendar_small_category_VO> showCompanyCalendar();

	int existsCalendar(Map<String, String> paraMap);

	int editCalendar(Map<String, String> paraMap);

	int existMyCalendar(Map<String, String> paraMap);

	int addMyCalendar(Map<String, String> paraMap);

	List<Calendar_small_category_VO> showMyCalendar(String fk_userid);

	int deleteSubCalendar(String smcatgono);

	int getS_totalCount(Map<String, String> paraMap);

	List<Map<String, String>> scheduleListSearchWithPaging(Map<String, String> paraMap);

	Map<String, String> detailSchedule(String scheduleno);

	List<Calendar_small_category_VO> selectSmallCategory(Map<String, String> paraMap);

	List<MemberVO> searchJoinUserList(String joinUserName);

	int registerSchedule_end(Map<String, String> paraMap);

	int deleteSchedule(String scheduleno);

	int editSchedule_end(Calendar_schedule_VO svo);

	List<ClubmemberVO> selectclubCategoryList(String fk_userid);

	List<Map<String, String>> getCBoardComment(String clubboardseq);

	String getCBoardCommentCount(String clubboardseq);

	int insertCBoardComment(Map<String, String> paramap);

	void updateCBoardCommentcount(String clubboardseq);

	int delCBoardComment(String clubboardcommentseq);

	void updateCBoardCommentcount_del(String clubboardseq);

	int editCBoardComment(Map<String, String> paramap);

	int deleteCBoard(String clubboardseq);

	int add_withFile2(Map<String, String> paramap);

	int add(Map<String, String> paraMap);

	List<Map<String, String>> getGymBarchart(String gymname);

	List<GymVO> getGymList();

	String getMostclubName(int i);

	Map<String, String> getMostclubNameSeq(int i);

	String getNewClubseq();

	List<Map<String,String>> getMyclubList(String fk_userid);

	void insertCalcname(ClubVO clubvo);

	ClubBoardVO editClubBoard(String clubseq);

	ClubBoardVO editCBoard_get(String clubboardseq);

	Map<String, String> getOrgfilename(String clubboardseq);

	



	

	
		
}
