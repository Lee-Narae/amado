package com.spring.app.domain;

public class ClubBoardCommentVO {
	private String clubboardcommentseq;
	private String clubboardseq;
	private String comment_text;
	private String registerdate;
	private String fk_userid;
	
	
	public String getClubboardcommentseq() {
		return clubboardcommentseq;
	}
	public void setClubboardcommentseq(String clubboardcommentseq) {
		this.clubboardcommentseq = clubboardcommentseq;
	}
	public String getClubboardseq() {
		return clubboardseq;
	}
	public void setClubboardseq(String clubboardseq) {
		this.clubboardseq = clubboardseq;
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
