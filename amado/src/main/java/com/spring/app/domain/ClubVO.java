package com.spring.app.domain;

public class ClubVO {

	/*
	
		CLUBSEQ     NOT NULL NUMBER        
		CLUBNAME    NOT NULL NVARCHAR2(20) 
		CLUBIMG              NVARCHAR2(50) 
		SPORTSEQ    NOT NULL NUMBER        
		FK_USERID   NOT NULL NVARCHAR2(20) 
		CLUBTEL     NOT NULL NVARCHAR2(50) 
		CITY        NOT NULL NVARCHAR2(50) 
		LOCAL       NOT NULL NVARCHAR2(50) 
		CLUBGYM     NOT NULL NVARCHAR2(20) 
		CLUBTIME    NOT NULL NVARCHAR2(30) 
		MEMBERCOUNT NOT NULL NUMBER        
		CLUBPAY     NOT NULL NUMBER        
		CLUBSTATUS  NOT NULL NUMBER(1)     
		CLUBSCORE   NOT NULL NUMBER     
	
	 */
	
	private String clubseq; 		// 동호회 시퀀스
	private String clubname;		// 동호회 명
	private String clubimg;			// 대표 이미지
	private String fk_sportseq;		// 종목 번호
	private String clubtel;			// 연락처
	private String city;			// 시/도
	private String local;			// 구
	private String clubgym;			// 활동 체육관			
	private String clubtime;		// 활동 시간
	private String membercount;		// 인원
	private String clubpay; 		// 회비
	private String clubstatus;		// 운영 상태
	private String clubscore;		// 점수
	
	private String rank; // select 용 랭킹  
	

	public String getClubseq() {
		return clubseq;
	}
	public void setClubseq(String clubseq) {
		this.clubseq = clubseq;
	}
	public String getClubname() {
		return clubname;
	}
	public void setClubname(String clubname) {
		this.clubname = clubname;
	}
	public String getClubimg() {
		return clubimg;
	}
	public void setClubimg(String clubimg) {
		this.clubimg = clubimg;
	}
	public String getFk_sportseq() {
		return fk_sportseq;
	}
	public void setFk_sportseq(String fk_sportseq) {
		this.fk_sportseq = fk_sportseq;
	}
	public String getClubtel() {
		return clubtel;
	}
	public void setClubtel(String clubtel) {
		this.clubtel = clubtel;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getLocal() {
		return local;
	}
	public void setLocal(String local) {
		this.local = local;
	}
	public String getClubgym() {
		return clubgym;
	}
	public void setClubgym(String clubgym) {
		this.clubgym = clubgym;
	}
	public String getClubtime() {
		return clubtime;
	}
	public void setClubtime(String clubtime) {
		this.clubtime = clubtime;
	}
	public String getMembercount() {
		return membercount;
	}
	public void setMembercount(String membercount) {
		this.membercount = membercount;
	}
	public String getClubpay() {
		return clubpay;
	}
	public void setClubpay(String clubpay) {
		this.clubpay = clubpay;
	}
	public String getClubstatus() {
		return clubstatus;
	}
	public void setClubstatus(String clubstatus) {
		this.clubstatus = clubstatus;
	}
	public String getClubscore() {
		return clubscore;
	}
	public void setClubscore(String clubscore) {
		this.clubscore = clubscore;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}

	
	
	
	
	
}
