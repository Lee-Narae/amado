package com.spring.app.domain;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {

	/*
		
		NOTICESEQ    NOT NULL NUMBER          
		TITLE        NOT NULL NVARCHAR2(50)   
		CONTENT      NOT NULL NVARCHAR2(1000) 
		REGISTERDATE NOT NULL DATE            
		VIEWCOUNT             NUMBER          
		STATUS       NOT NULL NUMBER(1)       
		ORGFILENAME           NVARCHAR2(50)   
		FILENAME              NVARCHAR2(50)   
		FILESIZE              NUMBER   

	*/
	
	
	private String noticeseq;
	private String title;
	private String content;
	private String registerdate;
	private String viewcount;
	private String status;
	private String orgfilename;
	private String filename;
	private String filesize;
	private String commentcount;
	
	
	// 이전글, 다음글 보기
	private String previousseq;
	private String previoustitle;
	private String nextseq;
	private String nexttitle;
	
	
	
	public String getPreviousseq() {
		return previousseq;
	}
	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}
	public String getPrevioustitle() {
		return previoustitle;
	}
	public void setPrevioustitle(String previoustitle) {
		this.previoustitle = previoustitle;
	}
	public String getNextseq() {
		return nextseq;
	}
	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}
	public String getNexttitle() {
		return nexttitle;
	}
	public void setNexttitle(String nexttitle) {
		this.nexttitle = nexttitle;
	}
	public String getCommentcount() {
		return commentcount;
	}
	public void setCommentcount(String commentcount) {
		this.commentcount = commentcount;
	}
	private MultipartFile attach;
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getNoticeseq() {
		return noticeseq;
	}
	public void setNoticeseq(String noticeseq) {
		this.noticeseq = noticeseq;
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
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
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

