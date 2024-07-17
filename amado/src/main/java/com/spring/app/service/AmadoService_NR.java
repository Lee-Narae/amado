package com.spring.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;


public interface AmadoService_NR {

	// 메인 페이지
	ModelAndView index(ModelAndView mav);

	// 로그인 처리
	ModelAndView loginEnd(Map<String, String> paramap, ModelAndView mav, HttpServletRequest request);

	// loginuser의 종목별 동호회 번호 얻어오기
	String getClubseq(Map<String, String> paramap);

	// 가입한 동호회 정보 불러오기
	Map<String, String> getClubInfo(String clubseq);

	// 운동 종목 불러오기
	List<Map<String, String>> getSportList();

	// 시군구 정보
	List<Map<String, String>> getCityList();

	// 상세지역 정보
	List<String> getLocalList(String cityname);

	// 매칭 정보 불러오기
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
	MemberVO adminLogin(Map<String, String> paramap);

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

	// 관리자 - 방문통계
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

	// 공지사항 조회수 올리기
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

	// 비번찾기
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
	


}
