package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.ClubVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;

public interface AmadoDAO_NR {

	// 로그인 처리 중 
	MemberVO getLoginMember(Map<String, String> paramap);

	// 휴면 계정 처리
	void updateIdle(String userid);

	// loginhistory insert
	void insert_tbl_loginhistory(Map<String, String> paramap);

	// loginuser의 종목별 동호회 번호 얻어오기
	String getClubseq(Map<String, String> paramap);

	// 가입한 동호회 정보 불러오기
	Map<String, String> getClubInfo(String clubseq);

	// 시군구 정보
	List<Map<String, String>> getCityList();

	// 상세지역 정보
	List<String> getLocalList(String cityname);

	// 운동 종목 불러오기
	List<Map<String, String>> getSportList();

	// 조건에 따른 매칭정보 불러오기
	List<Map<String, String>> searchMatch(Map<String, String> paramap);

	// sportname + userid로 가입된 동호회 정보 불러오기
	Map<String, String> getClubseq_forMatch(Map<String, String> paramap);

	// 매치 등록하기
	int matchRegister(Map<String, String> paramap);

	// 동호회 이름으로 동호회 시퀀스 불러오기
	String getClubseq_forReg(String clubname);

	// 종목 이름으로 종목 시퀀스 불러오기
	String getSportseq_forReg(String sportname);

	// 관리자 로그인
	MemberVO getAdmin(Map<String, String> paramap);

	// 관리자 - 전체 페이지 수 알아오기
	int getMemberTotalPage(Map<String, String> paramap);

	// 관리자 - 회원 조회
	List<MemberVO> select_member_paging(Map<String, String> paramap);

	// 관리자 - 전체 회원 수 조회
	int getTotalMemberCount(Map<String, String> paramap);

	// 관리자 - 엑셀에서 회원 등록하기
	int addMemberList(List<Map<String, String>> paraMapList);

	// 관리자 - 회원 상세정보
	MemberVO getMemberDetail(String userid);

	// 관리자 - 전체 동호회 개수
	int getClubCount();

	// 관리자 - 종목별 동호회 개수
	List<Map<String, String>> getSportPerClubCount();

	// 관리자 - 조건에 따른 멤버수
	int getMemberCount(int i);

	// 관리자 - 방문 통계
	String getMemberStatic(String str_twoWeekBefore);

	// 관리자 - 파일첨부가 없는 경우 공지사항 등록
	int addNotice(NoticeVO nvo);

	// 관리자 - 파일첨부가 있는 경우 공지사항 등록
	int addNoticeWithFile(NoticeVO nvo);

	// 공지사항 목록 - 토탈페이지수
	int getNoticeTotalPage(Map<String, String> paramap);

	// 공지사항 목록 - 페이징처리
	List<NoticeVO> select_notice_paging(Map<String, String> paramap);

	// 공지사항 목록 - 공지사항 개수
	int getTotalNoticeCount(Map<String, String> paramap);

	// 공지사항 - 상세 글 보기
	NoticeVO getNoticeDetail(Map<String, String> paramap);

	// 공지사항 댓글 불러오기
	List<Map<String, String>> getNoticeComment(String noticeseq);

	// 공지사항 댓글 개수
	String getNoticeCommentCount(String noticeseq);

	// 공지사항 - 첨부파일 다운받기
	Map<String, String> getOrgfilename(String noticeseq);

	// 공지사항 - 글 지우기
	int deleteNotice(String noticeseq);

	// 공지사항 - 수정하기 위해서 글 가져오기
	NoticeVO editNotice_get(String noticeseq);

	// 공지사항 수정하기
	int editNoticeBy1(NoticeVO nvo);
	int editNoticeBy2(NoticeVO nvo);
	int editNoticeBy3(NoticeVO nvo);

	// 공지사항 조회수
	void updateNoticeViewcount(String noticeseq);

	// 댓글 작성하기
	int insertNoticeComment(Map<String, String> paramap);
	void updateNoticeCommentcount(String parentseq);

	// 댓글 삭제
	int delNoticeComment(String noticecommentseq);
	void updateNoticeCommentcount_del(String parentseq);

	// 댓글 수정
	int editNoticeComment(Map<String, String> paramap);

	// sportseq 얻어오기
	String getSportseq(String matchingregseq);
	Map<String, String> getUserClubname(Map<String, String> paramap);

	// 매치 요청하기
	int applyMatch(Map<String, String> paramap);

	// loginuser가 특정 매치에 신청했는지 안했는지 알아보는 것
	int searchApply(Map<String, String> paramap2);

	// id찾기 - 이름과 이메일에 유효한 정보가 있는지
	MemberVO findId(Map<String, String> paramap);

