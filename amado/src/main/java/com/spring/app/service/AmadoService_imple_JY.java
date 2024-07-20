package com.spring.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.FileManager;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.NoticeVO;
import com.spring.app.model.AmadoDAO_JY;

@Service
public class AmadoService_imple_JY implements AmadoService_JY {
	
	@Autowired
	private AmadoDAO_JY dao;

 	// 첨부파일 삭제를 위한것 
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	
	
	
	//////////////////////////////////////////////
	



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


	// 동호회등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(ClubVO clubvo) {
		int n = dao.add_withFile(clubvo); //첨부파일이 있는경우
		return n;
	}
	
	

	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	@Override
	public int updateRank(String fk_userid) {
		int n = dao.updateRank(fk_userid);
		return n;
	}
	
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	@Override
	public void insertCmemberTbl(ClubVO clubvo) {
		dao.insertCmemberTbl(clubvo);
			
	}

	// 상품 select 헤오기
	@Override
	public List<Map<String, String>> getSportNameList(String sportname) {
		List<Map<String, String>> sportNameList = dao.getSportNameList(sportname);
		return sportNameList;
	}


	// 상품등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(FleamarketVO fvo) {
		int n = dao.add_withFile(fvo); //첨부파일이 있는경우
		return n;
	}


	// 모든 상품 select 해오기
	@Override
	public List<FleamarketVO> getAllItemList() {
		List<FleamarketVO> allItemList = dao.getAllItemList();
		return allItemList;
	}


	// 상품 전체 개수 불러오기
	@Override
	public int getItemCnt(Map<String, String> paraMap) {
		int itemCnt = dao.getItemCnt(paraMap);
		return itemCnt;
	}




	// 동일한 종목의 동호회 가입하는지 확인
	@Override
	public String checkseq(Map<String, String> paraMap) {
		String checkseq = dao.checkseq(paraMap);
		return checkseq;
	}



	// 동호회 게시판 - 총페이지수
	@Override
	public int getTotalPage(Map<String, String> paramap) {
		int n = dao.getTotalPage(paramap);
		return n;
	}


	// 동호회 게시판 - 페이징처리
	@Override
	public List<ClubBoardVO> select_clubboard_paging(Map<String, String> paramap) {
		List<ClubBoardVO> clubboardList = dao.select_clubboard_paging(paramap);
		return clubboardList;
	}


	// 동호회 게시판 - 게시글 개수
	@Override
	public int getTotalCount(Map<String, String> paramap) {
		int n = dao.getTotalCount(paramap);
		return n;
	}


	// 동호회 게시판 - 디테일
	@Override
	public ClubBoardVO getClubboardDetail(Map<String, String> paramap) {
		ClubBoardVO cboard = dao.getClubboardDetail(paramap);
		return cboard;
	}


	// 동호회게시판 조회수 올리기
	@Override
	public void updateCboardViewcount(String clubboardseq) {
		dao.updateCboardViewcount(clubboardseq);
		
	}



	


	


	
	












	

	
	
	
	
	

}
