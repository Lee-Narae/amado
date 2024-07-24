package com.spring.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.ClubVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;

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

	// 관리자 - 파일첨부가 없는 경우 공지사항 등록
	@Override
	public int addNotice(NoticeVO nvo) {
		int n = sqlsession.insert("NR.addNotice", nvo);
		return n;
	}
	
	// 관리자 - 파일첨부가 있는 경우 공지사항 등록
	@Override
	public int addNoticeWithFile(NoticeVO nvo) {
		int n = sqlsession.insert("NR.addNoticeWithFile", nvo);
		return n;
	}

	// 공지사항 목록 - 토탈페이지수
	@Override
	public int getNoticeTotalPage(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.getNoticeTotalPage", paramap);
		return n;
	}

	// 공지사항 목록 - 페이징처리
	@Override
	public List<NoticeVO> select_notice_paging(Map<String, String> paramap) {
		List<NoticeVO> noticeList = sqlsession.selectList("NR.select_notice_paging", paramap);
		return noticeList;
	}

	// 공지사항 목록 - 공지사항 개수
	@Override
	public int getTotalNoticeCount(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.getTotalNoticeCount", paramap);
		return n;
	}

	// 공지사항 - 상세 글 보기
	@Override
	public NoticeVO getNoticeDetail(Map<String, String> paramap) {
		NoticeVO notice = sqlsession.selectOne("NR.getNoticeDetail", paramap);
		return notice;
	}

	// 공지사항 댓글 불러오기
	@Override
	public List<Map<String, String>> getNoticeComment(String noticeseq) {
		List<Map<String, String>> commentList = sqlsession.selectList("NR.getNoticeComment", noticeseq);
		return commentList;
	}

	// 공지사항 댓글 개수
	@Override
	public String getNoticeCommentCount(String noticeseq) {
		String commentCount = sqlsession.selectOne("NR.getNoticeCommentCount", noticeseq);
		return commentCount;
	}

	// 공지사항 - 첨부파일 다운받기
	@Override
	public Map<String, String> getOrgfilename(String noticeseq) {
		Map<String, String> filenameMap = sqlsession.selectOne("NR.getOrgfilename", noticeseq);
		return filenameMap;
	}

	// 공지사항 - 글 지우기
	@Override
	public int deleteNotice(String noticeseq) {
		int n = sqlsession.delete("NR.deleteNotice", noticeseq);
		return n;
	}

	// 공지사항 - 수정하기 위해서 글 가져오기
	@Override
	public NoticeVO editNotice_get(String noticeseq) {
		NoticeVO editNotice = sqlsession.selectOne("NR.editNotice_get", noticeseq);
		return editNotice;
	}

	// 공지사항 수정하기(1)
	@Override
	public int editNoticeBy1(NoticeVO nvo) {
		int n = sqlsession.update("NR.editNoticeBy1", nvo);
		return n;
	}

	// 공지사항 수정하기(2)
	@Override
	public int editNoticeBy2(NoticeVO nvo) {
		int n = sqlsession.update("NR.editNoticeBy2", nvo);
		return n;
	}

	// 공지사항 수정하기(3)
	@Override
	public int editNoticeBy3(NoticeVO nvo) {
		int n = sqlsession.update("NR.editNoticeBy3", nvo);
		return n;
	}

	// 공지사항 조회수
	@Override
	public void updateNoticeViewcount(String noticeseq) {
		sqlsession.update("NR.updateNoticeViewcount", noticeseq);
	}

	// 댓글 작성하기
	@Override
	public int insertNoticeComment(Map<String, String> paramap) {
		int n = sqlsession.insert("NR.insertNoticeComment", paramap);
		return n;
	}
	@Override
	public void updateNoticeCommentcount(String parentseq) {
		sqlsession.update("NR.updateNoticeCommentcount", parentseq);
	}

	// 댓글 삭제
	@Override
	public int delNoticeComment(String noticecommentseq) {
		int n = sqlsession.delete("NR.delNoticeComment", noticecommentseq);
		return n;
	}
	@Override
	public void updateNoticeCommentcount_del(String parentseq) {
		sqlsession.update("NR.updateNoticeCommentcount_del", parentseq);
	}

	// 댓글 수정
	@Override
	public int editNoticeComment(Map<String, String> paramap) {
		int n = sqlsession.update("NR.editNoticeComment", paramap);
		
		return n;
	}

	// sportseq 얻어오기
	@Override
	public String getSportseq(String matchingregseq) {
		String sportseq = sqlsession.selectOne("NR.getSportseq", matchingregseq);
		return sportseq;
	}
	@Override
	public Map<String, String> getUserClubname(Map<String, String> paramap) {
		Map<String, String> resultmap = sqlsession.selectOne("NR.getUserClubname", paramap);
		return resultmap;
	}

	// 매치 요청하기
	@Override
	public int applyMatch(Map<String, String> paramap) {
		int n = sqlsession.insert("NR.applyMatch", paramap);
		return n;
	}

	// loginuser가 특정 매치에 신청했는지 안했는지 알아보는 것
	@Override
	public int searchApply(Map<String, String> paramap2) {
		int n = sqlsession.selectOne("NR.searchApply", paramap2);
		return n;
	}

	// id찾기 - 이름과 이메일에 유효한 정보가 있는지
	@Override
	public MemberVO findId(Map<String, String> paramap) {
		MemberVO member = sqlsession.selectOne("NR.findId", paramap);
		return member;
	}

	// 비번 찾기
	@Override
	public MemberVO findpw(Map<String, String> paramap) {
		MemberVO member = sqlsession.selectOne("NR.findpw", paramap);
		return member;
	}

	// 이전 비밀번호와 동일한지 확인
	@Override
	public int checkBeforePw(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.checkBeforePw", paramap);
		return n;
	}

	// 이전과 일치하지 않는 ㄱㅊ은 비번일 때 비번 업데이트
	@Override
	public int findPwUpdatePw(Map<String, String> paramap) {
		int n = sqlsession.update("NR.findPwUpdatePw", paramap);
		return n;
	}

	// 관리자 - 아직 등록 승인 안 된 체육관 불러오기
	@Override
	public List<GymVO> getGymStatus() {
		List<GymVO> gymList = sqlsession.selectList("NR.getGymStatus");
		return gymList;
	}

	// gymVO 한 개 가져오기
	@Override
	public GymVO getGymInfo(String gymseq) {
		GymVO gym = sqlsession.selectOne("NR.getGymInfo", gymseq);
		return gym;
	}

	// 체육관 승인하기
	@Override
	public int gymPermit(String gymseq) {
		int n = sqlsession.update("NR.gymPermit", gymseq);
		return n;
	}

	// 동호회장 한정 알림 불러오기
	@Override
	public List<Map<String, String>> getClubAlarm(String userid) {
		List<Map<String, String>> alarmList = sqlsession.selectList("NR.getClubAlarm", userid);
		return alarmList;
	}

	// 선택된 동호회의 tbl_matchingapplyseq 행 status는 1로, 선택받지 못한 동호회는 2로, tbl_matchingreg의  matchingregseq 행 status는 1로
	// 1. tbl_matchingapplyseq
	@Override
	public int updateMatchingApply(Map<String, String> paramap) {
		int n = sqlsession.update("NR.updateMatchingApply1", paramap);
		
		if(n == 1) {
			sqlsession.update("NR.updateMatchingApply2", paramap);
		}
		return n;
	}
	// 2. tbl_matchingreg
	@Override
	public int updateMatchingReg(String matchingregseq) {
		int n = sqlsession.update("NR.updateMatchingReg", matchingregseq);
		return n;
	}
	// 3. tbl_matching
	@Override
	public int insertMatching(Map<String, String> paramap) {
		int n = sqlsession.insert("NR.insertMatching", paramap);
		return n;
	}

	// 우리팀 매치일정 불러오기
	@Override
	public List<Map<String, String>> getMatchList(String clubseq) {
		List<Map<String, String>> matchList = sqlsession.selectList("NR.getMatchList", clubseq);
		return matchList;
	}
	
	// gymseq 채번
	@Override
	public String getGymseq() {
		String gymseq = sqlsession.selectOne("NR.getGymseq");
		return gymseq;
	}

	// 관리자 - 체육관 등록하기(대표이미지)
	@Override
	public int adminGymreg(GymVO gym) {
		int n = sqlsession.insert("NR.adminGymreg", gym);
		return n;
	}
	// 관리자 - 체육관 등록하기(추가이미지)
	@Override
	public int insertGymImg(Map<String, String> paramap) {
		int n = sqlsession.insert("NR.insertGymImg", paramap);
		return n;
	}

	// opendata db insert
	@Override
	public int insertOpendata(Map<String, String> paramap) {
		int n = sqlsession.insert("NR.insertOpendata", paramap);
		return n;
	}

	// 지역별 체육시설 현황
	@Override
	public List<Map<String, String>> searchFacByCity() {
		List<Map<String, String>> cityFacList = sqlsession.selectList("NR.searchFacByCity");
		return cityFacList;
	}
	@Override
	public List<Map<String, String>> searchFacByLocal(String city) {
		List<Map<String, String>> localFacList = sqlsession.selectList("NR.searchFacByLocal", city);
		return localFacList;
	}
	
	// 전국 체육시설
	@Override
	public List<Map<String, String>> getFacList(Map<String, String> paramap) {
		List<Map<String, String>> facList = sqlsession.selectList("NR.getFacList", paramap);
		return facList;
	}
	@Override
	public int getfacTotalPage(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.getfacTotalPage", paramap);
		return n;
	}
	@Override
	public int getTotalFacCount(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.getTotalFacCount", paramap);
		return n;
	}

	// 동호회장 - 매치결과 등록알림
	@Override
	public List<Map<String, String>> getMatchResult(String userid) {
		List<Map<String, String>> matchResultList = sqlsession.selectList("NR.getMatchResult", userid);
		return matchResultList;
	}
	// 동호회장 - 매치 결과 등록
	@Override
	public int updateMatchResult(Map<String, String> paramap) {
		int n = sqlsession.update("NR.updateMatchResult", paramap);
		return n;
	}

	// 회원정보 수정
	@Override
	public int updateMemberInfo_noAttach(MemberVO editMember) {
		int n = sqlsession.update("NR.updateMemberInfo_noAttach", editMember);
		return n;
	}
	@Override
	public int updateMemberInfo_attach(MemberVO editMember) {
		int n = sqlsession.update("NR.updateMemberInfo_attach", editMember);
		return n;
	}

	// 비밀번호 변경
	@Override
	public int checkPw(Map<String, String> paramap) {
		int n = sqlsession.selectOne("NR.checkPw", paramap);
		return n;
	}
	@Override
	public int changePw(Map<String, String> paramap) {
		int n = sqlsession.update("NR.changePw", paramap);
		return n;
	}

	// 회원탈퇴
	@Override
	public int memberQuit(String userid) {
		int n = sqlsession.update("NR.memberQuit", userid);
		return n;
	}

	// 마이페이지 - 가입 동호회 조회
	@Override
	public Map<String, String> getSoccer(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "1");
		Map<String, String> soccer = sqlsession.selectOne("NR.getClubMap", paramap);
		return soccer;
	}
	@Override
	public Map<String, String> getBaseball(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "2");
		Map<String, String> baseball = sqlsession.selectOne("NR.getClubMap", paramap);
		return baseball;
	}
	@Override
	public Map<String, String> getVolley(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "3");
		Map<String, String> volley = sqlsession.selectOne("NR.getClubMap", paramap);
		return volley;
	}
	@Override
	public Map<String, String> getBasket(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "4");
		Map<String, String> basket = sqlsession.selectOne("NR.getClubMap", paramap);
		return basket;
	}
	@Override
	public Map<String, String> getTennis(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "6");
		Map<String, String> tennis = sqlsession.selectOne("NR.getClubMap", paramap);
		return tennis;
	}
	@Override
	public Map<String, String> getBowling(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "7");
		Map<String, String> bowling = sqlsession.selectOne("NR.getClubMap", paramap);
		return bowling;
	}
	@Override
	public Map<String, String> getJokgu(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "5");
		Map<String, String> jokgu = sqlsession.selectOne("NR.getClubMap", paramap);
		return jokgu;
	}
	@Override
	public Map<String, String> getMinton(String userid) {
		Map<String, String> paramap = new HashMap<String, String>();
		paramap.put("userid", userid);
		paramap.put("sportseq", "8");
		Map<String, String> minton = sqlsession.selectOne("NR.getClubMap", paramap);
		return minton;
	}

	// 마이페이지 - 동호회 탈퇴
	@Override
	public int quitClub(Map<String, String> paramap) {
		int n = sqlsession.delete("NR.quitClub", paramap);
		return n;
	}

	// 마이페이지 - 내동호회 관리
	@Override
	public List<ClubVO> getMyClub(String userid) {
		List<ClubVO> clubList = sqlsession.selectList("NR.getMyClub", userid);
		return clubList;
	}

}
