package com.spring.app.domain;

public class BoardCommentVO {

/*
boardcommentseq          NUMBER                                   -- 댓글번호(PK)
,parentseq                NUMBER                                   -- 게시판번호(FK)
,comment_text             nvarchar2(200)                           -- 댓글내용(시)
,registerdate             DATE DEFAULT SYSDATE NOT NULL            -- 댓글작성일자
,fk_userid                nvarchar2(20)                            -- 아이디(FK) 	
*/
	
	private String boardcommentseq, parentseq, comment_text, registerdate, fk_userid, status, groupno, fk_boardcommentseq, depthno, changestatus;

	public String getBoardcommentseq() {
		return boardcommentseq;
	}

	public void setBoardcommentseq(String boardcommentseq) {
		this.boardcommentseq = boardcommentseq;
	}

	public String getParentseq() {
		return parentseq;
	}

	public void setParentseq(String parentseq) {
		this.parentseq = parentseq;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_boardcommentseq() {
		return fk_boardcommentseq;
	}

	public void setFk_boardcommentseq(String fk_boardcommentseq) {
		this.fk_boardcommentseq = fk_boardcommentseq;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}

	public String getChangestatus() {
		return changestatus;
	}

	public void setChangestatus(String changestatus) {
		this.changestatus = changestatus;
	}
	
	
	
	
	
}
