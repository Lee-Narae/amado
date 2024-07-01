package com.spring.app.model;

import com.spring.app.domain.MemberVO;

public interface AmadoDAO_SJ {

	// 아이디 중복 체크
	int idDuplicateCheck(String userid);

	// 이메일 중복 체크
	int emailDuplicateCheck(String email);

	// 회원가입
//	int memberRegisterEnd(MemberVO membervo);

}
