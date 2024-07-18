package com.spring.app.service;

import java.util.List;

import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;

public interface AmadoService_HS {



	int add_withFile(GymVO gymvo);

	
	int add_photofile(PhotoVO photovo);


	List<GymVO> getAllGymList();

	





}
