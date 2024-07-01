package com.spring.app.service;

import com.spring.app.domain.MemberVO;

// 승진 서비스
public interface AmadoService_SJ {

	// 아이디 중복 체크
	int idDuplicateCheck(String userid);

	// 이메일 중복 체크
	int emailDuplicateCheck(String email);

	// 회원가입
	int memberRegisterEnd(MemberVO membervo);

}
