package com.spring.app.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;

@Repository
public class AmadoDAO_imple_HS implements AmadoDAO_HS {

	@Autowired // @Autowired 이것을 적고나면, 이미 SqlSessionTemplate 이 타입의 bean이 생성되어져있기에 초기값이 null이 아닌  bean id="sqlsession"이 된다.
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	
	
	
	
	//체욱관 등록
	@Override
	public int add_withFile(GymVO gymvo) {
		int n = sqlsession.insert("HS.add_withFile", gymvo);
		return n;
	}





	@Override
	public int add_photofile(PhotoVO pthotovo) {
		int n = sqlsession.insert("HS.add_photofile", pthotovo);
		return n;
	}





	@Override
	public List<GymVO> getAllGymList() {
	      //리턴타입이 맵인경우 = 맵퍼에서 resultType이 map? 인경우에만 <result>쓴다.  지금은 x
	      List<GymVO> allGymList = sqlsession.selectList("HS.getAllGymList");
	      return allGymList;
	}


}
