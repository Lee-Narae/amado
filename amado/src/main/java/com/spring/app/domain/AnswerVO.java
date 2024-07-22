package com.spring.app.domain;

public class AnswerVO {

	private String gymanswerseq;
	private String gymquestionseq;
	private String content_reply;
	private String registerdate;
	private String fk_userid;
	private String changestatus;
	private String memberimg;
	

	public String getGymanswerseq() {
		return gymanswerseq;
	}
	public void setGymanswerseq(String gymanswerseq) {
		this.gymanswerseq = gymanswerseq;
	}
	public String getGymquestionseq() {
		return gymquestionseq;
	}
	public void setGymquestionseq(String gymquestionseq) {
		this.gymquestionseq = gymquestionseq;
	}
	
	
	
	public String getContent_reply() {
		return content_reply;
	}
	public void setContent_reply(String content_reply) {
		this.content_reply = content_reply;
	}
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getChangestatus() {
		return changestatus;
	}
	public void setChangestatus(String changestatus) {
		this.changestatus = changestatus;
	}
	public String getMemberimg() {
		return memberimg;
	}
	public void setMemberimg(String memberimg) {
		this.memberimg = memberimg;
	}
	
	
	
}
