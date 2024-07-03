package com.spring.app.domain;

public class FleamarketCommentVO {

	private String fleamarketcommentseq;
	private String fleamarketseq;
	private String comment_text;
	private String registerdate;
	private String fk_userid;
	private String memberimg;
	
	
	
	public String getMemberimg() {
		return memberimg;
	}
	public void setMemberimg(String memberimg) {
		this.memberimg = memberimg;
	}
	public String getFleamarketcommentseq() {
		return fleamarketcommentseq;
	}
	public void setFleamarketcommentseq(String fleamarketcommentseq) {
		this.fleamarketcommentseq = fleamarketcommentseq;
	}
	public String getFleamarketseq() {
		return fleamarketseq;
	}
	public void setFleamarketseq(String fleamarketseq) {
		this.fleamarketseq = fleamarketseq;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
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
	
	
	
}
