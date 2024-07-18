package com.spring.app.domain;

public class QuestionVO {
	
	
	private String gymquestionseq;   //체육관문의번호(PK)
	private String gymseq;  //체육관번호(FK)
	private String category;  //카테고리
	private String content;   //문의내용
	private String fk_userid;  //작성자아이디
	private String registerdate;  //작성일자
	private String changestatus;
	private String recommentcount;
	private String memberimg;
	
	
	
	
	public String getMemberimg() {
		return memberimg;
	}
	public void setMemberimg(String memberimg) {
		this.memberimg = memberimg;
	}
	public String getGymquestionseq() {
		return gymquestionseq;
	}
	public void setGymquestionseq(String gymquestionseq) {
		this.gymquestionseq = gymquestionseq;
	}
	public String getGymseq() {
		return gymseq;
	}
	public void setGymseq(String gymseq) {
		this.gymseq = gymseq;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	public String getChangestatus() {
		return changestatus;
	}
	public void setChangestatus(String changestatus) {
		this.changestatus = changestatus;
	}
	public String getRecommentcount() {
		return recommentcount;
	}
	public void setRecommentcount(String recommentcount) {
		this.recommentcount = recommentcount;
	}

	
	
	
	
}
