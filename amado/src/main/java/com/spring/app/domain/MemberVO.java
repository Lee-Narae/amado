package com.spring.app.domain;

import org.springframework.web.multipart.MultipartFile;

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
	private String gender;					// 성별   남자:1  / 여자:2
	private String birthday;			// 생년월일  
	private String registerday;			// 가입일자 
	private String lastpwdchangedate;	// 마지막으로 암호를 변경한 날짜 
	private String status;					// 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴)
	private String memberrank;				// 회원직급
	private String gymregisterstatus;		// 체육관등록여부
	private String speed;			
	private String quick;
	private String power;
	private String earth;
	private String stretch;
	private String memberimg;
	private MultipartFile attach;
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	private int idle;
	
	private int pwdchangegap;          // select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)
	private int lastlogingap;          // select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수(12개월 동안 로그인을 안 했을 경우 해당 로그인 계정을 비활성화 시키려고 함)

	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMemberrank() {
		return memberrank;
	}
	public void setMemberrank(String memberrank) {
		this.memberrank = memberrank;
	}
	public String getGymregisterstatus() {
		return gymregisterstatus;
	}
	public void setGymregisterstatus(String gymregisterstatus) {
		this.gymregisterstatus = gymregisterstatus;
	}
	public String getSpeed() {
		return speed;
	}
	public void setSpeed(String speed) {
		this.speed = speed;
	}
	public String getQuick() {
		return quick;
	}
	public void setQuick(String quick) {
		this.quick = quick;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
	public String getEarth() {
		return earth;
	}
	public void setEarth(String earth) {
		this.earth = earth;
	}
	public String getStretch() {
		return stretch;
	}
	public void setStretch(String stretch) {
		this.stretch = stretch;
	}
	public int getIdle() {
		return idle;
	}
	public void setIdle(int idle) {
		this.idle = idle;
	}
	public int getPwdchangegap() {
		return pwdchangegap;
	}
	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}
	public int getLastlogingap() {
		return lastlogingap;
	}
	public void setLastlogingap(int lastlogingap) {
		this.lastlogingap = lastlogingap;
	}
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}
	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	public String getMemberimg() {
		return memberimg;
	}
	public void setMemberimg(String memberimg) {
		this.memberimg = memberimg;
	}
}
