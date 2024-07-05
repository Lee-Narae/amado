package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.MemberVO;

@Repository
public class AmadoDAO_imple_NR implements AmadoDAO_NR {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	// 로그인
	@Override
	public MemberVO getLoginMember(Map<String, String> paramap) {
		
		MemberVO loginuser = sqlsession.selectOne("NR.getLoginMember", paramap);
		
		return loginuser;
	}

	// 휴면 처리
	@Override
	public void updateIdle(String userid) {
		sqlsession.update("NR.updateIdle", userid);
	}

	// loginhistory insert
	@Override
	public void insert_tbl_loginhistory(Map<String, String> paramap) {
		sqlsession.insert("NR.insert_tbl_loginhistory", paramap);
	}

	// loginuser의 종목별 동호회 번호 얻어오기
	@Override
	public String getClubseq(Map<String, String> paramap) {

		String clubseq = sqlsession.selectOne("NR.getClubseq", paramap);
		
		return clubseq;
	}

	// 가입한 동호회 정보 불러오기
	@Override
	public Map<String, String> getClubInfo(String clubseq) {
		Map<String, String> club = sqlsession.selectOne("NR.getClubInfo", clubseq);
		return club;
	}

	// 시군구 정보
	@Override
	public List<Map<String, String>> getCityList() {
		List<Map<String, String>> cityList = sqlsession.selectList("NR.getCityList");
		return cityList;
	}

	// 상세지역 정보
	@Override
	public List<String> getLocalList(String cityname) {
		List<String> localList = sqlsession.selectList("NR.getLocalList", cityname);
		return localList;
	}

	// 운동 종목 불러오기
	@Override
	public List<Map<String, String>> getSportList() {
		List<Map<String,String>> sportList = sqlsession.selectList("NR.getSportList");
		return sportList;
	}

	// 조건에 따른 매칭정보 불러오기
	@Override
	public List<Map<String, String>> searchMatch(Map<String, String> paramap) {
		List<Map<String, String>> matchList = sqlsession.selectList("NR.searchMatch", paramap);
		return matchList;
	}

	
	// sportname + userid로 가입된 동호회 정보 불러오기
	@Override
	public Map<String, String> getClubseq_forMatch(Map<String, String> paramap) {
		Map<String, String> club = sqlsession.selectOne("NR.getClubseq_forMatch", paramap);
		return club;
	}

	// 매치 등록하기
	@Override
	public int matchRegister(Map<String, String> paramap) {
		int n = sqlsession.insert("NR.matchRegister", paramap);
		return n;
	}

	// 동호회 이름으로 동호회 시퀀스 불러오기
	@Override
	public String getClubseq_forReg(String clubname) {
		String clubseq = sqlsession.selectOne("NR.getClubseq_forReg", clubname);
		return clubseq;
	}

	// 종목 이름으로 종목 시퀀스 불러오기
	@Override
	public String getSportseq_forReg(String sportname) {
		String sportseq = sqlsession.selectOne("NR.getSportseq_forReg", sportname);
		return sportseq;
	}

	// 관리자 로그인
	@Override
	public MemberVO getAdmin(Map<String, String> paramap) {
		MemberVO admin = sqlsession.selectOne("NR.getAdmin", paramap);
		
		if(admin != null) {
			sqlsession.insert("NR.insert_tbl_loginhistory", paramap);
		}
		
		return admin;
	}
	
	// 관리자 - 전체 페이지 수 알아오기
	@Override
	public int getMemberTotalPage(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.getMemberTotalPage", paramap);
		return n;
	}

	// 관리자 - 회원 조회
	@Override
	public List<MemberVO> select_member_paging(Map<String, String> paramap) {
		List<MemberVO> memberList = sqlsession.selectList("NR.select_member_paging", paramap);
		return memberList;
	}

	// 관리자 - 전체 회원 수 조회
	@Override
	public int getTotalMemberCount(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.getTotalMemberCount", paramap);
		return n;
	}

	// 관리자 - 엑셀에서 회원 등록하기
	@Override
	public int addMemberList(List<Map<String, String>> paraMapList) {

		int insertCount = 0;
		
		for(Map<String, String> map : paraMapList) {
			int n = sqlsession.insert("NR.addMemberList", map);
			insertCount += n;
		}
		
		return insertCount;
	}

	// 관리자 - 회원 상세정보
	@Override
	public MemberVO getMemberDetail(String userid) {
		MemberVO member = sqlsession.selectOne("NR.getMemberDetail", userid);
		return member;
	}
	
	// 관리자 - 전체 동호회 개수
	@Override
	public int getClubCount() {
		int clubCount = sqlsession.selectOne("NR.getClubCount");
		return clubCount;
	}

	// 관리자 - 종목별 동호회 개수
	@Override
	public List<Map<String, String>> getSportPerClubCount() {
		List<Map<String, String>> clubCountList = sqlsession.selectList("NR.getSportPerClubCount");
		return clubCountList;
	}

	// 관리자 - 조건에 따른 멤버수
	@Override
	public int getMemberCount(int i) {
		int memberCount = sqlsession.selectOne("NR.getMemberCount", i);
		return memberCount;
	}

	// 관리자 - 방문 통계
	@Override
	public String getMemberStatic(String str_twoWeekBefore) {
		String memberCount = sqlsession.selectOne("NR.getMemberStatic", str_twoWeekBefore);
		return memberCount;
	}

}
