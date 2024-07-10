package com.spring.app.domain;

public class PhotoVO {

	private String photo_id;               //사진 고유 ID 	
	private String fk_gymseq;              //체육관 번호 (FK)
	private String several_photos;         //여러개 사진첨부
	public String getPhoto_id() {
		return photo_id;
	}
	public void setPhoto_id(String photo_id) {
		this.photo_id = photo_id;
	}
	public String getFk_gymseq() {
		return fk_gymseq;
	}
	public void setFk_gymseq(String fk_gymseq) {
		this.fk_gymseq = fk_gymseq;
	}
	public String getSeveral_photos() {
		return several_photos;
	}
	public void setSeveral_photos(String several_photos) {
		this.several_photos = several_photos;
	}
}
