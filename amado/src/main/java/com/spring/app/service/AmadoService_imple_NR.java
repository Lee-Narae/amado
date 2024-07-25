package com.spring.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.GymVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;
import com.spring.app.model.AmadoDAO_NR;

@Service
public class AmadoService_imple_NR implements AmadoService_NR {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AmadoDAO_NR dao;
	// 원래대로라면 field 명은 bean에 올라간 대로 boardDAO_imple로 해야 하지만 어차피 BoardDAO에서 bean에 올린 것이 한 개밖에 없으므로 이름을 마음대로 해도 괜찮다.
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
    @Autowired
    private AES256 aES256;
    // Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aES256 에 주입시켜준다. 
    // 그러므로 aES256 는 null 이 아니다.
   // com.spring.app.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
	
	
	@Override
	public ModelAndView index(ModelAndView mav) {
		
		mav.setViewName("main/index.tiles2");
		// /WEB-INF/views/tiles2/main/index.jsp
		return mav;
	}


	// 로그인 처리
	@Override
	public ModelAndView loginEnd(Map<String, String> paramap, ModelAndView mav, HttpServletRequest request) {
		
		MemberVO loginuser = dao.getLoginMember(paramap);
		
		if(loginuser != null && loginuser.getPwdchangegap() >= 3) {
			// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 
			loginuser.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 한다.
		}
		
		if(loginuser != null && loginuser.getLastlogingap() >= 12 && loginuser.getIdle() == 0) {
			// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정
			loginuser.setIdle(1);
			
			// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === // 
			dao.updateIdle(paramap.get("userid"));
		}
		
		if(loginuser != null && loginuser.getIdle() == 0) {
			try {
				String email = aES256.decrypt(loginuser.getEmail());
				String mobile = aES256.decrypt(loginuser.getMobile()); 
				
				loginuser.setEmail(email);
				loginuser.setMobile(mobile);
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			dao.insert_tbl_loginhistory(paramap);
		}
		
		if(loginuser == null) { // 로그인 실패시
			String message = "아이디 또는 비밀번호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			//  /WEB-INF/views/msg.jsp 파일을 생성한다.
		}
		else { // 아이디와 암호가 존재하는 경우 
			
			if(loginuser.getIdle() == 1) { // 로그인 한지 1년이 경과한 경우
				
				String message = "로그인한지 1년이 경과되어 휴면 처리 되었습니다.\n관리자에 문의하세요.";
				String loc = request.getContextPath()+"/index.do";
				// 원래는 위와 같이 index.action 이 아니라 휴면의 계정을 풀어주는 페이지로 잡아주어야 한다. 
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
			else{ // 로그인 한지 1년 이내인  경우
			   
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러온다.
				
				session.setAttribute("loginuser", loginuser); 
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다. 
				
				if(Integer.parseInt(loginuser.getMemberrank()) == 2) {
					session.setAttribute("admin", loginuser);
				}
				
				if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
					
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\n비밀번호를 변경하세요.";
					String loc = request.getContextPath()+"/index.do";
					// 원래는 위와 같이 index.action 이 아니라 사용자의 비밀번호를 변경해주는 페이지로 잡아주어야 한다.
					
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					
					mav.setViewName("msg");
					
				}
				else { // 암호를 마지막으로 변경한 것이 3개월 이내인 경우
					
					String goBackURL = (String)session.getAttribute("goBackURL");
					
					if(goBackURL != null) {
						mav.setViewName("redirect:"+goBackURL); // 시작 페이지로 이동
						session.removeAttribute("goBackURL");
					}
					
					else {
						mav.setViewName("redirect:/index.do");
					}

				}
			}
		}
		
		return mav;
	}

	// loginuser의 종목별 동호회 번호 얻어오기
	@Override
	public String getClubseq(Map<String, String> paramap) {

		String clubseq = dao.getClubseq(paramap);
		
		return clubseq;
	}

	// 가입한 동호회 정보 불러오기
	@Override
	public Map<String, String> getClubInfo(String clubseq) {
		
		Map<String, String> club = dao.getClubInfo(clubseq);
		
		return club;
	}

	// 시군구 정보
	@Override
	public List<Map<String, String>> getCityList() {
		List<Map<String, String>> cityList = dao.getCityList();
		return cityList;
	}

	// 상세지역 정보
	@Override
	public List<String> getLocalList(String cityname) {
		List<String> localList = dao.getLocalList(cityname);
		return localList;
	}

	// 운동 종목 불러오기
	@Override
	public List<Map<String, String>> getSportList() {
		List<Map<String, String>> sportList = dao.getSportList();
		return sportList;
	}

	// 조건에 따른 매칭정보 불러오기
	@Override
	public List<Map<String, String>> searchMatch(Map<String, String> paramap) {
		List<Map<String, String>> matchList = dao.searchMatch(paramap);
		return matchList;
	}

	// sportname + userid로 가입된 동호회 정보 불러오기
	@Override
	public Map<String, String> getClubseq_forMatch(Map<String, String> paramap) {
		Map<String, String> club = dao.getClubseq_forMatch(paramap);
		return club; 
	}

	// 매치 등록하기
	@Override
	public int matchRegister(Map<String, String> paramap) {
		int n = dao.matchRegister(paramap);
		return n;
	}

	// 동호회 이름으로 동호회 시퀀스 불러오기
	@Override
	public String getClubseq_forReg(String clubname) {
		String clubseq = dao.getClubseq_forReg(clubname);
		return clubseq;
	}

	// 종목 이름으로 종목 시퀀스 불러오기
	@Override
	public String getSportseq_forReg(String sportname) {
		String sportseq = dao.getSportseq_forReg(sportname);
		return sportseq;
	}

	// 관리자 로그인
	@Override
	public MemberVO adminLogin(Map<String, String> paramap) {

		MemberVO admin = dao.getAdmin(paramap);
		
		return admin;
	}

	// 관리자 - 전체 페이지 수 알아오기
	@Override
	public int getMemberTotalPage(Map<String, String> paramap) {
		
		try {
			if("email".equals(paramap.get("searchType"))) {
				paramap.put("searchWord", aES256.encrypt(paramap.get("searchWord")));
			}
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		int n = dao.getMemberTotalPage(paramap);
		return n;
	}

	// 관리자 - 회원 조회
	@Override
	public List<MemberVO> select_member_paging(Map<String, String> paramap) {
		List<MemberVO> memberList = dao.select_member_paging(paramap);
		
		for(MemberVO member:memberList) {
			try {
			member.setEmail(aES256.decrypt(member.getEmail()));
			}catch(UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
		}
		
		return memberList;
	}

	// 관리자 - 전체 회원 수 조회
	@Override
	public int getTotalMemberCount(Map<String, String> paramap) {
		int n = dao.getTotalMemberCount(paramap);
		return n;
	}

	// 관리자 - 엑셀에서 회원 등록하기
	@Override
	public int addMemberList(List<Map<String, String>> paraMapList) {
		int n = dao.addMemberList(paraMapList);
		return n;
	}

	// 관리자 - 회원 상세정보
	@Override
	public MemberVO getMemberDetail(String userid) {
		MemberVO member = dao.getMemberDetail(userid);
		return member;
	}

	// 관리자 - 전체 동호회 개수
	@Override
	public int getClubCount() {
		int clubCount = dao.getClubCount();
		return clubCount;
	}

	// 관리자 - 종목별 동호회 개수
	@Override
	public List<Map<String, String>> getSportPerClubCount() {
		List<Map<String, String>> clubCountList = dao.getSportPerClubCount();
		return clubCountList;
	}

	// 조건에 따른 멤버 수 알아오기
	@Override
	public int getMemberCount(int i) {
		int memberCount = dao.getMemberCount(i);
		return memberCount;
	}

	// 관리자 - 방문 통계
	@Override
	public String getMemberStatic(String str_twoWeekBefore) {
		String memberCount = dao.getMemberStatic(str_twoWeekBefore);
		return memberCount;
	}

	// 관리자 - 파일첨부가 없는 경우 공지사항 등록
	@Override
	public int addNotice(NoticeVO nvo) {
		int n = dao.addNotice(nvo);
		return n;
	}

	// 관리자 - 파일첨부가 있는 경우 공지사항 등록
	@Override
	public int addNoticeWithFile(NoticeVO nvo) {
		int n = dao.addNoticeWithFile(nvo);
		return n;
	}

	// 공지사항 목록 - 토탈페이지수
	@Override
	public int getNoticeTotalPage(Map<String, String> paramap) {
		int n = dao.getNoticeTotalPage(paramap);
		return n;
		}

	// 공지사항 목록 - 페이징처리
	@Override
	public List<NoticeVO> select_notice_paging(Map<String, String> paramap) {
		List<NoticeVO> noticeList = dao.select_notice_paging(paramap);
		return noticeList;
	}

	// 공지사항 목록 - 공지사항 개수
	@Override
	public int getTotalNoticeCount(Map<String, String> paramap) {
		int n = dao.getTotalNoticeCount(paramap);
		return n;
	}

	// 공지사항 - 상세 글 보기
	@Override
	public NoticeVO getNoticeDetail(Map<String, String> paramap) {
		NoticeVO notice = dao.getNoticeDetail(paramap);
		return notice;
	}

	// 공지사항 댓글 불러오기
	@Override
	public List<Map<String, String>> getNoticeComment(String noticeseq) {
		List<Map<String, String>> commentList = dao.getNoticeComment(noticeseq);
		return commentList;
	}

	// 공지사항 댓글 개수
	@Override
	public String getNoticeCommentCount(String noticeseq) {
		String commentCount = dao.getNoticeCommentCount(noticeseq);
		return commentCount;
	}

	// 공지사항 - 첨부파일 다운받기
	@Override
	public Map<String, String> getOrgfilename(String noticeseq) {
		Map<String, String> filenameMap = dao.getOrgfilename(noticeseq);
		return filenameMap;
	}

	// 공지사항 - 글 지우기
	@Override
	public int deleteNotice(String noticeseq) {
		int n = dao.deleteNotice(noticeseq);
		return n;
	}

	// 공지사항 - 수정하기 위해서 글 가져오기
	@Override
	public NoticeVO editNotice_get(String noticeseq) {
		NoticeVO editNotice = dao.editNotice_get(noticeseq);
		return editNotice;
	}

	// 공지사항 수정하기(1)
	@Override
	public int editNoticeBy1(NoticeVO nvo) {
		int n = dao.editNoticeBy1(nvo);
		return n;
	}

	// 공지사항 수정하기(2)
	@Override
	public int editNoticeBy2(NoticeVO nvo) {
		int n = dao.editNoticeBy2(nvo);
		return n;
	}

	// 공지사항 수정하기(3)
	@Override
	public int editNoticeBy3(NoticeVO nvo) {
		int n = dao.editNoticeBy3(nvo);
		return n;
	}

	// 공지사항 조회수 올리기
	@Override
	public void updateNoticeViewcount(String noticeseq) {
		dao.updateNoticeViewcount(noticeseq);
	}

	// 댓글 작성하기
	@Override
	public int insertNoticeComment(Map<String, String> paramap) {
		int n = dao.insertNoticeComment(paramap);
		return n;
	}
	@Override
	public void updateNoticeCommentcount(String parentseq) {
		dao.updateNoticeCommentcount(parentseq);
	}

	// 댓글 삭제
	@Override
	public int delNoticeComment(String noticecommentseq) {
		int n = dao.delNoticeComment(noticecommentseq);
		return n;
	}
	@Override
	public void updateNoticeCommentcount_del(String parentseq) {
		dao.updateNoticeCommentcount_del(parentseq);		
	}

	// 댓글 수정
	@Override
	public int editNoticeComment(Map<String, String> paramap) {
		int n = dao.editNoticeComment(paramap);
		
		return n;
	}

	// sportseq 얻어오기
	@Override
	public String getSportseq(String matchingregseq) {
		String sportseq = dao.getSportseq(matchingregseq);
		return sportseq;
	}
	@Override
	public Map<String, String> getUserClubname(Map<String, String> paramap) {
		Map<String, String> resultmap = dao.getUserClubname(paramap);
		return resultmap;
	}

	// 매치 요청하기
	@Override
	public int applyMatch(Map<String, String> paramap) {
		int n = dao.applyMatch(paramap);
		return n;
	}

	// loginuser가 특정 매치에 신청했는지 안했는지 알아보는 것
	@Override
	public int searchApply(Map<String, String> paramap2) {
		int n = dao.searchApply(paramap2);
		return n;
	}

	// id찾기 - 이름과 이메일에 유효한 정보가 있는지
	@Override
	public MemberVO findId(Map<String, String> paramap) {
		MemberVO member = dao.findId(paramap);
		return member;
	}

	// 비번 찾기
	@Override
	public MemberVO findpw(Map<String, String> paramap) {
		MemberVO member = dao.findpw(paramap);
		return member;
	}

	// 이전 비밀번호와 동일한지 확인
	@Override
	public int checkBeforePw(Map<String, String> paramap) {
		int n = dao.checkBeforePw(paramap);
		return n;
	}

	// 이전과 일치하지 않는 ㄱㅊ은 비번일 때 비번 업데이트
	@Override
	public int findPwUpdatePw(Map<String, String> paramap) {
		int n = dao.findPwUpdatePw(paramap);
		return n;
	}

	// 관리자 - 아직 등록 승인 안 된 체육관 불러오기
	@Override
	public List<GymVO> getGymStatus() {
		List<GymVO> gymList = dao.getGymStatus();
		return gymList;
	}

	// gymVO 한 개 가져오기
	@Override
	public GymVO getGymInfo(String gymseq) {
		GymVO gym = dao.getGymInfo(gymseq);
		return gym;
	}

	// 체육관 승인하기
	@Override
	public int gymPermit(String gymseq) {
		int n = dao.gymPermit(gymseq);
		return n;
	}

	// 동호회장 한정 알림 불러오기
	@Override
	public List<Map<String, String>> getClubAlarm(String userid) {
		List<Map<String, String>> alarmList = dao.getClubAlarm(userid);
		return alarmList;
	}

	// 선택된 동호회의 tbl_matchingapplyseq 행 status는 1로, 선택받지 못한 동호회는 2로, tbl_matchingreg의  matchingregseq 행 status는 1로
	// 1. tbl_matchingapply
	@Override
	public int updateMatchingApply(Map<String, String> paramap) {
		int n = dao.updateMatchingApply(paramap);
		return n;
	}

	// 2. tbl_matchingreg
	@Override
	public int updateMatchingReg(String matchingregseq) {
		int n = dao.updateMatchingReg(matchingregseq);
		return n;
	}

	// 3. tbl_matching
	@Override
	public int insertMatching(Map<String, String> paramap) {
		int n = dao.insertMatching(paramap);
		return n;
	}

	// 우리팀 매치일정 불러오기
	@Override
	public List<Map<String, String>> getMatchList(String clubseq) {
		List<Map<String, String>> matchList = dao.getMatchList(clubseq);
		return matchList;
	}
	
	// gymseq 채번
	@Override
	public String getGymseq() {
		String gymseq = dao.getGymseq();
		return gymseq;
	}

	// 관리자 - 체육관 등록하기(대표이미지)
	@Override
	public int adminGymreg(GymVO gym) {
		int n = dao.adminGymreg(gym);
		return n;
	}

	// 관리자 - 체육관 등록하기(추가이미지)
	@Override
	public int insertGymImg(Map<String, String> paramap) {
		int n = dao.insertGymImg(paramap);
		return n;
	}

	// opendata db insert
	@Override
	public int insertOpendata(Map<String, String> paramap) {
		int n = dao.insertOpendata(paramap);
		return n;
	}

	// 지역별 체육시설 현황
	@Override
	public List<Map<String, String>> searchFacByCity() {
		List<Map<String, String>> cityFacList = dao.searchFacByCity();
		return cityFacList;
	}
	@Override
	public List<Map<String, String>> searchFacByLocal(String city) {
		List<Map<String, String>> localFacList = dao.searchFacByLocal(city);
		return localFacList;
	}

	// 전국 체육시설
	@Override
	public List<Map<String, String>> getFacList(Map<String, String> paramap) {
		List<Map<String, String>> facList = dao.getFacList(paramap);
		return facList;
	}
	@Override
	public int getfacTotalPage(Map<String, String> paramap) {
		int n = dao.getfacTotalPage(paramap);
		return n;
	}
	@Override
	public int getTotalFacCount(Map<String, String> paramap) {
		int n = dao.getTotalFacCount(paramap);
		return n;
	}

	// 동호회장 - 매치결과 등록알림
	@Override
	public List<Map<String, String>> getMatchResult(String userid) {
		List<Map<String, String>> matchResultList = dao.getMatchResult(userid);
		return matchResultList;
	}

	// 동호회장 - 매치 결과 등록
	@Override
	public int updateMatchResult(Map<String, String> paramap) {
		int n = dao.updateMatchResult(paramap);
		return n;
	}

	// 회원정보 수정
	@Override
	public int updateMemberInfo_noAttach(MemberVO editMember) {
		int n = dao.updateMemberInfo_noAttach(editMember);
		return n;
	}
	@Override
	public int updateMemberInfo_attach(MemberVO editMember) {
		int n = dao.updateMemberInfo_attach(editMember);
		return n;
	}

	// 비밀번호 변경
	@Override
	public int checkPw(Map<String, String> paramap) {
		int n = dao.checkPw(paramap);
		return n;
	}
	@Override
	public int changePw(Map<String, String> paramap) {
		int n = dao.changePw(paramap);
		return n;
	}

	// 회원탈퇴
	@Override
	public int memberQuit(String userid) {
		int n = dao.memberQuit(userid);
		return n;
	}


	// 마이페이지 - 가입 동호회 조회
	@Override
	public Map<String, String> getSoccer(String userid) { Map<String, String> soccer = dao.getSoccer(userid); return soccer; } 
	@Override
	public Map<String, String> getBaseball(String userid) { Map<String, String> baseball = dao.getBaseball(userid); return baseball; }
	@Override
	public Map<String, String> getVolley(String userid) { Map<String, String> volley = dao.getVolley(userid); return volley; }
	@Override
	public Map<String, String> getBasket(String userid) { Map<String, String> basket = dao.getBasket(userid); return basket; }
	@Override
	public Map<String, String> getTennis(String userid) { Map<String, String> tennis = dao.getTennis(userid); return tennis; }
	@Override
	public Map<String, String> getBowling(String userid) { Map<String, String> bowling = dao.getBowling(userid); return bowling; }
	@Override
	public Map<String, String> getJokgu(String userid) { Map<String, String> jokgu = dao.getJokgu(userid); return jokgu; }
	@Override
	public Map<String, String> getMinton(String userid) { Map<String, String> minton = dao.getMinton(userid); return minton; }

	// 탈퇴 전 동호회장인지 알아보기
	@Override
	public int checkClubMaster(Map<String, String> paramap) {
		int n = dao.checkClubMaster(paramap);
		return n;
	}
	
	// 마이페이지 - 동호회 탈퇴
	@Override
	public int quitClub(Map<String, String> paramap) {
		int n = dao.quitClub(paramap);
		return n;
	}

	// 마이페이지 - 내동호회 관리
	@Override
	public List<ClubVO> getMyClub(String userid) {
		List<ClubVO> clubList = dao.getMyClub(userid);
		return clubList;
	}

	// 마이페이지 - 내 동호회 수정
	@Override
	public int updateClubInfo(ClubVO club) {
		int n = dao.updateClubInfo(club);
		return n;
	}

	// 마이페이지 - 내 동호회 삭제
	@Override
	public int deleteClub(String clubseq) {
		int n = dao.deleteClub(clubseq);
		int n2 = 0;
		if(n == 1) {
			n2 = dao.deleteClubMember(clubseq);
		}
		
		return n;
	}


	
	
}
