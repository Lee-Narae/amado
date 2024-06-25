package com.spring.app.domain;

public class MemberVO {

	private String userid;				// 회원아이디
	private String password;			// 비밀번호 (SHA-256 암호화 대상)
	private String name;				// 회원명
	private String email;				// 이메일 (AES-256 암호화/복호화 대상) (maxlength 가 60이지만 암호화 때문에 200글자로 설정해둠)
	private String postcode;			// 우편번호
	private String address;				// 주소
	private String detailaddress;		// 상세주소
	private String extraaddress;		// 참고항목
	private String mobile;				// 연락처 (AES-256 암호화/복호화 대상) 
	private int gender;					// 성별   남자:1  / 여자:2
	private String birthday;			// 생년월일  
	private String registerday;			// 가입일자 
	private String lastpwdchangedate;	// 마지막으로 암호를 변경한 날짜 
	private int status;					// 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴)
	private int memberrank;				// 회원직급
	private int gymregisterstatus;		// 체육관등록여부
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	public String getExtraaddress() {
		return extraaddress;
	}
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}
	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getMemberrank() {
		return memberrank;
	}
	public void setMemberrank(int memberrank) {
		this.memberrank = memberrank;
	}
	public int getGymregisterstatus() {
		return gymregisterstatus;
	}
	public void setGymregisterstatus(int gymregisterstatus) {
		this.gymregisterstatus = gymregisterstatus;
	}
	
	
	
	
	

}
