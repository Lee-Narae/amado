package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.MemberVO;

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

}
