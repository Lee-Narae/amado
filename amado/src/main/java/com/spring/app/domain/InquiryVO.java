package com.spring.app.domain;

public class InquiryVO {
	
	private String inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status;
	
	private InquiryFileVO inquiryfilevo;

	public String getInquiryseq() {
		return inquiryseq;
	}

	public void setInquiryseq(String inquiryseq) {
		this.inquiryseq = inquiryseq;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRegisterdate() {
		return registerdate;
	}

	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}

	public String getSearchtype_a() {
		return searchtype_a;
	}

	public void setSearchtype_a(String searchtype_a) {
		this.searchtype_a = searchtype_a;
	}

	public String getSearchtype_b() {
		return searchtype_b;
	}

	public void setSearchtype_b(String searchtype_b) {
		this.searchtype_b = searchtype_b;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public InquiryFileVO getInquiryfilevo() {
		return inquiryfilevo;
	}

	public void setInquiryfilevo(InquiryFileVO inquiryfilevo) {
		this.inquiryfilevo = inquiryfilevo;
	}

	
	
}
