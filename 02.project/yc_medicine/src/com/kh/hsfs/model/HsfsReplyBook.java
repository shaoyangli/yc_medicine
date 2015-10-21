package com.kh.hsfs.model;

public class HsfsReplyBook implements java.io.Serializable{
	private Integer id;
	private Integer lyid;
	private String content;
	private String replyTime;
    private String  replyAuthor;
    private String expression;
    private String  authorIP;
    private Integer userId;
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getAuthorIP() {
		return authorIP;
	}
	public void setAuthorIP(String authorIP) {
		this.authorIP = authorIP;
	}
	public String getExpression() {
		return expression;
	}
	public void setExpression(String expression) {
		this.expression = expression;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getLyid() {
		return lyid;
	}
	public void setLyid(Integer lyid) {
		this.lyid = lyid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}
	public String getReplyAuthor() {
		return replyAuthor;
	}
	public void setReplyAuthor(String replyAuthor) {
		this.replyAuthor = replyAuthor;
	}
    
}
