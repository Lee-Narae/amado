package com.spring.app.model;

import java.util.List;
import java.util.Map;

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
	
}
