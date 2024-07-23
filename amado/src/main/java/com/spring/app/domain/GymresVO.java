package com.spring.app.domain;

public class GymresVO {

	private String gymresseq;
	private String fk_gymseq;
	private String fk_userid;
	private String reservation_date;
	private String time;
	
	public String getGymresseq() {
		return gymresseq;
	}
	public void setGymresseq(String gymresseq) {
		this.gymresseq = gymresseq;
	}
	public String getFk_gymseq() {
		return fk_gymseq;
	}
	public void setFk_gymseq(String fk_gymseq) {
		this.fk_gymseq = fk_gymseq;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getReservation_date() {
		return reservation_date;
	}
	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
	
	
}
