package com.kh.hsfs.model;
/**
 * 系统公告实体
 * @author Administrator
 *
 */

public class Notice implements java.io.Serializable {

	private int id;
	private String title;
	private String content;
	private String date;
	private String sendPerson;// 公告发布人
	private String loginID = ",";//公告已经阅读过的用户的工号

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getSendPerson() {
		return sendPerson;
	}

	public void setSendPerson(String sendPerson) {
		this.sendPerson = sendPerson;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
}