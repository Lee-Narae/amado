package com.spring.app.model;

import com.spring.app.domain.GymVO;
import com.spring.app.domain.PhotoVO;

public interface AmadoDAO_HS {

	//체육관  완료 요쳥(파일 첨부o)
	int add_withFile(GymVO gymvo);

	int add_photofile(PhotoVO photovo);
	
	

}
