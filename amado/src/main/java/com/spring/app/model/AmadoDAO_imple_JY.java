package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.ClubVO;
import com.spring.app.domain.FleamarketVO;

@Repository
public class AmadoDAO_imple_JY implements AmadoDAO_JY {

	@Autowired				 
	@Qualifier("sqlsession") 
	private SqlSessionTemplate sqlsession;

	
	////////////////////////////////////////////////////////////////
	

	// 시군구 정보
	@Override
	public List<Map<String, String>> getCityList() {
		List<Map<String, String>> cityList = sqlsession.selectList("JY.getCityList");
		return cityList;
	}

	// 상세지역 정보
	@Override
	public List<String> getLocalList(String cityname) {
		List<String> localList = sqlsession.selectList("JY.getLocalList", cityname);
		return localList;
	}
	
	
	// 동호회등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(ClubVO clubvo) {
		int n = sqlsession.insert("JY.add_withFile",clubvo);
		return n;

	}

	
	// 동호회 등록후 회원등급 동호회장으로  업데이트 해주기
	@Override
	public int updateRank(String fk_userid) {
		int n = sqlsession.update("JY.updateRank",fk_userid);
		return n;
	}
	
	// 동호회 등록완료 하면 tbl_clubmember 에 insert 하기
	@Override
	public void insertCmemberTbl(ClubVO clubvo) {
		sqlsession.insert("JY.insertCmemberTbl",clubvo);
	}

	
	// 운동 종목 시퀀스가져오기
	@Override
	public List<String> getSportList() {
		List<String> sportList = sqlsession.selectList("JY.getSportList");
		return sportList;
	}

	
	// 상품 select 헤오기
	@Override
	public List<Map<String, String>> getSportNameList(String sportname) {
		List<Map<String, String>> sportNameList = sqlsession.selectList("JY.getSportNameList", sportname);
		return sportNameList;
	}

	// 상품등록  완료 요청(파일첨부ㅇ)
	@Override
	public int add_withFile(FleamarketVO fvo) {
		int n = sqlsession.insert("JY.add_withFilee",fvo);
		return n;
	}

	// 모든 상품 select 해오기
	@Override
	public List<FleamarketVO> getAllItemList() { 
		//리턴타입이 맵인경우 = 맵퍼에서 resultType이 map? 인경우에만 <result>쓴다.  지금은 x
		List<FleamarketVO> allItemList = sqlsession.selectList("JY.getAllItemList");
		return allItemList;
	}

	// 상품 전체 개수 불러오기
	@Override
	public int getItemCnt(Map<String, String> paraMap) {
		int itemCnt = sqlsession.selectOne("JY.getItemCnt", paraMap);
		return itemCnt;
	}
	
	
	// 쿠키
	@Override
	public FleamarketVO goodsDetailData(int goodsSeq) {
		FleamarketVO gDetailData = sqlsession.selectOne("JY.goodsDetailData", goodsSeq);
		return gDetailData;
	}

	// 동일한 종목의 동호회 가입하는지 확인
	@Override
	public String checkseq(Map<String, String> paraMap) {
		String checkseq = sqlsession.selectOne("JY.checkseq", paraMap);
		return checkseq;
	}

	
	// 동호회 게시판 전체 게시글수

	// 글목록 가져오기

	




}
