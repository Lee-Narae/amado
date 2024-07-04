package com.spring.app.domain;


public class GymVO {
/*
	ymseq          NUMBER          NOT NULL    -- 체육관번호(PK)
	,gymname      nvarchar2(30)   NOT NULL    -- 체육관명
	,fk_userid      nvarchar2(20)   NOT NULL    -- 담당자아이디(FK)
	,postcode      nvarchar2(5)    NOT NULL    -- 우편번호
	,address      nvarchar2(50)   NOT NULL    -- 주소
	,detailaddress   nvarchar2(100)  NOT NULL    -- 상세주소
	,extraaddress   nvarchar2(50)   NOT NULL    -- 주소참고항목
	,status          number(1)       NOT NULL    -- 운영여부
	,info          nvarchar2(1000) NOT NULL    -- 정보
	,imgfilename   nvarchar2(50)               -- 첨부파일
	,cost          NUMBER                      -- 비용
	,caution      nvarchar2(500)              -- 주의사항
	,membercount   NUMBER                      -- 인원
	,likecount       NUMBER                      -- 좋아요수
*/
	private String ymseq; 		    //체육관번호(PK)
	private String gymname;         //체육관명
	private String fk_userid;       //담당자아이디(FK)
	private String postcode;        //우편번호
	private String address;         //주소
	private String detailaddress;   //상세주소
	private String extraaddress;    //주소참고항목
	private String status;          //운영여부
	private String info;            //정보
	private String imgfilename;     //첨부파일
	private String cost;            //비용
	private String caution;         //주의사항
	private String membercount;     //인원
	private String likecount;       //좋아요수
	
	public String getYmseq() {
		return ymseq;
	}
	public void setYmseq(String ymseq) {
		this.ymseq = ymseq;
	}
	public String getGymname() {
		return gymname;
	}
	public void setGymname(String gymname) {
		this.gymname = gymname;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getImgfilename() {
		return imgfilename;
	}
	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}
	public String getCost() {
		return cost;
	}
	public void setCost(String cost) {
		this.cost = cost;
	}
	public String getCaution() {
		return caution;
	}
	public void setCaution(String caution) {
		this.caution = caution;
	}
	public String getMembercount() {
		return membercount;
	}
	public void setMembercount(String membercount) {
		this.membercount = membercount;
	}
	public String getLikecount() {
		return likecount;
	}
	public void setLikecount(String likecount) {
		this.likecount = likecount;
	}
	
	
	

}