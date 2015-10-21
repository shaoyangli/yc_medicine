package com.kh.hsfs.model;

public class HsfsEmail implements java.io.Serializable {

	private int id;
	private String title;
	private String content;
	private String senddate;
	private String sendperson;//发送人姓名
	private String sendid;//发送人工号
	private String sendOrgName;//发送人机构名字
	private String receiveid;//邮件接收人工号
	private String receivename;
	private String readedid = ",";//已阅读用户工号
	private String deledId=",";//已删除邮件工号
	private int isf;//是否含有附件,0表示没有,1 有
	private int flag;//标识是否从发件箱删除 0未 1 删除

	public int getId() {
		return id;
	}

	public int getIsf() {
		return isf;
	}

	public void setIsf(int isf) {
		this.isf = isf;
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

	public String getSenddate() {
		return senddate;
	}

	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}

	public String getSendperson() {
		return sendperson;
	}

	public void setSendperson(String sendperson) {
		this.sendperson = sendperson;
	}

	public String getSendid() {
		return sendid;
	}

	public void setSendid(String sendid) {
		this.sendid = sendid;
	}

	public String getReceiveid() {
		return receiveid;
	}

	public void setReceiveid(String receiveid) {
		this.receiveid = receiveid;
	}

	public String getReadedid() {
		return readedid;
	}

	public void setReadedid(String readedid) {
		this.readedid = readedid;
	}

	public String getSendOrgName() {
		return sendOrgName;
	}

	public void setSendOrgName(String sendOrgName) {
		this.sendOrgName = sendOrgName;
	}

	public String getDeledId() {
		return deledId;
	}

	public void setDeledId(String deledId) {
		this.deledId = deledId;
	}

	public String getReceivename() {
		return receivename;
	}

	public void setReceivename(String receivename) {
		this.receivename = receivename;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}
}