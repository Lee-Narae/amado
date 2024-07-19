package com.spring.app.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubBoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketVO;
import com.spring.app.domain.NoticeVO;

public interface AmadoDAO_JY {
	
	
	// 시군구 정보
	List<Map<String, String>> getCityList();
	
	// 상세지역 정보
	List<String> getLocalList(String cityname);
	
	// 동호회등록  완료 요청(파일첨부ㅇ)
	int add_withFile(ClubVO clubvo);

	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	int updateRank(String fk_userid);
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	void insertCmemberTbl(ClubVO clubvo);

	// 운동 종목 시퀀스가져오기
	List<String> getSportList();

	// 상품 select 헤오기
	List<Map<String, String>> getSportNameList(String sportname);

	// 상품등록  완료 요청(파일첨부ㅇ)
	int add_withFile(FleamarketVO fvo);
	
	// 모든 상품 select 해오기
	List<FleamarketVO> getAllItemList();

	// 상품 전체 개수 불러오기
	int getItemCnt(Map<String, String> paraMap);
	

	// 동일한 종목의 동호회 가입하는지 확인
	String checkseq(Map<String, String> paraMap);

	// 동호회 게시판 - 총페이지수
	int getTotalPage(Map<String, String> paramap);

	// 돌아갈페이지
	List<ClubBoardVO> select_clubboard_paging(Map<String, String> paramap);

	// 동호회 게시판 - 게시글 개수
	int getTotalCount(Map<String, String> paramap);

	// 동호회 게시판 - 디테일
	ClubBoardVO getClubboardDetail(Map<String, String> paramap);

	// 동호회게시판 조회수 올리기
	void updateCboardViewcount(String clubboardseq);



	

	
		
}
