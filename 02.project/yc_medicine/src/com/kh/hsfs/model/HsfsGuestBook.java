package com.kh.hsfs.model;

public class HsfsGuestBook implements java.io.Serializable{
	private Integer id;
	private String lytitle;
	private String lyauthor;
	private String expression;
	private String lytime;
	private Integer answernum;
	private Integer clickNum;
	private String authorIp;
	private String lyclass1;
	private String lyclass2;
	private String lycontent;
	private String lasttime;
	private String lytype;
	private String lastAuthor;
	private Integer userId;
	private Integer replyUserId;
	
	
	public Integer getReplyUserId() {
		return replyUserId;
	}
	public void setReplyUserId(Integer replyUserId) {
		this.replyUserId = replyUserId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getLastAuthor() {
		return lastAuthor;
	}
	public void setLastAuthor(String lastAuthor) {
		this.lastAuthor = lastAuthor;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLytitle() {
		return lytitle;
	}
	public void setLytitle(String lytitle) {
		this.lytitle = lytitle;
	}
	public String getLyauthor() {
		return lyauthor;
	}
	public void setLyauthor(String lyauthor) {
		this.lyauthor = lyauthor;
	}
	public String getExpression() {
		return expression;
	}
	public void setExpression(String expression) {
		this.expression = expression;
	}
	public String getLytime() {
		return lytime;
	}
	public void setLytime(String lytime) {
		this.lytime = lytime;
	}
	public Integer getAnswernum() {
		return answernum;
	}
	public void setAnswernum(Integer answernum) {
		this.answernum = answernum;
	}
	public Integer getClickNum() {
		return clickNum;
	}
	public void setClickNum(Integer clickNum) {
		this.clickNum = clickNum;
	}
	public String getAuthorIp() {
		return authorIp;
	}
	public void setAuthorIp(String authorIp) {
		this.authorIp = authorIp;
	}
	public String getLyclass1() {
		return lyclass1;
	}
	public void setLyclass1(String lyclass1) {
		this.lyclass1 = lyclass1;
	}
	public String getLyclass2() {
		return lyclass2;
	}
	public void setLyclass2(String lyclass2) {
		this.lyclass2 = lyclass2;
	}
	public String getLycontent() {
		return lycontent;
	}
	public void setLycontent(String lycontent) {
		this.lycontent = lycontent;
	}
	public String getLasttime() {
		return lasttime;
	}
	public void setLasttime(String lasttime) {
		this.lasttime = lasttime;
	}
	public String getLytype() {
		return lytype;
	}
	public void setLytype(String lytype) {
		this.lytype = lytype;
	}
	
	

}
