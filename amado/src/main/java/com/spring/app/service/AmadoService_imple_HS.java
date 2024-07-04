package com.spring.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.FileManager;
import com.spring.app.domain.GymVO;

@Service
public class AmadoService_imple_HS implements AmadoService_HS {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
		@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
		private GymVO dao;
	
	// ===#186. 첨부파일 삭제를 위한것 ==
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	
	


}
