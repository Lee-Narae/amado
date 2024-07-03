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

}
