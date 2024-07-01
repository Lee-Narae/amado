package com.spring.app.model;

import java.util.Map;

import com.spring.app.domain.ClubVO;
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

}
