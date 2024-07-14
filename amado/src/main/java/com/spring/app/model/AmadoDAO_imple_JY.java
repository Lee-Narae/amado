package com.spring.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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
	public void updateRank(String fk_userid) {
		sqlsession.update("JY.updateRank",fk_userid);
		
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
	public String getItemCnt() {
		
		String itemCnt = sqlsession.selectOne("JY.getItemCnt");
		return itemCnt;
	}

	
	// 쿠키
	@Override
	public FleamarketVO goodsDetailData(int goodsSeq) {
		FleamarketVO gDetailData = sqlsession.selectOne("JY.goodsDetailData", goodsSeq);
		return gDetailData;
	}


}