	MemberVO findpw(Map<String, String> paramap);

	// 이전 비밀번호와 동일한지 확인
	int checkBeforePw(Map<String, String> paramap);

	// 이전과 일치하지 않는 ㄱㅊ은 비번일 때 비번 업데이트
	int findPwUpdatePw(Map<String, String> paramap);

	// 관리자 - 아직 등록 승인 안 된 체육관 불러오기
	List<GymVO> getGymStatus();

	// gymVO 한 개 가져오기
	GymVO getGymInfo(String gymseq);

	// 체육관 승인하기
	int gymPermit(String gymseq);

	// 동호회장 한정 알림 불러오기
	List<Map<String, String>> getClubAlarm(String userid);

	// 선택된 동호회의 tbl_matchingapplyseq 행 status는 1로, 선택받지 못한 동호회는 2로, tbl_matchingreg의  matchingregseq 행 status는 1로
	// 1. tbl_matchingapply
	int updateMatchingApply(Map<String, String> paramap);
	// 2. tbl_matchingreg
	int updateMatchingReg(String matchingregseq);
	// 3. tbl_matching
	int insertMatching(Map<String, String> paramap);

	// 우리팀 매치일정 불러오기
	List<Map<String, String>> getMatchList(String clubseq);

	// gymseq 채번
	String getGymseq();

	// 관리자 - 체육관 등록하기(대표이미지)
	int adminGymreg(GymVO gym);
	// 관리자 - 체육관 등록하기(추가이미지)
	int insertGymImg(Map<String, String> paramap);

	// opendata db insert
	int insertOpendata(Map<String, String> paramap);

	// 지역별 체육시설 현황
	List<Map<String, String>> searchFacByCity();
	List<Map<String, String>> searchFacByLocal(String city);

	// 전국 체육시설
	List<Map<String, String>> getFacList(Map<String, String> paramap);
	int getfacTotalPage(Map<String, String> paramap);
	int getTotalFacCount(Map<String, String> paramap);

	// 동호회장 - 매치결과 등록알림
	List<Map<String, String>> getMatchResult(String userid);
	// 동호회장 - 매치 결과 등록
	int updateMatchResult(Map<String, String> paramap);

	// 회원정보 수정
	int updateMemberInfo_noAttach(MemberVO editMember);
	int updateMemberInfo_attach(MemberVO editMember);

	// 비밀번호 변경
	int checkPw(Map<String, String> paramap);
	int changePw(Map<String, String> paramap);

	// 회원탈퇴
	int memberQuit(String userid);

	// 마이페이지 - 가입 동호회 조회
	Map<String, String> getSoccer(String userid);
	Map<String, String> getBaseball(String userid);
	Map<String, String> getVolley(String userid);
	Map<String, String> getBasket(String userid);
	Map<String, String> getTennis(String userid);
	Map<String, String> getBowling(String userid);
	Map<String, String> getJokgu(String userid);
	Map<String, String> getMinton(String userid);

	// 마이페이지 - 동호회 탈퇴
	int checkClubMaster(Map<String, String> paramap); // 탈퇴 전 동호회장인지 알아보기
	int quitClub(Map<String, String> paramap);
	// 마이페이지 - 내동호회 관리
	List<ClubVO> getMyClub(String userid);
	// 마이페이지 - 내 동호회 수정
	int updateClubInfo(ClubVO club);
	// 마이페이지 - 내 동호회 삭제
	int deleteClub(String clubseq);
	void deleteClubMember(String clubseq);
	// 마이페이지 - 내 동호회 회원 관리
	List<Map<String, String>> getClubMember(Map<String, String> paramap);
	int getClubMemberTotalPage(Map<String, String> paramap);
	int getTotalClubMemberCount(Map<String, String> paramap);
	int quitClubMember(Map<String, String> paramap);

	// My 동호회 - 동호회 최신 글 불러오기
	List<Map<String, String>> getClubboard(String clubseq);

	// 공지사항 - 검색어 자동완성
	List<String> wordSearch(Map<String, String> paramap);

	// 동호회 가입 승인 알림 불러오기
	List<Map<String, String>> getClubJoinList(String userid);

	// 동호회장  - 동호회 가입 승인/거절하기
	int permitJoinClub(Map<String, String> paramap);
	int refuseJoinClub(Map<String, String> paramap);

	// 동호회장 - 매치결과 등록 성공 시 점수 배분
	Map<String, String> getMatchClubseq(String matchingseq);
	int addClubPoint(Map<String, String> clubseqMap);

	// 동호회 가입 승인시 일정 테이블에 등록
	String getClubname(String clubseq);
	int insertCalcat(Map<String, String> paramap);

	
}
