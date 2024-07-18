package com.spring.app.domain;

import org.springframework.web.multipart.MultipartFile;

public class ClubBoardVO {

	private String clubboardseq;
	private String clubseq;
	private String title;
	private String content;
	private String fk_userid;
	private String registerdate;
	private String password;
	private String commentcount;
	private String viewcount;
	private String status;
	private String orgfilename;
	private String filename;
	private String filesize;
	
	private MultipartFile attach;
	   /* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	         진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	             조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_comment 테이블의 컬럼이 아니다.   
	      /board/src/main/webapp/WEB-INF/views/tiles1/board/view.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	        동일해야만 파일첨부가 가능해진다.!!!!
	 */
	private String wasfileName;    // WAS(톰캣)에 저장될 파일명(2024070109291535243254235235234.png) 

	
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getWasfileName() {
		return wasfileName;
	}
	public void setWasfileName(String wasfileName) {
		this.wasfileName = wasfileName;
	}
	public String getClubboardseq() {
		return clubboardseq;
	}
	public void setClubboardseq(String clubboardseq) {
		this.clubboardseq = clubboardseq;
	}
	public String getClubseq() {
		return clubseq;
	}
	public void setClubseq(String clubseq) {
		this.clubseq = clubseq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCommentcount() {
		return commentcount;
	}
	public void setCommentcount(String commentcount) {
		this.commentcount = commentcount;
	}
	public String getViewcount() {
		return viewcount;
	}
	public void setViewcount(String viewcount) {
		this.viewcount = viewcount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOrgfilename() {
		return orgfilename;
	}
	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	
	
	
}
