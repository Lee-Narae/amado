package com.spring.app.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketVO;

public interface AmadoService_JY {

	

	// 시군구 정보
	List<Map<String, String>> getCityList();

	// 상세지역 정보
	List<String> getLocalList(String cityname);
	
	// 동호회등록  완료 요청(파일첨부ㅇ)
	int add_withFile(ClubVO clubvo);

	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	int updateRank(String string);
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	void insertCmemberTbl(ClubVO clubvo);

	// 카테고리 상품 select 해오기
	List<Map<String, String>> getSportNameList(String sportname);

	// 상품등록  완료 요청(파일첨부ㅇ)
	int add_withFile(FleamarketVO fvo);

	// 모든 상품 select 해오기
	List<FleamarketVO> getAllItemList();

	// 상품 전체 개수 불러오기
	int getItemCnt(Map<String, String> paraMap);

	// 쿠키
	FleamarketVO goodsDetailData(int goodsSeq);

	// 동일한 종목의 동호회 가입하는지 확인
	String checkseq(Map<String, String> paraMap);

	int getNoticeTotalPage(Map<String, String> paramap);






	
	

}
